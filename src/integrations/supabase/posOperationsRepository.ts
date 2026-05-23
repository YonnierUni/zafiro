import type { RealtimeChannel } from '@supabase/supabase-js';
import type {
  AddOrderItemInput,
  CreatePosTableInput,
  OrderFinancialStatus,
  OrderOperationalStatus,
  PaymentAllocationMode,
  PaymentMethod,
  PaymentStatus,
  PosOrder,
  PosOrderComputedSummary,
  PosOrderItem,
  PosOrderStatusLog,
  PosOrderWithRelations,
  PosPayment,
  PosProductOption,
  PosState,
  PosTable,
  PosTableWithOrder,
  PreparationArea,
  RecordPaymentInput,
  StaffProfile,
  StaffRole,
  UpdateOrderItemInput,
} from '../../shared/operations/operations.types';
import { getSupabaseClient } from './client';
import type { Database } from './database.types';

type MenuItemPublicRow = Database['public']['Views']['menu_items_public']['Row'];
type PosTableRow = Database['public']['Tables']['pos_tables']['Row'];
type PosOrderRow = Database['public']['Tables']['pos_orders']['Row'];
type PosOrderItemRow = Database['public']['Tables']['pos_order_items']['Row'];
type PosPaymentRow = Database['public']['Tables']['pos_payments']['Row'];
type PosLogRow = Database['public']['Tables']['pos_order_status_logs']['Row'];
type StaffProfileRow = Database['public']['Tables']['staff_profiles']['Row'];

export interface PosActorContext {
  email: string;
  roles: StaffRole[];
}

export interface ReplaceOrderItemInput extends AddOrderItemInput {
  reason: string;
}

export interface UpdatePaymentStatusInput {
  notes?: string;
  rejectionReason?: string;
  status: Extract<PaymentStatus, 'confirmed' | 'rejected'>;
}

const TERMINAL_ITEM_STATUSES = new Set<OrderOperationalStatus>(['delivered', 'cancelled']);
const DRAFT_EDITABLE_STATUSES = new Set<OrderOperationalStatus>(['draft']);
const CONTROLLED_CANCEL_STATUSES = new Set<OrderOperationalStatus>(['draft', 'sent', 'pending_preparation']);
const KITCHEN_PRODUCT_TYPES = new Set(['comida']);
const BAR_PRODUCT_TYPES = new Set(['cocteles', 'micheladas', 'jugos-y-limonadas', 'bebidas']);

export async function loadPosStateFromSupabase(): Promise<PosState> {
  const supabase = getSupabaseClient();
  const [tables, orders, items, payments, logs] = await Promise.all([
    supabase.from('pos_tables').select('*').order('code', { ascending: true }),
    supabase.from('pos_orders').select('*').order('opened_at', { ascending: false }),
    supabase.from('pos_order_items').select('*').order('created_at', { ascending: true }),
    supabase.from('pos_payments').select('*').order('created_at', { ascending: true }),
    supabase.from('pos_order_status_logs').select('*').order('created_at', { ascending: false }).limit(120),
  ]);

  throwIfError(tables.error, 'No fue posible leer las mesas POS');
  throwIfError(orders.error, 'No fue posible leer las ordenes POS');
  throwIfError(items.error, 'No fue posible leer las lineas POS');
  throwIfError(payments.error, 'No fue posible leer los pagos POS');
  throwIfError(logs.error, 'No fue posible leer la trazabilidad POS');

  const ordersWithRelations = buildOrdersWithRelations(orders.data ?? [], items.data ?? [], payments.data ?? []);
  const tablesWithOrders = buildTablesWithOrders(tables.data ?? [], ordersWithRelations);
  const tablesById = new Map((tables.data ?? []).map((table) => [table.id, table]));
  const pendingPreparationItems = ordersWithRelations
    .flatMap((order) =>
      order.items.map((item) => {
        const table = tablesById.get(order.tableId);
        return {
          ...item,
          orderAssignedStaffEmail: order.assignedStaffEmail,
          orderOpenedByEmail: order.openedByEmail,
          tableCode: table?.code ?? null,
          tableId: order.tableId,
          tableName: table?.name ?? null,
        };
      }),
    )
    .filter((item) => !TERMINAL_ITEM_STATUSES.has(item.operationalStatus) && item.operationalStatus !== 'draft')
    .sort((left, right) => resolvePreparationQueueTimestamp(left).localeCompare(resolvePreparationQueueTimestamp(right)));

  return {
    generatedAt: new Date().toISOString(),
    roles: [],
    staffProfile: null,
    tables: tablesWithOrders,
    openOrders: ordersWithRelations.filter((order) => order.closedAt == null),
    pendingPreparationKitchen: pendingPreparationItems.filter((item) => item.prepArea === 'kitchen'),
    pendingPreparationBar: pendingPreparationItems.filter((item) => item.prepArea === 'bar'),
    pendingPayments: (payments.data ?? []).map(mapPosPaymentRow).filter((payment) => payment.status === 'pending'),
    logs: (logs.data ?? []).map(mapPosLogRow),
  };
}

export async function loadPosProductOptionsFromSupabase() {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from('menu_items_public')
    .select('*')
    .eq('visible', true)
    .eq('disponible', true)
    .order('tipo', { ascending: true })
    .order('subgrupo', { ascending: true })
    .order('orden', { ascending: true })
    .order('name', { ascending: true });

  throwIfError(error, 'No fue posible cargar el catalogo operativo para POS');

  return (data ?? []).map(mapMenuItemPublicRow);
}

export async function createPosTableInSupabase(input: CreatePosTableInput, actor: PosActorContext) {
  const normalizedCode = input.code.trim().toUpperCase();
  const normalizedName = input.name.trim();

  if (!normalizedCode) {
    throw new Error('La mesa debe tener un codigo antes de crearse.');
  }

  if (!normalizedName) {
    throw new Error('La mesa debe tener un nombre antes de crearse.');
  }

  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from('pos_tables')
    .insert({
      code: normalizedCode,
      name: normalizedName,
      type: input.type,
      zone: input.zone,
      capacity: input.capacity ?? null,
      notes: input.notes?.trim() ?? '',
      status: 'available',
      assigned_staff_email: actor.email,
    } as never)
    .select('*')
    .single();

  throwIfError(error, 'No fue posible crear la mesa');
  await insertPosLog({
    actor,
    afterData: data,
    eventType: 'table_created',
    notes: `Mesa ${normalizedCode} creada`,
    tableId: data.id,
  });
  return mapPosTableRow(data);
}

export async function deletePosTableInSupabase(tableId: string, actor: PosActorContext) {
  const supabase = getSupabaseClient();
  const table = await getTableById(tableId);

  if (table.activeOrderId) {
    throw new Error('No puedes eliminar una mesa con una cuenta activa.');
  }

  if (table.status === 'occupied') {
    throw new Error('No puedes eliminar una mesa que sigue marcada como ocupada.');
  }

  const { error } = await supabase.from('pos_tables').delete().eq('id', tableId);
  throwIfError(error, 'No fue posible eliminar la mesa');

  await insertPosLog({
    actor,
    afterData: {
      deleted: true,
      tableCode: table.code,
      tableName: table.name,
    },
    beforeData: table,
    eventType: 'table_deleted',
    notes: `Mesa ${table.code} eliminada`,
  });
}

export async function addItemsToTableInSupabase(tableId: string, items: AddOrderItemInput[], actor: PosActorContext) {
  if (!items.length) {
    throw new Error('No hay productos para agregar a la mesa.');
  }

  const supabase = getSupabaseClient();
  const table = await getTableById(tableId);
  const order = await ensureOpenOrderForTable(table, actor);
  const existingItems = await loadOrderItems(order.id);
  const nextRound = Math.max(0, ...existingItems.map((item) => item.serviceRound)) + 1;

  const rows = items.map((item) => ({
    order_id: order.id,
      menu_item_source_key: item.menuItemSourceKey,
      product_name: item.productName.trim(),
      product_slug: item.productSlug.trim(),
      prep_area: derivePreparationAreaFromProductType(item.productType),
    quantity: item.quantity,
    unit_price: item.unitPrice,
    total_price: item.unitPrice * item.quantity,
    service_round: nextRound,
    operational_status: 'draft',
    financial_status: 'pending_payment',
    notes: item.notes?.trim() ?? '',
    created_by_email: actor.email,
    updated_by_email: actor.email,
  }));

  const { data, error } = await supabase.from('pos_order_items').insert(rows as never).select('*');
  throwIfError(error, 'No fue posible agregar productos a la mesa');

  await touchTableOccupation(order.tableId, order.id, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    eventType: 'items_added',
    notes: `${items.length} linea(s) agregadas a ${table.code}`,
    orderId: order.id,
    tableId: order.tableId,
  });

  return data?.map(mapPosOrderItemRow) ?? [];
}

export async function updateOrderItemInSupabase(itemId: string, patch: UpdateOrderItemInput, actor: PosActorContext, currentItemOverride?: PosOrderItem) {
  const currentItem = currentItemOverride ?? (await getOrderItemById(itemId));

  if (!DRAFT_EDITABLE_STATUSES.has(currentItem.operationalStatus)) {
    throw new Error('Solo puedes editar libremente lineas en borrador.');
  }

  const quantity = patch.quantity ?? currentItem.quantity;
  if (!Number.isFinite(quantity) || quantity <= 0) {
    throw new Error('La cantidad debe ser mayor que cero.');
  }

  const supabase = getSupabaseClient();
  const updates = {
    notes: patch.notes?.trim() ?? currentItem.notes ?? '',
    quantity,
    total_price: currentItem.unitPrice * quantity,
    updated_by_email: actor.email,
  };

  const { data, error } = await supabase
    .from('pos_order_items')
    .update(updates as never)
    .eq('id', itemId)
    .eq('operational_status', 'draft')
    .select('*')
    .single();

  throwIfError(error, 'No fue posible actualizar la linea del pedido');

  await insertPosLog({
    actor,
    afterData: data,
    beforeData: currentItem,
    eventType: 'item_updated',
    orderId: currentItem.orderId,
    orderItemId: currentItem.id,
  });

  return mapPosOrderItemRow(data);
}

export async function replaceOrderItemInSupabase(
  itemId: string,
  replacement: ReplaceOrderItemInput,
  actor: PosActorContext,
  currentItemOverride?: PosOrderItem,
) {
  const originalItem = currentItemOverride ?? (await getOrderItemById(itemId));

  if (!CONTROLLED_CANCEL_STATUSES.has(originalItem.operationalStatus)) {
    throw new Error('Este producto ya esta demasiado avanzado para reemplazarlo silenciosamente.');
  }

  const supabase = getSupabaseClient();
  const now = new Date().toISOString();
  const replacementOperationalStatus = originalItem.operationalStatus === 'draft' ? 'draft' : originalItem.operationalStatus;

  const { data: cancelledOriginal, error: cancelError } = await supabase
    .from('pos_order_items')
    .update({
      cancellation_reason: replacement.reason.trim(),
      cancelled_at: now,
      cancelled_by_email: actor.email,
      financial_status: 'cancelled',
      operational_status: 'cancelled',
      updated_by_email: actor.email,
    } as never)
    .eq('id', itemId)
    .in('operational_status', ['draft', 'sent', 'pending_preparation'])
    .select('*')
    .single();

  throwIfError(cancelError, 'No fue posible preparar la linea original para reemplazo');

  const { data, error } = await supabase
    .from('pos_order_items')
    .insert({
      order_id: originalItem.orderId,
      menu_item_source_key: replacement.menuItemSourceKey,
      product_name: replacement.productName.trim(),
      product_slug: replacement.productSlug.trim(),
      prep_area: derivePreparationAreaFromProductType(replacement.productType),
      quantity: replacement.quantity,
      unit_price: replacement.unitPrice,
      total_price: replacement.unitPrice * replacement.quantity,
      service_round: originalItem.serviceRound,
      operational_status: replacementOperationalStatus,
      financial_status: 'pending_payment',
      notes: replacement.notes?.trim() ?? '',
      replacement_for_item_id: originalItem.id,
      sent_at: replacementOperationalStatus === 'draft' ? null : originalItem.sentAt,
      created_by_email: actor.email,
      updated_by_email: actor.email,
    } as never)
    .select('*')
    .single();

  throwIfError(error, 'No fue posible crear la linea de reemplazo');
  await reconcileOrderState(originalItem.orderId, actor.email);

  await insertPosLog({
    actor,
    afterData: {
      original: cancelledOriginal,
      replacement: data,
    },
    beforeData: originalItem,
    eventType: 'item_replaced',
    notes: replacement.reason,
    orderId: originalItem.orderId,
    orderItemId: data.id,
  });

  return mapPosOrderItemRow(data);
}

export async function cancelOrderItemInSupabase(itemId: string, reason: string, actor: PosActorContext, currentItemOverride?: PosOrderItem) {
  const currentItem = currentItemOverride ?? (await getOrderItemById(itemId));

  if (!CONTROLLED_CANCEL_STATUSES.has(currentItem.operationalStatus)) {
    throw new Error('Esta linea ya no puede cancelarse desde este punto del flujo.');
  }

  const supabase = getSupabaseClient();
  const now = new Date().toISOString();
  const { data, error } = await supabase
    .from('pos_order_items')
    .update({
      cancellation_reason: reason.trim(),
      cancelled_at: now,
      cancelled_by_email: actor.email,
      financial_status: 'cancelled',
      operational_status: 'cancelled',
      updated_by_email: actor.email,
    } as never)
    .eq('id', itemId)
    .in('operational_status', ['draft', 'sent', 'pending_preparation'])
    .select('*')
    .single();

  throwIfError(error, 'No fue posible cancelar la linea');

  await reconcileOrderState(currentItem.orderId, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    beforeData: currentItem,
    eventType: 'item_cancelled',
    notes: reason.trim(),
    orderId: currentItem.orderId,
    orderItemId: currentItem.id,
  });

  return mapPosOrderItemRow(data);
}

export async function sendDraftItemsToPreparationInSupabase(orderId: string, actor: PosActorContext) {
  const supabase = getSupabaseClient();
  const draftItems = await loadOrderItems(orderId);
  const pendingDrafts = draftItems.filter((item) => item.operationalStatus === 'draft');

  if (!pendingDrafts.length) {
    throw new Error('No hay lineas en borrador para enviar a preparacion.');
  }

  const now = new Date().toISOString();
  const ids = pendingDrafts.map((item) => item.id);
  const { data, error } = await supabase
    .from('pos_order_items')
    .update({
      operational_status: 'pending_preparation',
      sent_at: now,
      updated_by_email: actor.email,
    } as never)
    .in('id', ids)
    .select('*');

  throwIfError(error, 'No fue posible enviar el pedido a preparacion');

  await insertPosLog({
    actor,
    afterData: data,
    beforeData: pendingDrafts,
    eventType: 'order_sent_to_preparation',
    notes: `${pendingDrafts.length} linea(s) enviadas`,
    orderId,
    tableId: (await getOrderById(orderId)).tableId,
  });

  return data?.map(mapPosOrderItemRow) ?? [];
}

export async function transitionPreparationItemInSupabase(
  itemId: string,
  nextStatus: Extract<OrderOperationalStatus, 'in_process' | 'ready'>,
  actor: PosActorContext,
  currentItemOverride?: PosOrderItem,
) {
  const item = currentItemOverride ?? (await getOrderItemById(itemId));
  ensurePreparationPermission(item, actor.roles);

  const allowedCurrent = nextStatus === 'in_process' ? ['pending_preparation', 'sent'] : ['in_process'];
  if (!allowedCurrent.includes(item.operationalStatus)) {
    throw new Error('La linea no esta en un estado valido para ese movimiento operativo.');
  }

  const supabase = getSupabaseClient();
  const now = new Date().toISOString();
  const updatePayload =
    nextStatus === 'in_process'
      ? {
          operational_status: 'in_process',
          preparation_started_at: now,
          updated_by_email: actor.email,
        }
      : {
          operational_status: 'ready',
          ready_at: now,
          updated_by_email: actor.email,
        };

  const { data, error } = await supabase
    .from('pos_order_items')
    .update(updatePayload as never)
    .eq('id', itemId)
    .in('operational_status', allowedCurrent)
    .select('*')
    .single();

  throwIfError(error, 'No fue posible actualizar el estado de preparacion');

  await insertPosLog({
    actor,
    afterData: data,
    beforeData: item,
    eventType: `item_${nextStatus}`,
    orderId: item.orderId,
    orderItemId: item.id,
  });

  return mapPosOrderItemRow(data);
}

export async function markOrderItemPickingUpInSupabase(itemId: string, actor: PosActorContext, currentItemOverride?: PosOrderItem) {
  const item = currentItemOverride ?? (await getOrderItemById(itemId));
  if (item.operationalStatus !== 'ready') {
    throw new Error('Solo puedes ir a recoger una linea que ya esta lista.');
  }

  const supabase = getSupabaseClient();
  const now = new Date().toISOString();
  const { data, error } = await supabase
    .from('pos_order_items')
    .update({
      operational_status: 'picking_up',
      picking_up_at: now,
      picking_up_by_email: actor.email,
      updated_by_email: actor.email,
    } as never)
    .eq('id', itemId)
    .eq('operational_status', 'ready')
    .select('*')
    .single();

  throwIfError(error, 'No fue posible marcar la linea como recogiendo');
  await insertPosLog({
    actor,
    afterData: data,
    beforeData: item,
    eventType: 'item_picking_up',
    orderId: item.orderId,
    orderItemId: item.id,
  });

  return mapPosOrderItemRow(data);
}

export async function markOrderItemDeliveredInSupabase(itemId: string, actor: PosActorContext, currentItemOverride?: PosOrderItem) {
  const item = currentItemOverride ?? (await getOrderItemById(itemId));
  if (!['ready', 'picking_up'].includes(item.operationalStatus)) {
    throw new Error('Solo puedes marcar como entregado un producto que ya este listo para salir.');
  }

  const supabase = getSupabaseClient();
  const now = new Date().toISOString();
  const { data, error } = await supabase
    .from('pos_order_items')
    .update({
      delivered_at: now,
      delivered_by_email: actor.email,
      operational_status: 'delivered',
      updated_by_email: actor.email,
    } as never)
    .eq('id', itemId)
    .in('operational_status', ['ready', 'picking_up'])
    .select('*')
    .single();

  throwIfError(error, 'No fue posible marcar la linea como entregada');
  await reconcileOrderState(item.orderId, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    beforeData: item,
    eventType: 'item_delivered',
    orderId: item.orderId,
    orderItemId: item.id,
  });

  return mapPosOrderItemRow(data);
}

export async function recordPosPaymentInSupabase(orderId: string, input: RecordPaymentInput, actor: PosActorContext) {
  const orderBundle = await loadOrderBundle(orderId);
  const summary = buildOrderSummary(orderBundle.items, orderBundle.payments);
  const amountApplied = resolvePaymentAmount(input, orderBundle.items, summary.remainingBalance);

  if (amountApplied <= 0) {
    throw new Error('El pago debe aplicar un valor mayor que cero.');
  }

  if (amountApplied > summary.remainingBalance + 0.001) {
    throw new Error('Ese pago supera el saldo restante de la cuenta.');
  }

  if (input.method === 'cash' && input.amountReceived != null && input.amountReceived < amountApplied) {
    throw new Error('El monto recibido en efectivo no cubre el valor aplicado.');
  }

  const status = requiresManualPaymentConfirmation(input.method) ? 'pending' : 'confirmed';
  const now = new Date().toISOString();
  const supabase = getSupabaseClient();

  const { data, error } = await supabase
    .from('pos_payments')
    .insert({
      allocation_mode: resolveAllocationMode(input),
      amount_applied: amountApplied,
      amount_received: input.amountReceived ?? null,
      change_due: input.method === 'cash' && input.amountReceived != null ? Math.max(input.amountReceived - amountApplied, 0) : null,
      confirmed_at: status === 'confirmed' ? now : null,
      confirmed_by_email: status === 'confirmed' ? actor.email : null,
      created_by_email: actor.email,
      method: input.method,
      notes: input.notes?.trim() ?? null,
      order_id: orderId,
      percentage_applied: input.percentage ?? null,
      reference: input.reference?.trim() ?? null,
      status,
      target_item_ids: (input.targetItemIds ?? []) as never,
    } as never)
    .select('*')
    .single();

  throwIfError(error, 'No fue posible registrar el pago');

  await reconcileOrderState(orderId, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    eventType: `payment_${status}`,
    notes: input.notes?.trim() ?? null,
    orderId,
  });

  return mapPosPaymentRow(data);
}

export async function updatePosPaymentStatusInSupabase(
  paymentId: string,
  input: UpdatePaymentStatusInput,
  actor: PosActorContext,
  currentPaymentOverride?: PosPayment,
) {
  const payment = currentPaymentOverride ?? (await getPaymentById(paymentId));

  if (payment.status !== 'pending') {
    throw new Error('Solo puedes confirmar o rechazar pagos que siguen pendientes.');
  }

  const now = new Date().toISOString();
  const supabase = getSupabaseClient();
  const updatePayload =
    input.status === 'confirmed'
      ? {
          confirmed_at: now,
          confirmed_by_email: actor.email,
          notes: input.notes?.trim() ?? payment.notes ?? null,
          status: 'confirmed',
        }
      : {
          notes: input.notes?.trim() ?? payment.notes ?? null,
          rejected_at: now,
          rejected_by_email: actor.email,
          rejection_reason: input.rejectionReason?.trim() ?? 'Pago rechazado',
          status: 'rejected',
        };

  const { data, error } = await supabase
    .from('pos_payments')
    .update(updatePayload as never)
    .eq('id', paymentId)
    .eq('status', 'pending')
    .select('*')
    .single();

  throwIfError(error, 'No fue posible actualizar el estado del pago');

  await reconcileOrderState(payment.orderId, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    beforeData: payment,
    eventType: `payment_${input.status}`,
    notes: input.rejectionReason?.trim() ?? input.notes?.trim() ?? null,
    orderId: payment.orderId,
  });

  return mapPosPaymentRow(data);
}

export function subscribeToPosRealtime(onChange: () => void) {
  const supabase = getSupabaseClient();
  const channel: RealtimeChannel = supabase.channel('zafiro-pos-live');

  channel
    .on('postgres_changes', { event: '*', schema: 'public', table: 'pos_tables' }, onChange)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'pos_orders' }, onChange)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'pos_order_items' }, onChange)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'pos_payments' }, onChange)
    .on('postgres_changes', { event: '*', schema: 'public', table: 'pos_order_status_logs' }, onChange)
    .subscribe();

  return () => {
    void supabase.removeChannel(channel);
  };
}

async function loadCurrentStaffProfile() {
  const supabase = getSupabaseClient();
  const userEmail = await getCurrentUserEmail();

  if (!userEmail) {
    return null;
  }

  const { data, error } = await supabase.from('staff_profiles').select('*').eq('email', userEmail).maybeSingle();
  throwIfError(error, 'No fue posible leer tu perfil operativo');
  return data;
}

async function loadCurrentStaffRoles() {
  const supabase = getSupabaseClient();
  const userEmail = await getCurrentUserEmail();

  if (!userEmail) {
    return [] as StaffRole[];
  }

  const { data, error } = await supabase.from('staff_role_assignments').select('*').eq('email', userEmail);
  throwIfError(error, 'No fue posible leer tus roles operativos');
  return (data ?? []).map((entry) => entry.role as StaffRole);
}

async function ensureOpenOrderForTable(table: PosTable, actor: PosActorContext) {
  if (table.activeOrderId) {
    return getOrderById(table.activeOrderId);
  }

  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from('pos_orders')
    .insert({
      assigned_staff_email: actor.email,
      financial_status: 'pending_payment',
      notes: '',
      opened_by_email: actor.email,
      table_id: table.id,
    } as never)
    .select('*')
    .single();

  throwIfError(error, 'No fue posible abrir la cuenta de la mesa');
  await touchTableOccupation(table.id, data.id, actor.email);
  await insertPosLog({
    actor,
    afterData: data,
    eventType: 'order_opened',
    notes: `Cuenta abierta para ${table.code}`,
    orderId: data.id,
    tableId: table.id,
  });
  return mapPosOrderRow(data);
}

async function touchTableOccupation(tableId: string, activeOrderId: string, staffEmail: string) {
  const supabase = getSupabaseClient();
  const { error } = await supabase
    .from('pos_tables')
    .update({
      active_order_id: activeOrderId,
      assigned_staff_email: staffEmail,
      status: 'occupied',
    } as never)
    .eq('id', tableId);

  throwIfError(error, 'No fue posible actualizar el estado de la mesa');
}

async function reconcileOrderState(orderId: string, actorEmail: string) {
  const supabase = getSupabaseClient();
  const bundle = await loadOrderBundle(orderId);
  const allocation = allocateConfirmedPayments(bundle.items, bundle.payments);
  const updatedStatuses = bundle.items
    .map((item) => {
      if (item.operationalStatus === 'cancelled') {
        return { id: item.id, financialStatus: 'cancelled' as OrderFinancialStatus };
      }

      const remaining = allocation.get(item.id) ?? item.totalPrice;
      const nextStatus: OrderFinancialStatus = remaining <= 0 ? 'paid_total' : remaining < item.totalPrice ? 'partially_paid' : 'pending_payment';
      return { id: item.id, financialStatus: nextStatus };
    })
    .filter((entry) => {
      const current = bundle.items.find((item) => item.id === entry.id);
      return current?.financialStatus !== entry.financialStatus;
    });

  for (const entry of updatedStatuses) {
    const { error } = await supabase
      .from('pos_order_items')
      .update({
        financial_status: entry.financialStatus,
        updated_by_email: actorEmail,
      } as never)
      .eq('id', entry.id);
    throwIfError(error, 'No fue posible reconciliar el estado financiero de una linea');
  }

  const refreshedBundle = updatedStatuses.length ? await loadOrderBundle(orderId) : bundle;
  const summary = buildOrderSummary(refreshedBundle.items, refreshedBundle.payments);
  const nextOrderStatus = deriveOrderFinancialStatus(refreshedBundle.items, summary);
  const orderUpdates: Record<string, unknown> = {
    financial_status: nextOrderStatus,
  };

  const shouldCloseOrder =
    (nextOrderStatus === 'paid_total' || nextOrderStatus === 'cancelled') &&
    refreshedBundle.items.length > 0 &&
    refreshedBundle.items.every((item) => TERMINAL_ITEM_STATUSES.has(item.operationalStatus));

  if (shouldCloseOrder) {
    orderUpdates.closed_at = new Date().toISOString();
  }

  const { error: orderError } = await supabase.from('pos_orders').update(orderUpdates as never).eq('id', orderId);
  throwIfError(orderError, 'No fue posible reconciliar la orden');

  const tableUpdates = shouldCloseOrder
    ? {
        active_order_id: null,
        assigned_staff_email: null,
        status: 'available',
      }
    : {
        active_order_id: orderId,
        status: 'occupied',
      };

  const { error: tableError } = await supabase
    .from('pos_tables')
    .update(tableUpdates as never)
    .eq('id', refreshedBundle.order.tableId);
  throwIfError(tableError, 'No fue posible reconciliar la mesa');
}

async function loadOrderBundle(orderId: string) {
  const [order, items, payments] = await Promise.all([getOrderById(orderId), loadOrderItems(orderId), loadOrderPayments(orderId)]);
  return { order, items, payments };
}

function buildOrdersWithRelations(
  orders: PosOrderRow[],
  items: PosOrderItemRow[],
  payments: PosPaymentRow[],
): PosOrderWithRelations[] {
  const itemsByOrderId = new Map<string, PosOrderItem[]>();
  const paymentsByOrderId = new Map<string, PosPayment[]>();

  for (const row of items) {
    const mapped = mapPosOrderItemRow(row);
    const bucket = itemsByOrderId.get(mapped.orderId) ?? [];
    bucket.push(mapped);
    itemsByOrderId.set(mapped.orderId, bucket);
  }

  for (const row of payments) {
    const mapped = mapPosPaymentRow(row);
    const bucket = paymentsByOrderId.get(mapped.orderId) ?? [];
    bucket.push(mapped);
    paymentsByOrderId.set(mapped.orderId, bucket);
  }

  return orders.map((row) => {
    const order = mapPosOrderRow(row);
    const orderItems = itemsByOrderId.get(order.id) ?? [];
    const orderPayments = paymentsByOrderId.get(order.id) ?? [];

    return {
      ...order,
      items: orderItems,
      payments: orderPayments,
      summary: buildOrderSummary(orderItems, orderPayments),
    };
  });
}

function buildTablesWithOrders(tables: PosTableRow[], orders: PosOrderWithRelations[]): PosTableWithOrder[] {
  const ordersById = new Map(orders.map((order) => [order.id, order]));
  return tables.map((row) => ({
    ...mapPosTableRow(row),
    activeOrder: row.active_order_id ? ordersById.get(row.active_order_id) ?? null : null,
  }));
}

function buildOrderSummary(items: PosOrderItem[], payments: PosPayment[]): PosOrderComputedSummary {
  const billableItems = items.filter((item) => item.operationalStatus !== 'cancelled' && item.financialStatus !== 'cancelled');
  const subtotal = billableItems.reduce((sum, item) => sum + item.totalPrice, 0);
  const confirmedPayments = payments.filter((payment) => payment.status === 'confirmed');
  const pendingPayments = payments.filter((payment) => payment.status === 'pending');
  const totalPaid = confirmedPayments.reduce((sum, payment) => sum + payment.amountApplied, 0);
  const remainingBalance = Math.max(subtotal - totalPaid, 0);

  return {
    subtotal,
    totalDue: subtotal,
    totalPaid,
    remainingBalance,
    pendingPayments: pendingPayments.length,
    confirmedPayments: confirmedPayments.length,
  };
}

function allocateConfirmedPayments(items: PosOrderItem[], payments: PosPayment[]) {
  const outstanding = new Map<string, number>();
  const activeItems = items.filter((item) => item.operationalStatus !== 'cancelled');
  const activeItemsById = new Map(activeItems.map((item) => [item.id, item]));
  for (const item of activeItems) {
    outstanding.set(item.id, item.totalPrice);
  }

  const confirmedPayments = payments
    .filter((payment) => payment.status === 'confirmed')
    .sort((left, right) => left.createdAt.localeCompare(right.createdAt));

  for (const payment of confirmedPayments) {
    let remaining = payment.amountApplied;
    const targetIds =
      payment.allocationMode === 'items' && payment.targetItemIds?.length
        ? payment.targetItemIds
        : activeItems.map((item) => item.id);

    for (const targetEntry of targetIds) {
      if (remaining <= 0) {
        break;
      }

      const itemId = parsePaymentTargetItemId(targetEntry);
      const item = activeItemsById.get(itemId);
      if (!item) {
        continue;
      }

      const currentOutstanding = outstanding.get(itemId);
      if (!currentOutstanding || currentOutstanding <= 0) {
        continue;
      }

      const maxChunk = isPaymentUnitKey(targetEntry) ? item.unitPrice : item.totalPrice;
      const applied = Math.min(currentOutstanding, remaining, maxChunk);
      outstanding.set(itemId, Math.max(currentOutstanding - applied, 0));
      remaining -= applied;
    }
  }

  return outstanding;
}

function deriveOrderFinancialStatus(items: PosOrderItem[], summary: PosOrderComputedSummary): OrderFinancialStatus {
  const activeItems = items.filter((item) => item.operationalStatus !== 'cancelled');
  if (!activeItems.length) {
    return 'cancelled';
  }

  if (summary.remainingBalance <= 0 && summary.totalDue > 0) {
    return 'paid_total';
  }

  if (summary.totalPaid > 0) {
    return 'partially_paid';
  }

  return 'pending_payment';
}

function resolvePaymentAmount(input: RecordPaymentInput, items: PosOrderItem[], remainingBalance: number) {
  const mode = resolveAllocationMode(input);
  if (mode === 'total') {
    return remainingBalance;
  }

  if (mode === 'amount') {
    return normalizeMoney(input.amount);
  }

  if (mode === 'percentage') {
    const percentage = input.percentage ?? 0;
    return normalizeMoney((remainingBalance * percentage) / 100);
  }

  const itemMap = new Map(items.filter((item) => item.operationalStatus !== 'cancelled').map((item) => [item.id, item]));
  return normalizeMoney(
    (input.targetItemIds ?? []).reduce((sum, targetEntry) => {
      const itemId = parsePaymentTargetItemId(targetEntry);
      const item = itemMap.get(itemId);
      if (!item) {
        return sum;
      }

      return sum + (isPaymentUnitKey(targetEntry) ? item.unitPrice : item.totalPrice);
    }, 0),
  );
}

function resolveAllocationMode(input: RecordPaymentInput): PaymentAllocationMode {
  if (input.targetItemIds?.length) {
    return 'items';
  }

  if (input.percentage != null) {
    return 'percentage';
  }

  if (input.amount != null) {
    return 'amount';
  }

  return 'total';
}

function requiresManualPaymentConfirmation(method: PaymentMethod) {
  return method === 'nequi' || method === 'bank_transfer';
}

function isPaymentUnitKey(value: string) {
  return value.includes('::');
}

function parsePaymentTargetItemId(value: string) {
  return isPaymentUnitKey(value) ? value.split('::')[0] ?? value : value;
}

function ensurePreparationPermission(item: PosOrderItem, roles: StaffRole[]) {
  if (roles.includes('superadmin')) {
    return;
  }

  if (item.prepArea === 'kitchen' && roles.includes('kitchen')) {
    return;
  }

  if (item.prepArea === 'bar' && roles.includes('bar')) {
    return;
  }

  throw new Error('Tu rol actual no puede operar esta cola de preparacion.');
}

function derivePreparationAreaFromProductType(productType: string): PreparationArea {
  const normalized = productType.trim().toLowerCase();
  if (BAR_PRODUCT_TYPES.has(normalized)) {
    return 'bar';
  }
  if (KITCHEN_PRODUCT_TYPES.has(normalized)) {
    return 'kitchen';
  }
  return 'bar';
}

function resolvePreparationQueueTimestamp(item: PosOrderItem) {
  return item.sentAt ?? item.createdAt;
}

async function getTableById(tableId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_tables').select('*').eq('id', tableId).single();
  throwIfError(error, 'No fue posible leer la mesa seleccionada');
  return mapPosTableRow(data);
}

async function getOrderById(orderId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_orders').select('*').eq('id', orderId).single();
  throwIfError(error, 'No fue posible leer la orden seleccionada');
  return mapPosOrderRow(data);
}

async function getOrderItemById(itemId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_order_items').select('*').eq('id', itemId).single();
  throwIfError(error, 'No fue posible leer la linea seleccionada');
  return mapPosOrderItemRow(data);
}

async function getPaymentById(paymentId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_payments').select('*').eq('id', paymentId).single();
  throwIfError(error, 'No fue posible leer el pago seleccionado');
  return mapPosPaymentRow(data);
}

async function loadOrderItems(orderId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_order_items').select('*').eq('order_id', orderId).order('created_at', { ascending: true });
  throwIfError(error, 'No fue posible leer las lineas de la orden');
  return (data ?? []).map(mapPosOrderItemRow);
}

async function loadOrderPayments(orderId: string) {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase.from('pos_payments').select('*').eq('order_id', orderId).order('created_at', { ascending: true });
  throwIfError(error, 'No fue posible leer los pagos de la orden');
  return (data ?? []).map(mapPosPaymentRow);
}

async function insertPosLog(input: {
  actor: PosActorContext;
  afterData?: unknown;
  beforeData?: unknown;
  eventType: string;
  notes?: string | null;
  orderId?: string | null;
  orderItemId?: string | null;
  tableId?: string | null;
}) {
  const supabase = getSupabaseClient();
  const actorRole = input.actor.roles.includes('superadmin') ? 'superadmin' : input.actor.roles[0] ?? null;
  const { error } = await supabase.from('pos_order_status_logs').insert({
    actor_email: input.actor.email,
    actor_role: actorRole,
    after_data: (input.afterData ?? null) as never,
    before_data: (input.beforeData ?? null) as never,
    event_type: input.eventType,
    notes: input.notes ?? null,
    order_id: input.orderId ?? null,
    order_item_id: input.orderItemId ?? null,
    table_id: input.tableId ?? null,
  } as never);

  throwIfError(error, 'No fue posible registrar la trazabilidad POS');
}

async function getCurrentUserEmail() {
  const supabase = getSupabaseClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  return user?.email?.trim().toLowerCase() ?? null;
}

function normalizeEffectiveRoles(roles: StaffRole[], profile: StaffProfileRow | null, userEmail: string | null) {
  const deduped = new Set<StaffRole>(roles);
  if (!profile && roles.length === 0 && !userEmail) {
    return [] as StaffRole[];
  }
  return Array.from(deduped);
}

function buildStaffProfile(profile: StaffProfileRow | null, roles: StaffRole[], userEmail: string | null): StaffProfile | null {
  if (!profile && !userEmail) {
    return null;
  }

  return {
    email: profile?.email ?? userEmail ?? '',
    fullName: profile?.full_name ?? userEmail ?? 'Operador',
    isActive: profile?.is_active ?? true,
    roles,
  };
}

function mapMenuItemPublicRow(row: MenuItemPublicRow): PosProductOption {
  return {
    available: row.disponible,
    id: row.id,
    name: row.name,
    price: row.precio_venta ?? 0,
    slug: row.slug,
    sourceKey: row.source_key,
    subgrupo: row.subgrupo ?? '',
    type: row.tipo,
  };
}

function mapPosTableRow(row: PosTableRow): PosTable {
  return {
    activeOrderId: row.active_order_id,
    assignedStaffEmail: row.assigned_staff_email,
    capacity: row.capacity,
    code: row.code,
    createdAt: row.created_at,
    id: row.id,
    name: row.name,
    notes: row.notes,
    status: row.status as PosTable['status'],
    type: row.type as PosTable['type'],
    updatedAt: row.updated_at,
    zone: row.zone as PosTable['zone'],
  };
}

function mapPosOrderRow(row: PosOrderRow): PosOrder {
  return {
    assignedStaffEmail: row.assigned_staff_email,
    cancellationReason: row.cancellation_reason,
    cashierEmail: row.cashier_email,
    closedAt: row.closed_at,
    createdAt: row.created_at,
    financialStatus: row.financial_status as PosOrder['financialStatus'],
    id: row.id,
    notes: row.notes,
    openedAt: row.opened_at,
    openedByEmail: row.opened_by_email,
    tableId: row.table_id,
    updatedAt: row.updated_at,
  };
}

function mapPosOrderItemRow(row: PosOrderItemRow): PosOrderItem {
  return {
    cancellationReason: row.cancellation_reason,
    cancelledAt: row.cancelled_at,
    cancelledByEmail: row.cancelled_by_email,
    createdAt: row.created_at,
    createdByEmail: row.created_by_email,
    deliveredAt: row.delivered_at,
    deliveredByEmail: row.delivered_by_email,
    financialStatus: row.financial_status as PosOrderItem['financialStatus'],
    id: row.id,
    menuItemSourceKey: row.menu_item_source_key,
    notes: row.notes,
    operationalStatus: row.operational_status as PosOrderItem['operationalStatus'],
    orderId: row.order_id,
    pickingUpAt: row.picking_up_at,
    pickingUpByEmail: row.picking_up_by_email,
    prepArea: row.prep_area as PreparationArea,
    preparationStartedAt: row.preparation_started_at,
    productName: row.product_name,
    productSlug: row.product_slug,
    quantity: row.quantity,
    readyAt: row.ready_at,
    replacementForItemId: row.replacement_for_item_id,
    sentAt: row.sent_at,
    serviceRound: row.service_round,
    totalPrice: Number(row.total_price),
    unitPrice: Number(row.unit_price),
    updatedAt: row.updated_at,
    updatedByEmail: row.updated_by_email,
  };
}

function mapPosPaymentRow(row: PosPaymentRow): PosPayment {
  return {
    allocationMode: row.allocation_mode as PaymentAllocationMode,
    amountApplied: Number(row.amount_applied),
    amountReceived: row.amount_received == null ? null : Number(row.amount_received),
    changeDue: row.change_due == null ? null : Number(row.change_due),
    confirmedAt: row.confirmed_at,
    confirmedByEmail: row.confirmed_by_email,
    createdAt: row.created_at,
    createdByEmail: row.created_by_email,
    id: row.id,
    method: row.method as PaymentMethod,
    notes: row.notes,
    orderId: row.order_id,
    percentageApplied: row.percentage_applied == null ? null : Number(row.percentage_applied),
    reference: row.reference,
    rejectedAt: row.rejected_at,
    rejectedByEmail: row.rejected_by_email,
    rejectionReason: row.rejection_reason,
    status: row.status as PaymentStatus,
    targetItemIds: Array.isArray(row.target_item_ids) ? row.target_item_ids.filter((entry): entry is string => typeof entry === 'string') : [],
  };
}

function mapPosLogRow(row: PosLogRow): PosOrderStatusLog {
  return {
    actorEmail: row.actor_email,
    actorRole: row.actor_role as StaffRole | null,
    afterData: row.after_data,
    beforeData: row.before_data,
    createdAt: row.created_at,
    eventType: row.event_type,
    id: row.id,
    notes: row.notes,
    orderId: row.order_id,
    orderItemId: row.order_item_id,
    tableId: row.table_id,
  };
}

function normalizeMoney(value: number | undefined) {
  if (value == null || !Number.isFinite(value)) {
    return 0;
  }

  return Math.max(Math.round(value), 0);
}

function throwIfError(error: { message: string } | null, fallbackMessage: string): asserts error is null {
  if (error) {
    throw new Error(`${fallbackMessage}: ${error.message}`);
  }
}
