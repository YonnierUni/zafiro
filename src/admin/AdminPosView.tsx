import type { ReactNode } from 'react';
import { useDeferredValue, useEffect, useMemo, useRef, useState } from 'react';
import { AdminLayout } from './AdminLayout';
import { useSupabaseAuth } from '../auth/SupabaseAuthProvider';
import type {
  AddOrderItemInput,
  CreatePosTableInput,
  PaymentAllocationMode,
  PaymentMethod,
  PosOrderItem,
  PosOrderWithRelations,
  PosPayment,
  PosProductOption,
  PosSalesSession,
  PosSalesSessionSummary,
  PosState,
  PosTable,
  PosTableWithOrder,
  StaffRole,
  UpdateOrderItemInput,
} from '../shared/operations/operations.types';
import {
  addItemsToTableInSupabase,
  cancelOrderItemInSupabase,
  closeActiveSalesSessionInSupabase,
  createPosTableInSupabase,
  deletePosTableInSupabase,
  loadPosProductOptionsFromSupabase,
  loadPosStateFromSupabase,
  markOrderItemDeliveredInSupabase,
  markOrderItemPickingUpInSupabase,
  openSalesSessionInSupabase,
  recordPosPaymentInSupabase,
  replaceOrderItemInSupabase,
  sendDraftItemsToPreparationInSupabase,
  subscribeToPosRealtime,
  transitionPreparationItemInSupabase,
  updateOrderItemInSupabase,
  updatePosPaymentStatusInSupabase,
  type PosRealtimeEvent,
} from '../integrations/supabase/posOperationsRepository';

type WorkspaceTab = 'floor' | 'kitchen' | 'bar' | 'cashier';
type CashierRightPanel = 'summary' | 'previous_sessions' | 'validations' | 'movements';

const roleLabels: Record<StaffRole, string> = {
  superadmin: 'Superadmin',
  waiter: 'Mesero',
  kitchen: 'Cocina',
  bar: 'Bar',
  cashier: 'Caja',
};

const workspaceLabels: Record<WorkspaceTab, string> = {
  floor: 'Mesas',
  kitchen: 'Cocina',
  bar: 'Bar',
  cashier: 'Caja',
};

const tableStatusLabels: Record<PosTableWithOrder['status'], string> = {
  available: 'Disponible',
  occupied: 'Ocupada',
  reserved: 'Reservada',
  inactive: 'Inactiva',
};

const itemStatusLabels: Record<PosOrderItem['operationalStatus'], string> = {
  draft: 'Borrador',
  sent: 'Enviado',
  pending_preparation: 'Pendiente',
  in_process: 'En proceso',
  ready: 'Listo',
  picking_up: 'Recogiendo',
  delivered: 'Entregado',
  cancelled: 'Cancelado',
};

const financialStatusLabels: Record<PosOrderWithRelations['financialStatus'], string> = {
  pending_payment: 'Pendiente de pago',
  partially_paid: 'Abono parcial',
  paid_total: 'Pagado total',
  cancelled: 'Cancelada',
};

const paymentMethodLabels: Record<PaymentMethod, string> = {
  cash: 'Efectivo',
  nequi: 'Nequi',
  bank_transfer: 'Transferencia',
  card: 'Tarjeta',
  other: 'Otro',
};

const zoneOptions: CreatePosTableInput['zone'][] = ['salon', 'bar', 'terrace', 'vip', 'other'];
const typeOptions: CreatePosTableInput['type'][] = ['fixed', 'temporary'];

const emptyCreateTableForm: CreatePosTableInput = {
  capacity: 4,
  code: '',
  name: '',
  notes: '',
  type: 'fixed',
  zone: 'salon',
};

export function AdminPosView() {
  const { hasRole, isCatalogAdmin, staffProfile, staffRoles, user } = useSupabaseAuth();
  const actor = useMemo(
    () => ({
      email: user?.email?.trim().toLowerCase() ?? staffProfile?.email ?? '',
      roles: Array.from(new Set<StaffRole>([(isCatalogAdmin ? 'superadmin' : null), ...staffRoles].filter(Boolean) as StaffRole[])),
    }),
    [isCatalogAdmin, staffProfile?.email, staffRoles, user?.email],
  );
  const canOperateFloor = actor.roles.includes('superadmin') || hasRole('waiter');
  const canOperateKitchen = actor.roles.includes('superadmin') || hasRole('kitchen');
  const canOperateBar = actor.roles.includes('superadmin') || hasRole('bar');
  const canOperateCashier = actor.roles.includes('superadmin') || hasRole('cashier');
  const shouldShowTableSummary = actor.roles.includes('superadmin') || canOperateCashier;
  const shouldShowFloorSidebar = actor.roles.includes('superadmin') || canOperateCashier;
  const showFinancialBadgeInProducts = actor.roles.includes('superadmin') || canOperateCashier;
  const showMetricsOverview = actor.roles.includes('superadmin') || canOperateCashier;
  const showPreparationMetrics = actor.roles.includes('superadmin') || canOperateKitchen || canOperateBar;
  const showFloorMetrics = actor.roles.includes('superadmin') || canOperateFloor;

  const workspaceTabs = useMemo<WorkspaceTab[]>(
    () =>
      [
        canOperateFloor ? 'floor' : null,
        canOperateKitchen ? 'kitchen' : null,
        canOperateBar ? 'bar' : null,
        canOperateCashier ? 'cashier' : null,
      ].filter((tab): tab is WorkspaceTab => tab != null),
    [canOperateBar, canOperateCashier, canOperateFloor, canOperateKitchen],
  );

  const [activeTab, setActiveTab] = useState<WorkspaceTab>('floor');
  const [posState, setPosState] = useState<PosState | null>(null);
  const [products, setProducts] = useState<PosProductOption[]>([]);
  const [selectedTableId, setSelectedTableId] = useState<string | null>(null);
  const [isTableSheetOpen, setIsTableSheetOpen] = useState(false);
  const [productSearch, setProductSearch] = useState('');
  const [selectedProductSourceKey, setSelectedProductSourceKey] = useState('');
  const [lineQuantity, setLineQuantity] = useState('1');
  const [lineNotes, setLineNotes] = useState('');
  const [replaceTargetItemId, setReplaceTargetItemId] = useState<string | null>(null);
  const [replaceReason, setReplaceReason] = useState('');
  const [editingItemId, setEditingItemId] = useState<string | null>(null);
  const [editingQuantity, setEditingQuantity] = useState('1');
  const [editingNotes, setEditingNotes] = useState('');
  const [createTableForm, setCreateTableForm] = useState<CreatePosTableInput>(emptyCreateTableForm);
  const [paymentMode, setPaymentMode] = useState<PaymentAllocationMode>('total');
  const [paymentMethod, setPaymentMethod] = useState<PaymentMethod>('cash');
  const [paymentAmount, setPaymentAmount] = useState('');
  const [paymentPercentage, setPaymentPercentage] = useState('');
  const [paymentReceived, setPaymentReceived] = useState('');
  const [activePaymentField, setActivePaymentField] = useState<'amount' | 'percentage' | 'received' | null>(null);
  const [paymentReference, setPaymentReference] = useState('');
  const [paymentNotes, setPaymentNotes] = useState('');
  const [salesSessionClosingNotes, setSalesSessionClosingNotes] = useState('');
  const [salesSessionOpeningNotes, setSalesSessionOpeningNotes] = useState('');
  const [selectedPaymentItemIds, setSelectedPaymentItemIds] = useState<string[]>([]);
  const [cashierRightPanel, setCashierRightPanel] = useState<CashierRightPanel>('summary');
  const [selectedHistoricalSessionId, setSelectedHistoricalSessionId] = useState<string | null>(null);
  const [highlightedPendingPaymentId, setHighlightedPendingPaymentId] = useState<string | null>(null);
  const [actionMessage, setActionMessage] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [busyAction, setBusyAction] = useState<string | null>(null);
  const realtimeTimerRef = useRef<number | null>(null);
  const trailingSyncTimerRef = useRef<number | null>(null);
  const suppressAutoSyncUntilRef = useRef(0);
  const loadStateRef = useRef<(initial?: boolean) => Promise<void>>(async () => {});
  const historicalSessionHeaderRefs = useRef<Record<string, HTMLButtonElement | null>>({});
  const cashierPaymentPanelRef = useRef<HTMLDivElement | null>(null);
  const pendingPaymentCardRefs = useRef<Record<string, HTMLElement | null>>({});
  const shouldFocusCashierPaymentPanelRef = useRef(false);
  const posStateRef = useRef<PosState | null>(null);
  const activeTabRef = useRef<WorkspaceTab>('floor');
  const actorRef = useRef(actor);
  const workspaceAccessRef = useRef({
    canOperateBar,
    canOperateCashier,
    canOperateFloor,
    canOperateKitchen,
  });
  const audioContextRef = useRef<AudioContext | null>(null);
  const recentRealtimeNotificationKeysRef = useRef<Map<string, number>>(new Map());
  const deferredProductSearch = useDeferredValue(productSearch);

  const shouldSuppressBackgroundSync = () => Date.now() < suppressAutoSyncUntilRef.current;

  const scheduleTrailingSync = (delay = 960) => {
    if (trailingSyncTimerRef.current != null) {
      window.clearTimeout(trailingSyncTimerRef.current);
    }

    trailingSyncTimerRef.current = window.setTimeout(() => {
      suppressAutoSyncUntilRef.current = 0;
      void loadStateRef.current(false);
    }, delay);
  };

  const markLocalMutationCommitted = () => {
    suppressAutoSyncUntilRef.current = Date.now() + 220;
    scheduleTrailingSync(320);
  };

  useEffect(() => {
    posStateRef.current = posState;
  }, [posState]);

  useEffect(() => {
    activeTabRef.current = activeTab;
  }, [activeTab]);

  useEffect(() => {
    actorRef.current = actor;
  }, [actor]);

  useEffect(() => {
    workspaceAccessRef.current = {
      canOperateBar,
      canOperateCashier,
      canOperateFloor,
      canOperateKitchen,
    };
  }, [canOperateBar, canOperateCashier, canOperateFloor, canOperateKitchen]);

  useEffect(() => {
    const unlockAudioAndNotifications = () => {
      if (typeof window !== 'undefined' && 'AudioContext' in window) {
        const AudioContextCtor = window.AudioContext;
        if (!audioContextRef.current) {
          audioContextRef.current = new AudioContextCtor();
        }

        if (audioContextRef.current.state === 'suspended') {
          void audioContextRef.current.resume().catch(() => {});
        }
      }

      if (typeof Notification !== 'undefined' && Notification.permission === 'default') {
        void Notification.requestPermission().catch(() => {});
      }
    };

    window.addEventListener('pointerdown', unlockAudioAndNotifications, { once: true });
    return () => window.removeEventListener('pointerdown', unlockAudioAndNotifications);
  }, []);

  useEffect(() => {
    if (!workspaceTabs.length) {
      return;
    }

    if (!workspaceTabs.includes(activeTab)) {
      setActiveTab(workspaceTabs[0]);
    }
  }, [activeTab, workspaceTabs]);

  useEffect(() => {
    let isMounted = true;

    const loadProducts = async () => {
      const nextProducts = await loadPosProductOptionsFromSupabase();
      if (isMounted) {
        setProducts(nextProducts);
        if (!selectedProductSourceKey && nextProducts[0]) {
          setSelectedProductSourceKey(nextProducts[0].sourceKey);
        }
      }
    };

    void loadProducts().catch((error: unknown) => {
      if (isMounted) {
        setErrorMessage(error instanceof Error ? error.message : 'No fue posible cargar los productos operativos.');
      }
    });

    return () => {
      isMounted = false;
    };
  }, [selectedProductSourceKey]);

  useEffect(() => {
    let isMounted = true;

    const handleRealtimeEvent = (event: PosRealtimeEvent) => {
      const realtimeSignal = resolveRealtimeSignal(event, posStateRef.current, actorRef.current.email);
      if (!realtimeSignal) {
        return;
      }

      const currentTab = activeTabRef.current;
      const access = workspaceAccessRef.current;
      const shouldNotify =
        (realtimeSignal.target === 'kitchen' && currentTab === 'kitchen' && access.canOperateKitchen) ||
        (realtimeSignal.target === 'bar' && currentTab === 'bar' && access.canOperateBar) ||
        (realtimeSignal.target === 'floor' && currentTab === 'floor' && access.canOperateFloor) ||
        (realtimeSignal.target === 'cashier' && currentTab === 'cashier' && access.canOperateCashier);

      if (!shouldNotify) {
        return;
      }

      triggerRealtimeAttention(
        realtimeSignal,
        audioContextRef.current,
        recentRealtimeNotificationKeysRef.current,
      );
    };

    const loadState = async (initial = false) => {
      try {
        if (initial) {
          setIsLoading(true);
        }

        const nextState = await loadPosStateFromSupabase();
        if (!isMounted) {
          return;
        }

        setPosState(nextState);
        setSelectedTableId((current) => {
          if (current && nextState.tables.some((table) => table.id === current)) {
            return current;
          }

          return nextState.tables[0]?.id ?? null;
        });
      } catch (error) {
        if (isMounted) {
          setErrorMessage(error instanceof Error ? error.message : 'No fue posible cargar el estado POS.');
        }
      } finally {
        if (isMounted && initial) {
          setIsLoading(false);
        }
      }
    };

    loadStateRef.current = loadState;

    void loadState(true);

    const unsubscribe = subscribeToPosRealtime(() => {
      if (shouldSuppressBackgroundSync()) {
        return;
      }

      if (realtimeTimerRef.current != null) {
        window.clearTimeout(realtimeTimerRef.current);
      }

      realtimeTimerRef.current = window.setTimeout(() => {
        void loadState(false);
      }, 12);
    }, handleRealtimeEvent);

    const handleVisibilitySync = () => {
      if (document.visibilityState === 'visible' && !shouldSuppressBackgroundSync()) {
        void loadState(false);
      }
    };

    const handleWindowFocus = () => {
      if (shouldSuppressBackgroundSync()) {
        return;
      }

      void loadState(false);
    };

    document.addEventListener('visibilitychange', handleVisibilitySync);
    window.addEventListener('focus', handleWindowFocus);

    return () => {
      isMounted = false;
      if (realtimeTimerRef.current != null) {
        window.clearTimeout(realtimeTimerRef.current);
      }
      if (trailingSyncTimerRef.current != null) {
        window.clearTimeout(trailingSyncTimerRef.current);
      }
      document.removeEventListener('visibilitychange', handleVisibilitySync);
      window.removeEventListener('focus', handleWindowFocus);
      unsubscribe();
    };
  }, []);

  const selectedTable = useMemo(
    () => posState?.tables.find((table) => table.id === selectedTableId) ?? posState?.tables[0] ?? null,
    [posState?.tables, selectedTableId],
  );
  const selectedOrder = selectedTable?.activeOrder ?? null;
  const filteredProducts = useMemo(() => {
    const term = deferredProductSearch.trim().toLowerCase();
    return products.filter((product) => {
      if (!term) {
        return true;
      }

      return [product.name, product.subgrupo, product.type, product.slug].some((value) => value.toLowerCase().includes(term));
    });
  }, [deferredProductSearch, products]);

  useEffect(() => {
    if (!filteredProducts.length) {
      return;
    }

    const currentStillVisible = filteredProducts.some((product) => product.sourceKey === selectedProductSourceKey);
    if (!currentStillVisible) {
      setSelectedProductSourceKey(filteredProducts[0].sourceKey);
    }
  }, [filteredProducts, selectedProductSourceKey]);

  const selectedProduct = useMemo(
    () => filteredProducts.find((product) => product.sourceKey === selectedProductSourceKey) ?? products.find((product) => product.sourceKey === selectedProductSourceKey) ?? null,
    [filteredProducts, products, selectedProductSourceKey],
  );
  const selectedOrderDraftItems = selectedOrder?.items.filter((item) => item.operationalStatus === 'draft') ?? [];
  const parsedLineQuantity = parseOptionalNumber(lineQuantity);
  const isLineQuantityValid = parsedLineQuantity != null && parsedLineQuantity > 0;
  const parsedEditingQuantity = parseOptionalNumber(editingQuantity);
  const isEditingQuantityValid = parsedEditingQuantity != null && parsedEditingQuantity > 0;
  const parsedCapacity = createTableForm.capacity ?? null;
  const isCapacityValid = parsedCapacity == null || parsedCapacity > 0;
  const outstandingByItem = useMemo(() => buildOutstandingByItem(selectedOrder), [selectedOrder]);
  const selectablePaymentUnits = useMemo(() => buildSelectablePaymentUnits(selectedOrder, outstandingByItem), [selectedOrder, outstandingByItem]);
  const canDeleteSelectedTable = Boolean(selectedTable && !selectedTable.activeOrder && !selectedTable.activeOrderId && selectedTable.status !== 'occupied');
  const createTableName = createTableForm.name.trim();
  const createTableCode = createTableForm.code.trim().toUpperCase();
  const canCreateTable = Boolean(createTableName && createTableCode && isCapacityValid && !busyAction);
  const paymentPreview = useMemo(() => {
    if (!selectedOrder) {
      return { amountApplied: 0, changeDue: 0, overage: 0, selectedRawAmount: 0 };
    }

    const remaining = selectedOrder.summary.remainingBalance;
    let amountApplied = remaining;
    let selectedRawAmount = remaining;
    if (paymentMode === 'amount') {
      amountApplied = parseNumber(paymentAmount);
      selectedRawAmount = amountApplied;
    } else if (paymentMode === 'percentage') {
      amountApplied = Math.max(Math.round((remaining * parseNumber(paymentPercentage)) / 100), 0);
      selectedRawAmount = amountApplied;
    } else if (paymentMode === 'items') {
      selectedRawAmount = selectablePaymentUnits
        .filter((unit) => selectedPaymentItemIds.includes(unit.unitKey))
        .reduce((sum, unit) => sum + unit.amount, 0);
      amountApplied = selectedRawAmount;
    }

    const overage = Math.max(selectedRawAmount - remaining, 0);
    amountApplied = Math.min(amountApplied, remaining);
    const amountReceived = parseNumber(paymentReceived);
    return {
      amountApplied,
      overage,
      selectedRawAmount,
      changeDue: paymentMethod === 'cash' ? Math.max(amountReceived - amountApplied, 0) : 0,
    };
  }, [paymentAmount, paymentMethod, paymentMode, paymentPercentage, paymentReceived, selectablePaymentUnits, selectedOrder, selectedPaymentItemIds]);
  const parsedPaymentAmount = parseOptionalNumber(paymentAmount);
  const isPaymentAmountValid = paymentMode !== 'amount' || (parsedPaymentAmount != null && parsedPaymentAmount > 0);
  const parsedPaymentPercentage = parseOptionalNumber(paymentPercentage);
  const isPaymentPercentageValid = paymentMode !== 'percentage' || (parsedPaymentPercentage != null && parsedPaymentPercentage > 0 && parsedPaymentPercentage <= 100);
  const parsedPaymentReceived = parseOptionalNumber(paymentReceived);
  const requiresCashReceived = paymentMethod === 'cash';
  const isPaymentReceivedValid =
    !requiresCashReceived ||
    (parsedPaymentReceived != null && parsedPaymentReceived > 0 && parsedPaymentReceived >= paymentPreview.amountApplied);
  const isItemsPaymentSelectionValid = paymentMode !== 'items' || (selectedPaymentItemIds.length > 0 && paymentPreview.amountApplied > 0 && paymentPreview.overage <= 0);
  const selectedOrderHasPendingPayment = selectedOrder?.payments.some((payment) => payment.status === 'pending') ?? false;
  const canSubmitPayment =
    Boolean(selectedOrder) &&
    !busyAction &&
    !selectedOrderHasPendingPayment &&
    paymentPreview.amountApplied > 0 &&
    paymentPreview.overage <= 0 &&
    isPaymentAmountValid &&
    isPaymentPercentageValid &&
    isPaymentReceivedValid &&
    isItemsPaymentSelectionValid;

  const kitchenQueue = posState?.pendingPreparationKitchen ?? [];
  const barQueue = posState?.pendingPreparationBar ?? [];
  const closedSales = posState?.closedSales ?? [];
  const cashierTables = useMemo(
    () =>
      (posState?.tables ?? []).filter(
        (table) => table.activeOrder && (table.activeOrder.summary.remainingBalance > 0 || table.activeOrder.summary.pendingPayments > 0),
      ),
    [posState?.tables],
  );
  const allCashierOrders = useMemo(() => [...(posState?.openOrders ?? []), ...closedSales], [closedSales, posState?.openOrders]);
  const selectedReadyCount = selectedOrder?.items.filter((item) => item.operationalStatus === 'ready').length ?? 0;
  const selectedPickingUpCount = selectedOrder?.items.filter((item) => item.operationalStatus === 'picking_up').length ?? 0;
  const selectedPendingDeliveryCount = selectedReadyCount + selectedPickingUpCount;
  const selectedPreparationCount =
    selectedOrder?.items.filter((item) => ['sent', 'pending_preparation', 'in_process'].includes(item.operationalStatus)).length ?? 0;
  const selectedOrderVisibleItems = useMemo(() => {
    if (!selectedOrder) {
      return [] as PosOrderItem[];
    }

    const visibleItems = selectedOrder.items.filter((item) => item.operationalStatus !== 'cancelled');
    const itemsById = new Map(selectedOrder.items.map((item) => [item.id, item]));
    const priority: Record<PosOrderItem['operationalStatus'], number> = {
      draft: 0,
      ready: 1,
      picking_up: 2,
      in_process: 3,
      pending_preparation: 4,
      sent: 5,
      delivered: 6,
      cancelled: 7,
    };

    return [...visibleItems].sort((left, right) => {
      const byStatus = priority[left.operationalStatus] - priority[right.operationalStatus];
      if (byStatus !== 0) {
        return byStatus;
      }

      const byAnchor = resolveReplacementAnchorTimestamp(left, itemsById).localeCompare(resolveReplacementAnchorTimestamp(right, itemsById));
      if (byAnchor !== 0) {
        return -byAnchor;
      }

      return right.createdAt.localeCompare(left.createdAt);
    });
  }, [selectedOrder]);
  const activeSalesSessionSummary = useMemo(
    () => buildLiveSalesSessionSummary(posState?.activeSalesSession ?? null, allCashierOrders),
    [allCashierOrders, posState?.activeSalesSession],
  );
  const ordersById = useMemo(() => new Map(allCashierOrders.map((order) => [order.id, order])), [allCashierOrders]);
  const tablesById = useMemo(() => new Map((posState?.tables ?? []).map((table) => [table.id, table])), [posState?.tables]);
  const activeSalesSessionOrders = useMemo(() => {
    if (!posState?.activeSalesSession) {
      return [] as PosOrderWithRelations[];
    }

    return allCashierOrders.filter((order) => order.salesSessionId === posState.activeSalesSession?.id);
  }, [allCashierOrders, posState?.activeSalesSession]);
  const previousClosedSessions = useMemo(
    () => (posState?.recentSalesSessions ?? []).filter((session) => session.status === 'closed'),
    [posState?.recentSalesSessions],
  );
  const activeSalesSessionClosedSales = useMemo(
    () => activeSalesSessionOrders.filter((order) => order.closedAt != null).sort((left, right) => (right.closedAt ?? '').localeCompare(left.closedAt ?? '')),
    [activeSalesSessionOrders],
  );
  const selectedHistoricalSession = selectedHistoricalSessionId
    ? previousClosedSessions.find((session) => session.id === selectedHistoricalSessionId) ?? null
    : null;
  const selectedHistoricalSessionSales = useMemo(
    () =>
      selectedHistoricalSession
        ? closedSales
            .filter((order) => order.salesSessionId === selectedHistoricalSession.id)
            .sort((left, right) => (right.closedAt ?? right.updatedAt).localeCompare(left.closedAt ?? left.updatedAt))
        : [],
    [closedSales, selectedHistoricalSession],
  );
  const sessionOpenTableCount = activeSalesSessionOrders.filter((order) => order.closedAt == null).length;
  const sessionClosedTableCount = activeSalesSessionClosedSales.length;

  useEffect(() => {
    if (!previousClosedSessions.length) {
      if (selectedHistoricalSessionId) {
        setSelectedHistoricalSessionId(null);
      }
      return;
    }

    if (selectedHistoricalSessionId && !previousClosedSessions.some((session) => session.id === selectedHistoricalSessionId)) {
      setSelectedHistoricalSessionId(previousClosedSessions[0].id);
    }
  }, [previousClosedSessions, selectedHistoricalSessionId]);

  useEffect(() => {
    if (cashierRightPanel !== 'previous_sessions' || !selectedHistoricalSessionId) {
      return;
    }

    const header = historicalSessionHeaderRefs.current[selectedHistoricalSessionId];
    if (!header) {
      return;
    }

    const focusAndReveal = window.requestAnimationFrame(() => {
      header.focus({ preventScroll: true });
      header.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    });

    return () => window.cancelAnimationFrame(focusAndReveal);
  }, [cashierRightPanel, selectedHistoricalSessionId]);

  useEffect(() => {
    if (!shouldFocusCashierPaymentPanelRef.current || activeTab !== 'cashier' || !selectedTableId) {
      return;
    }

    shouldFocusCashierPaymentPanelRef.current = false;

    if (!window.matchMedia('(max-width: 1279px)').matches) {
      return;
    }

    const paymentPanel = cashierPaymentPanelRef.current;
    if (!paymentPanel) {
      return;
    }

    const focusAndReveal = window.requestAnimationFrame(() => {
      paymentPanel.focus({ preventScroll: true });
      paymentPanel.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });

    return () => window.cancelAnimationFrame(focusAndReveal);
  }, [activeTab, selectedTableId]);

  useEffect(() => {
    if (cashierRightPanel !== 'validations' || !highlightedPendingPaymentId) {
      return;
    }

    const pendingCard = pendingPaymentCardRefs.current[highlightedPendingPaymentId];
    if (!pendingCard) {
      return;
    }

    const focusAndReveal = window.requestAnimationFrame(() => {
      pendingCard.focus({ preventScroll: true });
      pendingCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
    });

    return () => window.cancelAnimationFrame(focusAndReveal);
  }, [cashierRightPanel, highlightedPendingPaymentId]);

  useEffect(() => {
    if (activeTab !== 'cashier') {
      return;
    }

    if (!cashierTables.length) {
      return;
    }

    const currentStillVisible = cashierTables.some((table) => table.id === selectedTableId);
    if (!currentStillVisible) {
      setSelectedTableId(cashierTables[0].id);
    }
  }, [activeTab, cashierTables, selectedTableId]);

  useEffect(() => {
    setSelectedPaymentItemIds((current) => current.filter((entry) => selectablePaymentUnits.some((unit) => unit.unitKey === entry)));
  }, [selectablePaymentUnits]);

  useEffect(() => {
    setErrorMessage(null);
  }, [paymentAmount, paymentMethod, paymentMode, paymentNotes, paymentPercentage, paymentReceived, paymentReference, selectedPaymentItemIds, selectedTableId]);

  const executeAction = async <T,>(
    label: string,
    action: () => Promise<T>,
    options?: {
      onSuccess?: (result: T) => void;
    },
  ) => {
    if (!actor.email) {
      setErrorMessage('No hay una sesion operativa valida para ejecutar esta accion.');
      return;
    }

    setBusyAction(label);
    setErrorMessage(null);
    setActionMessage(null);

    try {
      const result = await action();
      options?.onSuccess?.(result);
      setActionMessage(label);
      markLocalMutationCommitted();
    } catch (error) {
      setErrorMessage(error instanceof Error ? error.message : `No fue posible completar: ${label}`);
    } finally {
      setBusyAction(null);
    }
  };

  const handleCreateTable = async () => {
    if (!createTableCode) {
      setErrorMessage('La mesa debe tener un codigo antes de crearse.');
      return;
    }

    if (!createTableName) {
      setErrorMessage('La mesa debe tener un nombre antes de crearse.');
      return;
    }

    await executeAction(
      `Mesa ${createTableForm.code.toUpperCase()} creada`,
      async () =>
        createPosTableInSupabase(
        {
          ...createTableForm,
          code: createTableCode,
          name: createTableName,
        },
        actor,
        ),
      {
        onSuccess: (createdTable) => {
          setPosState((current) => (current ? insertTableIntoPosState(current, createdTable) : current));
          setCreateTableForm(emptyCreateTableForm);
          setSelectedTableId(createdTable.id);
        },
      },
    );
  };

  const handleDeleteSelectedTable = async () => {
    if (!selectedTable) {
      return;
    }

    if (!canDeleteSelectedTable) {
      setErrorMessage('Solo puedes eliminar mesas que no tengan una cuenta activa.');
      return;
    }

    const confirmed = window.confirm(`Se eliminara ${selectedTable.name} (${selectedTable.code}). Esta accion no se puede deshacer.`);
    if (!confirmed) {
      return;
    }

    await executeAction(`Mesa ${selectedTable.code} eliminada`, async () => deletePosTableInSupabase(selectedTable.id, actor), {
      onSuccess: () => {
        setPosState((current) => (current ? removeTableFromPosState(current, selectedTable.id) : current));
        setSelectedTableId((current) => (current === selectedTable.id ? null : current));
        setIsTableSheetOpen(false);
      },
    });
  };

  const handleAddOrReplaceItem = async () => {
    if (!selectedTable || !selectedProduct) {
      setErrorMessage('Selecciona una mesa y un producto antes de continuar.');
      return;
    }

    if (!isLineQuantityValid || parsedLineQuantity == null) {
      setErrorMessage('La cantidad debe ser mayor que cero.');
      return;
    }

    const payload: AddOrderItemInput = {
      menuItemSourceKey: selectedProduct.sourceKey,
      notes: lineNotes,
      productName: selectedProduct.name,
      productSlug: selectedProduct.slug,
      productType: selectedProduct.type,
      quantity: parsedLineQuantity,
      unitPrice: selectedProduct.price,
    };

    if (replaceTargetItemId) {
      const targetItem = selectedOrder?.items.find((item) => item.id === replaceTargetItemId);
      await executeAction(
        `Producto reemplazado en ${selectedTable.code}`,
        async () =>
          replaceOrderItemInSupabase(
            replaceTargetItemId,
            { ...payload, reason: replaceReason.trim() || `Reemplazo de ${targetItem?.productName ?? 'producto'}` },
            actor,
            targetItem,
          ),
        {
          onSuccess: (replacementItem) => {
            const now = new Date().toISOString();
            const cancelledOriginal = targetItem
              ? {
                  ...targetItem,
                  cancellationReason: replaceReason.trim() || `Reemplazo de ${targetItem.productName}`,
                  cancelledAt: now,
                  cancelledByEmail: actor.email,
                  financialStatus: 'cancelled' as const,
                  operationalStatus: 'cancelled' as const,
                  updatedAt: now,
                  updatedByEmail: actor.email,
                }
              : null;

            setPosState((current) =>
              current
                ? mergeUpdatedItemsIntoPosState(current, cancelledOriginal ? [cancelledOriginal, replacementItem] : [replacementItem])
                : current,
            );
            setReplaceTargetItemId(null);
            setReplaceReason('');
            setLineNotes('');
            setLineQuantity('1');
          },
        },
      );
      return;
    }

    await executeAction(`Producto agregado a ${selectedTable.code}`, async () => addItemsToTableInSupabase(selectedTable.id, [payload], actor), {
      onSuccess: (createdItems) => {
        setPosState((current) => (current ? mergeAddedItemsIntoPosState(current, selectedTable, createdItems, actor.email) : current));
        setLineNotes('');
        setLineQuantity('1');
      },
    });
  };

  const handleStartEditing = (item: PosOrderItem) => {
    setEditingItemId(item.id);
    setEditingNotes(item.notes ?? '');
    setEditingQuantity(String(item.quantity));
  };

  const handleSaveEditing = async () => {
    if (!editingItemId) {
      return;
    }

    if (!isEditingQuantityValid || parsedEditingQuantity == null) {
      setErrorMessage('La cantidad debe ser mayor que cero.');
      return;
    }

    const currentEditingItem = selectedOrder?.items.find((item) => item.id === editingItemId);
    const patch: UpdateOrderItemInput = {
      notes: editingNotes,
      quantity: parsedEditingQuantity,
    };

    await executeAction('Producto actualizado', async () => updateOrderItemInSupabase(editingItemId, patch, actor, currentEditingItem), {
      onSuccess: (updatedItem) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, [updatedItem]) : current));
        setEditingItemId(null);
        setEditingNotes('');
        setEditingQuantity('1');
      },
    });
  };

  const handleCancelItem = async (item: PosOrderItem) => {
    const reason = window.prompt(
      item.operationalStatus === 'draft' ? `Motivo para quitar el borrador ${item.productName}:` : `Motivo de cancelacion para ${item.productName}:`,
      item.notes || (item.operationalStatus === 'draft' ? 'Borrador descartado' : 'Cancelacion operativa'),
    );
    if (!reason) {
      return;
    }

    await executeAction(`${item.productName} cancelado`, async () => cancelOrderItemInSupabase(item.id, reason, actor, item), {
      onSuccess: (updatedItem) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, [updatedItem]) : current));
      },
    });
  };

  const handleMovePrepStatus = async (item: PosOrderItem, nextStatus: 'in_process' | 'ready') => {
    await executeAction(`Producto marcado como ${itemStatusLabels[nextStatus].toLowerCase()}`, async () => transitionPreparationItemInSupabase(item.id, nextStatus, actor, item), {
      onSuccess: (updatedItem) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, [updatedItem]) : current));
      },
    });
  };

  const handleDelivered = async (item: PosOrderItem) => {
    await executeAction(`${item.productName} entregado`, async () => markOrderItemDeliveredInSupabase(item.id, actor, item), {
      onSuccess: (updatedItem) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, [updatedItem]) : current));
      },
    });
  };

  const handlePickingUp = async (item: PosOrderItem) => {
    await executeAction(`Recogiendo ${item.productName}`, async () => markOrderItemPickingUpInSupabase(item.id, actor, item), {
      onSuccess: (updatedItem) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, [updatedItem]) : current));
      },
    });
  };

  const handleRecordPayment = async () => {
    if (!selectedOrder) {
      return;
    }

    await executeAction(
      'Pago registrado',
      async () =>
        recordPosPaymentInSupabase(
          selectedOrder.id,
          {
            amount: paymentMode === 'amount' ? parseNumber(paymentAmount) : undefined,
            amountReceived: paymentMethod === 'cash' ? parseNumber(paymentReceived) : undefined,
            method: paymentMethod,
            notes: paymentNotes,
            percentage: paymentMode === 'percentage' ? parseNumber(paymentPercentage) : undefined,
            reference: paymentReference,
            targetItemIds: paymentMode === 'items' ? selectedPaymentItemIds : undefined,
          },
          actor,
        ),
      {
        onSuccess: (payment) => {
          setPosState((current) => (current ? mergePaymentIntoPosState(current, payment) : current));
          setPaymentAmount('');
          setPaymentPercentage('');
          setPaymentReceived('');
          setPaymentReference('');
          setPaymentNotes('');
          setSelectedPaymentItemIds([]);
          if (payment.status === 'pending') {
            setCashierRightPanel('validations');
            setHighlightedPendingPaymentId(payment.id);
          } else {
            setHighlightedPendingPaymentId(null);
          }
        },
      },
    );
  };

  const handleConfirmPendingPayment = async (paymentId: string) => {
    const payment = posState?.pendingPayments.find((entry) => entry.id === paymentId);
    await executeAction('Pago confirmado', async () => updatePosPaymentStatusInSupabase(paymentId, { status: 'confirmed' }, actor, payment), {
      onSuccess: (updatedPayment) => {
        setPosState((current) => (current ? mergePaymentIntoPosState(current, updatedPayment) : current));
        setHighlightedPendingPaymentId((current) => (current === paymentId ? null : current));
      },
    });
  };

  const handleRejectPendingPayment = async (paymentId: string) => {
    const reason = window.prompt('Motivo del rechazo:', 'Transferencia no visible');
    if (!reason) {
      return;
    }

    const payment = posState?.pendingPayments.find((entry) => entry.id === paymentId);
    await executeAction('Pago rechazado', async () => updatePosPaymentStatusInSupabase(paymentId, { rejectionReason: reason, status: 'rejected' }, actor, payment), {
      onSuccess: (updatedPayment) => {
        setPosState((current) => (current ? mergePaymentIntoPosState(current, updatedPayment) : current));
        setHighlightedPendingPaymentId((current) => (current === paymentId ? null : current));
      },
    });
  };

  const handleCloseActiveSalesSession = async () => {
    await executeAction('Jornada cerrada', async () => closeActiveSalesSessionInSupabase(actor, salesSessionClosingNotes), {
      onSuccess: (closedSession) => {
        setPosState((current) => {
          if (!current) {
            return current;
          }

          const nextRecentSessions = [
            closedSession,
            ...current.recentSalesSessions.filter((session) => session.id !== closedSession.id),
          ].slice(0, 10);

          return {
            ...current,
            activeSalesSession: null,
            recentSalesSessions: nextRecentSessions,
          };
        });
        setCashierRightPanel('previous_sessions');
        setSelectedHistoricalSessionId(closedSession.id);
        setSalesSessionClosingNotes('');
      },
    });
  };

  const handleOpenSalesSession = async () => {
    await executeAction('Jornada abierta', async () => openSalesSessionInSupabase(actor, salesSessionOpeningNotes), {
      onSuccess: (openedSession) => {
        setPosState((current) => {
          if (!current) {
            return current;
          }

          return {
            ...current,
            activeSalesSession: openedSession,
            recentSalesSessions: [openedSession, ...current.recentSalesSessions.filter((session) => session.id !== openedSession.id)].slice(0, 10),
          };
        });
        setCashierRightPanel('summary');
        setSalesSessionOpeningNotes('');
      },
    });
  };

  const handleSendDraftItems = async () => {
    if (!selectedOrder) {
      return;
    }

    await executeAction('Pedido enviado a preparacion', async () => sendDraftItemsToPreparationInSupabase(selectedOrder.id, actor), {
      onSuccess: (updatedItems) => {
        setPosState((current) => (current ? mergeUpdatedItemsIntoPosState(current, updatedItems) : current));
      },
    });
  };

  const renderSelectedTableWorkspace = () => (
    <Panel
      title={selectedTable ? `${selectedTable.name} · ${selectedTable.code}` : 'Selecciona una mesa'}
      subtitle={selectedOrder ? financialStatusLabels[selectedOrder.financialStatus] : 'La cuenta se abre automaticamente al agregar el primer producto'}
    >
      {selectedTable ? (
        <>
          {selectedPendingDeliveryCount > 0 ? (
            <div className="mb-4 rounded-[1rem] border border-rose-300/25 bg-rose-300/10 px-3 py-2 text-sm font-medium text-rose-100">
              {selectedPendingDeliveryCount} pendiente(s) por entregar
            </div>
          ) : selectedPreparationCount > 0 ? (
            <div className="mb-4 rounded-[1rem] border border-amberGlow/20 bg-amberGlow/10 px-3 py-2 text-sm text-amber-100">
              {selectedPreparationCount} en preparacion
            </div>
          ) : null}
          {shouldShowTableSummary ? (
            <div className="grid gap-3 md:grid-cols-3">
              <SummaryPill label="Estado" value={tableStatusLabels[selectedTable.status]} />
              <SummaryPill label="Cuenta" value={selectedOrder ? formatCurrency(selectedOrder.summary.totalDue) : formatCurrency(0)} />
              <SummaryPill label="Saldo" value={selectedOrder ? formatCurrency(selectedOrder.summary.remainingBalance) : formatCurrency(0)} />
            </div>
          ) : null}

          {selectedOrder?.openedByEmail || selectedTable.assignedStaffEmail ? (
            <div className="mt-4 rounded-[1rem] border border-white/8 bg-white/[0.02] px-3 py-3 text-sm text-mist">
              <div className="flex flex-wrap gap-x-5 gap-y-2">
                {selectedOrder?.openedByEmail ? (
                  <p>
                    <span className="text-cyanGlow/75">Creada por:</span>{' '}
                    <span className="text-ivory">{formatOperatorIdentity(selectedOrder.openedByEmail)}</span>
                  </p>
                ) : null}
                {selectedTable.assignedStaffEmail ? (
                  <p>
                    <span className="text-cyanGlow/75">Responsable actual:</span>{' '}
                    <span className="text-ivory">{formatOperatorIdentity(selectedTable.assignedStaffEmail)}</span>
                  </p>
                ) : null}
              </div>
            </div>
          ) : null}

          <div className="mt-5 rounded-[1.2rem] border border-white/8 bg-black/15 p-4">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">
                  {replaceTargetItemId ? 'Modo reemplazo' : 'Agregar productos'}
                </p>
                <p className="mt-2 text-sm text-mist">
                  {replaceTargetItemId
                    ? 'El nuevo producto se crea en borrador y el anterior queda cancelado con trazabilidad.'
                    : 'Puedes sumar nuevas tandas a la misma mesa sin cerrar la cuenta.'}
                </p>
              </div>
              {replaceTargetItemId ? (
                <button type="button" onClick={() => setReplaceTargetItemId(null)} className={ghostButtonClassName}>
                  Salir de reemplazo
                </button>
              ) : null}
            </div>

            <div className="mt-4 grid gap-3">
              <Field label="Buscar producto">
                <input value={productSearch} onChange={(event) => setProductSearch(event.target.value)} className={inputClassName} placeholder="Corona, Poker, jugo..." />
              </Field>
              <Field label="Producto">
                <select value={selectedProductSourceKey} onChange={(event) => setSelectedProductSourceKey(event.target.value)} className={inputClassName}>
                  {filteredProducts.slice(0, 60).map((product) => (
                    <option key={product.sourceKey} value={product.sourceKey}>
                      {product.name} · {formatCurrency(product.price)}
                    </option>
                  ))}
                </select>
              </Field>
              <div className="grid gap-3 md:grid-cols-2">
                <Field label="Cantidad">
                  <input
                    value={lineQuantity}
                    onChange={(event) => setLineQuantity(sanitizeDigitsInput(event.target.value))}
                    inputMode="numeric"
                    pattern="[0-9]*"
                    className={getQuantityInputClassName(isLineQuantityValid)}
                  />
                </Field>
                {replaceTargetItemId ? (
                  <Field label="Motivo de reemplazo">
                    <input value={replaceReason} onChange={(event) => setReplaceReason(event.target.value)} className={inputClassName} placeholder="Cliente cambia Corona por Poker" />
                  </Field>
                ) : null}
              </div>
              <Field label="Observaciones del producto">
                <input value={lineNotes} onChange={(event) => setLineNotes(event.target.value)} className={inputClassName} placeholder="Sin hielo, poco limon, sin azucar..." />
              </Field>
            </div>

              <button
                type="button"
                onClick={() => void handleAddOrReplaceItem()}
                disabled={!selectedProduct || !isLineQuantityValid || Boolean(busyAction)}
                className={`${primaryButtonClassName} mt-4`}
              >
                {replaceTargetItemId ? 'Aplicar reemplazo' : 'Agregar a la mesa'}
            </button>
          </div>

          <div className="mt-5 space-y-3">
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div>
                <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Productos del pedido</p>
                <p className="mt-2 text-sm text-mist">Cada producto conserva su estado, observaciones y trazabilidad.</p>
              </div>
              {selectedOrderDraftItems.length ? (
                <button type="button" onClick={() => void handleSendDraftItems()} disabled={Boolean(busyAction)} className={primaryButtonClassName}>
                  Enviar a preparacion
                </button>
              ) : null}
            </div>

            {selectedOrderVisibleItems.length ? (
              selectedOrderVisibleItems.map((item) => (
                <article
                  key={item.id}
                  className={`rounded-[1.2rem] border p-4 ${
                    item.operationalStatus === 'draft'
                      ? 'border-amberGlow/28 bg-amberGlow/[0.06]'
                      : 'border-white/8 bg-white/[0.02]'
                  }`}
                >
                  <div className="flex items-start justify-between gap-3">
                    <div className="min-w-0 flex-1">
                      <p className="font-medium text-ivory">
                        {item.quantity} × {item.productName}
                      </p>
                      <p className="mt-2 text-sm text-mist">{formatCurrency(item.totalPrice)}</p>
                      {item.notes ? <p className="mt-2 text-sm text-amberGlow">{item.notes}</p> : null}
                      {item.operationalStatus === 'picking_up' && item.pickingUpByEmail ? (
                        <p className="mt-2 text-sm text-cyanGlow/80">Recogiendo: {formatOperatorIdentity(item.pickingUpByEmail)}</p>
                      ) : null}
                      {item.operationalStatus === 'draft' ? (
                        <p className="mt-2 text-sm text-amberGlow">Producto temporal. Aun no se ha enviado a preparacion.</p>
                      ) : null}
                    </div>
                    <div className="flex shrink-0 flex-wrap gap-2">
                      <span className="rounded-full border border-cyanGlow/15 bg-cyanGlow/10 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-cyanGlow">
                        {itemStatusLabels[item.operationalStatus]}
                      </span>
                      {showFinancialBadgeInProducts && item.operationalStatus !== 'draft' ? (
                        <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                          {financialStatusLabels[item.financialStatus]}
                        </span>
                      ) : null}
                    </div>
                  </div>

                  {editingItemId === item.id ? (
                    <div className="mt-4 grid gap-3 md:grid-cols-[7rem_minmax(0,1fr)_auto]">
                      <input
                        value={editingQuantity}
                        onChange={(event) => setEditingQuantity(sanitizeDigitsInput(event.target.value))}
                        inputMode="numeric"
                        pattern="[0-9]*"
                        className={getQuantityInputClassName(isEditingQuantityValid)}
                      />
                      <input value={editingNotes} onChange={(event) => setEditingNotes(event.target.value)} className={inputClassName} placeholder="Observacion del producto" />
                      <div className="flex gap-2">
                        <button type="button" onClick={() => void handleSaveEditing()} disabled={!isEditingQuantityValid || Boolean(busyAction)} className={primaryButtonClassName}>
                          Guardar
                        </button>
                        <button type="button" onClick={() => setEditingItemId(null)} className={ghostButtonClassName}>
                          Cancelar
                        </button>
                      </div>
                    </div>
                  ) : null}

                  <div className="mt-4 flex flex-wrap gap-2">
                    {!editingItemId && item.operationalStatus === 'draft' ? (
                      <>
                        <button type="button" onClick={() => handleStartEditing(item)} className={ghostButtonClassName}>
                          Editar
                        </button>
                        <button type="button" onClick={() => void handleCancelItem(item)} className={dangerButtonClassName}>
                          Quitar borrador
                        </button>
                      </>
                    ) : null}
                    {!editingItemId && ['sent', 'pending_preparation'].includes(item.operationalStatus) ? (
                      <>
                        <button type="button" onClick={() => setReplaceTargetItemId(item.id)} className={ghostButtonClassName}>
                          Reemplazar
                        </button>
                        <button type="button" onClick={() => void handleCancelItem(item)} className={dangerButtonClassName}>
                          Cancelar producto
                        </button>
                      </>
                    ) : null}
                    {!editingItemId && item.operationalStatus === 'ready' ? (
                      <button type="button" onClick={() => void handlePickingUp(item)} className={ghostButtonClassName}>
                        Ir a recoger
                      </button>
                    ) : null}
                    {!editingItemId && item.operationalStatus === 'picking_up' ? (
                      <button type="button" onClick={() => void handleDelivered(item)} className={primaryButtonClassName}>
                        Marcar entregado
                      </button>
                    ) : null}
                  </div>
                </article>
              ))
            ) : (
              <EmptyState message="Esta mesa todavia no tiene productos activos. Agrega la primera tanda desde el panel superior." />
            )}
          </div>
        </>
      ) : (
        <EmptyState message="No hay mesas cargadas todavia." />
      )}
    </Panel>
  );

  if (isLoading) {
    return (
      <AdminLayout>
        <section className="rounded-[1.8rem] border border-white/10 bg-white/[0.03] p-8 text-mist">Cargando operacion POS...</section>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <section className="flex flex-col gap-3 lg:flex-row lg:items-end lg:justify-between">
        <div className="max-w-3xl">
          <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">Operacion real POS</p>
          <h1 className="mt-3 font-display text-[1.7rem] leading-[0.95] text-ivory sm:text-[3.4rem]">Mesas, preparacion y caja</h1>
          <p className="mt-3 hidden max-w-2xl text-[0.98rem] leading-7 text-mist sm:block sm:mt-5 sm:text-lg sm:leading-8">
            Esta vista ya trabaja sobre Supabase y separa el flujo del local por mesas, productos, preparacion y cobro, con actualizacion en
            tiempo real entre roles.
          </p>
        </div>

        <div className="flex flex-wrap gap-2">
          {workspaceTabs.map((tab) => (
            <button
              key={tab}
              type="button"
              onClick={() => setActiveTab(tab)}
              className={`rounded-full px-3 py-1.5 text-[0.68rem] font-semibold uppercase tracking-[0.18em] sm:px-4 sm:py-2 sm:text-xs sm:tracking-[0.22em] ${
                activeTab === tab
                  ? 'border border-cyanGlow/25 bg-cyanGlow/10 text-cyanGlow'
                  : 'border border-white/10 bg-white/[0.04] text-mist'
              }`}
            >
              {workspaceLabels[tab]}
            </button>
          ))}
        </div>
      </section>

      {showMetricsOverview || showPreparationMetrics || showFloorMetrics ? (
        <section
          className={`mt-5 grid gap-3 ${
            showMetricsOverview && showPreparationMetrics && showFloorMetrics ? 'md:grid-cols-2 xl:grid-cols-4' : 'md:grid-cols-2 xl:grid-cols-3'
          }`}
        >
          {showFloorMetrics ? (
            <MetricCard label="Mesas activas" value={String(posState?.tables.filter((table) => table.activeOrder != null).length ?? 0)} />
          ) : null}
          {showPreparationMetrics ? <MetricCard label="Preparacion cocina" value={String(kitchenQueue.length)} accent="amber" /> : null}
          {showPreparationMetrics ? <MetricCard label="Preparacion bar" value={String(barQueue.length)} accent="cyan" /> : null}
          {showMetricsOverview ? (
            <MetricCard
              label="Pendiente por cobrar"
              value={formatCurrency(posState?.openOrders.reduce((sum, order) => sum + order.summary.remainingBalance, 0) ?? 0)}
              accent="emerald"
            />
          ) : null}
        </section>
      ) : null}

      {errorMessage ? (
        <section className="mt-5 rounded-[1.2rem] border border-rose-200/20 bg-rose-200/10 px-3 py-2 text-sm text-rose-100 sm:mt-6 sm:rounded-[1.4rem] sm:px-4 sm:py-3">{errorMessage}</section>
      ) : null}
      {actionMessage ? (
        <section className="mt-5 rounded-[1.2rem] border border-emerald-300/20 bg-emerald-300/10 px-3 py-2 text-sm text-emerald-100 sm:mt-6 sm:rounded-[1.4rem] sm:px-4 sm:py-3">
          {actionMessage}
        </section>
      ) : null}

      {activeTab === 'floor' && canOperateFloor ? (
        <section className="mt-8 grid gap-6 xl:grid-cols-[minmax(18rem,0.95fr)_minmax(0,1.35fr)_minmax(21rem,0.95fr)]">
          <div className="space-y-5">
            <Panel title="Mesas vivas" subtitle="Selecciona una mesa para operar la cuenta">
              <div className="space-y-3">
                {posState?.tables.map((table) => {
                  const readyCount = table.activeOrder?.items.filter((item) => item.operationalStatus === 'ready').length ?? 0;
                  const pickingUpCount = table.activeOrder?.items.filter((item) => item.operationalStatus === 'picking_up').length ?? 0;
                  const inPreparationCount =
                    table.activeOrder?.items.filter((item) => ['sent', 'pending_preparation', 'in_process'].includes(item.operationalStatus)).length ?? 0;
                  const indicatorClassName =
                    readyCount > 0
                      ? 'bg-rose-400 shadow-[0_0_0_4px_rgba(251,113,133,0.14)]'
                      : pickingUpCount > 0
                        ? 'bg-cyanGlow shadow-[0_0_0_4px_rgba(36,107,255,0.14)]'
                        : inPreparationCount > 0
                          ? 'bg-amber-300 shadow-[0_0_0_4px_rgba(252,211,77,0.12)]'
                          : null;

                  return (
                    <button
                      key={table.id}
                      type="button"
                      onClick={() => {
                        setSelectedTableId(table.id);
                        if (window.innerWidth < 1280) {
                          setIsTableSheetOpen(true);
                        }
                      }}
                      className={`w-full rounded-[1.2rem] border p-4 text-left transition ${
                        selectedTable?.id === table.id
                          ? 'border-cyanGlow/28 bg-cyanGlow/10'
                          : readyCount > 0
                            ? 'border-emerald-300/35 bg-emerald-300/[0.06]'
                            : pickingUpCount > 0
                              ? 'border-cyanGlow/24 bg-cyanGlow/[0.05]'
                            : 'border-white/8 bg-white/[0.02]'
                      }`}
                    >
                      <div className="flex items-start justify-between gap-3">
                        <div>
                          <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">{table.code}</p>
                          <div className="mt-2 flex items-center gap-2">
                            <p className="font-semibold text-ivory">{table.name}</p>
                            {indicatorClassName ? <span className={`inline-block h-2.5 w-2.5 rounded-full ${indicatorClassName}`} /> : null}
                          </div>
                        </div>
                        <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                          {tableStatusLabels[table.status]}
                        </span>
                      </div>
                      {table.activeOrder ? (
                        <div className="mt-3 text-sm text-mist">
                          <p>{table.activeOrder.items.length} producto(s)</p>
                          <p>{formatCurrency(table.activeOrder.summary.remainingBalance)} pendiente</p>
                          {table.assignedStaffEmail ? <p className="mt-2 text-xs text-cyanGlow/75">Responsable actual: {formatOperatorIdentity(table.assignedStaffEmail)}</p> : null}
                          {readyCount > 0 ? <p className="mt-2 font-medium text-rose-200">{readyCount} listo(s) por recoger</p> : null}
                          {pickingUpCount > 0 ? <p className="mt-2 text-cyanGlow/90">{pickingUpCount} en recogida</p> : null}
                          {!readyCount && !pickingUpCount && inPreparationCount > 0 ? <p className="mt-2 text-amberGlow">{inPreparationCount} en preparacion</p> : null}
                        </div>
                      ) : (
                        <div className="mt-3 text-sm text-mist">
                          <p>Sin cuenta activa</p>
                          {table.assignedStaffEmail ? <p className="mt-2 text-xs text-cyanGlow/75">Responsable actual: {formatOperatorIdentity(table.assignedStaffEmail)}</p> : null}
                        </div>
                      )}
                    </button>
                  );
                })}
              </div>
              {selectedTable ? (
                <button type="button" onClick={() => setIsTableSheetOpen(true)} className={`mt-4 w-full xl:hidden ${primaryButtonClassName}`}>
                  Abrir detalle de {selectedTable.name}
                </button>
              ) : null}
            </Panel>

            <Panel title="Crear mesa" subtitle="Mesas fijas o adicionales para alta ocupacion">
              <div className="grid gap-3 sm:grid-cols-2">
                <Field label="Codigo">
                  <input value={createTableForm.code} onChange={(event) => setCreateTableForm((current) => ({ ...current, code: event.target.value }))} className={inputClassName} placeholder="M-07" />
                </Field>
                <Field label="Nombre">
                  <input value={createTableForm.name} onChange={(event) => setCreateTableForm((current) => ({ ...current, name: event.target.value }))} className={inputClassName} placeholder="Mesa 07" />
                </Field>
                <Field label="Tipo">
                  <select value={createTableForm.type} onChange={(event) => setCreateTableForm((current) => ({ ...current, type: event.target.value as CreatePosTableInput['type'] }))} className={inputClassName}>
                    {typeOptions.map((type) => (
                      <option key={type} value={type}>
                        {type}
                      </option>
                    ))}
                  </select>
                </Field>
                <Field label="Zona">
                  <select value={createTableForm.zone} onChange={(event) => setCreateTableForm((current) => ({ ...current, zone: event.target.value as CreatePosTableInput['zone'] }))} className={inputClassName}>
                    {zoneOptions.map((zone) => (
                      <option key={zone} value={zone}>
                        {zone}
                      </option>
                    ))}
                  </select>
                </Field>
                <Field label="Capacidad">
                  <input
                    value={String(createTableForm.capacity ?? '')}
                    onChange={(event) =>
                      setCreateTableForm((current) => ({ ...current, capacity: parseOptionalNumber(sanitizeDigitsInput(event.target.value)) }))
                    }
                    inputMode="numeric"
                    pattern="[0-9]*"
                    className={getQuantityInputClassName(isCapacityValid)}
                    placeholder="4"
                  />
                </Field>
                <Field label="Notas">
                  <input value={createTableForm.notes ?? ''} onChange={(event) => setCreateTableForm((current) => ({ ...current, notes: event.target.value }))} className={inputClassName} placeholder="Mesa adicional por evento" />
                </Field>
              </div>
              <div className="mt-4 flex flex-wrap gap-3">
                <button type="button" onClick={() => void handleCreateTable()} disabled={!canCreateTable} className={primaryButtonClassName}>
                {busyAction ?? 'Crear mesa'}
                </button>
                {selectedTable ? (
                  <button
                    type="button"
                    onClick={() => void handleDeleteSelectedTable()}
                    disabled={!canDeleteSelectedTable || Boolean(busyAction)}
                    className={dangerButtonClassName}
                  >
                    Eliminar mesa seleccionada
                  </button>
                ) : null}
              </div>
              {selectedTable && !canDeleteSelectedTable ? (
                <p className="mt-3 text-sm text-mist">Solo puedes eliminar una mesa cuando no tenga cuenta activa ni este ocupada.</p>
              ) : null}
            </Panel>
          </div>

          <div className="hidden space-y-5 xl:block">
            <Panel
              title={selectedTable ? `${selectedTable.name} · ${selectedTable.code}` : 'Selecciona una mesa'}
              subtitle={selectedOrder ? financialStatusLabels[selectedOrder.financialStatus] : 'La cuenta se abre automaticamente al agregar el primer producto'}
            >
              {selectedTable ? (
                <>
                  <div className="grid gap-3 md:grid-cols-3">
                    <SummaryPill label="Estado" value={tableStatusLabels[selectedTable.status]} />
                    <SummaryPill label="Cuenta" value={selectedOrder ? formatCurrency(selectedOrder.summary.totalDue) : formatCurrency(0)} />
                    <SummaryPill label="Saldo" value={selectedOrder ? formatCurrency(selectedOrder.summary.remainingBalance) : formatCurrency(0)} />
                  </div>

                  <div className="mt-5 rounded-[1.2rem] border border-white/8 bg-black/15 p-4">
                    <div className="flex flex-wrap items-center justify-between gap-3">
                      <div>
                        <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">
                          {replaceTargetItemId ? 'Modo reemplazo' : 'Agregar productos'}
                        </p>
                        <p className="mt-2 text-sm text-mist">
                          {replaceTargetItemId
                            ? 'El nuevo producto se crea en borrador y el anterior queda cancelado con trazabilidad.'
                            : 'Puedes sumar nuevas tandas a la misma mesa sin cerrar la cuenta.'}
                        </p>
                      </div>
                      {replaceTargetItemId ? (
                        <button type="button" onClick={() => setReplaceTargetItemId(null)} className={ghostButtonClassName}>
                          Salir de reemplazo
                        </button>
                      ) : null}
                    </div>

                    <div className="mt-4 grid gap-3">
                      <Field label="Buscar producto">
                        <input value={productSearch} onChange={(event) => setProductSearch(event.target.value)} className={inputClassName} placeholder="Corona, Poker, jugo..." />
                      </Field>
                      <Field label="Producto">
                        <select value={selectedProductSourceKey} onChange={(event) => setSelectedProductSourceKey(event.target.value)} className={inputClassName}>
                          {filteredProducts.slice(0, 60).map((product) => (
                            <option key={product.sourceKey} value={product.sourceKey}>
                              {product.name} · {formatCurrency(product.price)}
                            </option>
                          ))}
                        </select>
                      </Field>
                      <div className="grid gap-3 md:grid-cols-2">
                        <Field label="Cantidad">
                          <input
                            value={lineQuantity}
                            onChange={(event) => setLineQuantity(sanitizeDigitsInput(event.target.value))}
                            inputMode="numeric"
                            pattern="[0-9]*"
                            className={getQuantityInputClassName(isLineQuantityValid)}
                          />
                        </Field>
                        {replaceTargetItemId ? (
                          <Field label="Motivo de reemplazo">
                            <input value={replaceReason} onChange={(event) => setReplaceReason(event.target.value)} className={inputClassName} placeholder="Cliente cambia Corona por Poker" />
                          </Field>
                        ) : null}
                      </div>
                      <Field label="Observaciones del producto">
                        <input value={lineNotes} onChange={(event) => setLineNotes(event.target.value)} className={inputClassName} placeholder="Sin hielo, poco limon, sin azucar..." />
                      </Field>
                    </div>

                    <button
                      type="button"
                      onClick={() => void handleAddOrReplaceItem()}
                      disabled={!selectedProduct || !isLineQuantityValid || Boolean(busyAction)}
                      className={`${primaryButtonClassName} mt-4`}
                    >
                      {replaceTargetItemId ? 'Aplicar reemplazo' : 'Agregar a la mesa'}
                    </button>
                  </div>

                  <div className="mt-5 space-y-3">
                    <div className="flex flex-wrap items-center justify-between gap-3">
                      <div>
                        <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Productos del pedido</p>
                        <p className="mt-2 text-sm text-mist">Cada producto conserva su estado, observaciones y trazabilidad.</p>
                      </div>
                      {selectedOrderDraftItems.length ? (
                        <button type="button" onClick={() => void handleSendDraftItems()} disabled={Boolean(busyAction)} className={primaryButtonClassName}>
                          Enviar a preparacion
                        </button>
                      ) : null}
                    </div>

                    {selectedOrder?.items.length ? (
                      selectedOrder.items.map((item) => (
                        <article
                          key={item.id}
                          className={`rounded-[1.2rem] border p-4 ${
                            item.operationalStatus === 'draft'
                              ? 'border-amberGlow/28 bg-amberGlow/[0.06]'
                              : 'border-white/8 bg-white/[0.02]'
                          }`}
                        >
                          <div className="flex items-start justify-between gap-3">
                            <div className="min-w-0 flex-1">
                              <p className="font-medium text-ivory">
                                {item.quantity} × {item.productName}
                              </p>
                              <p className="mt-2 text-sm text-mist">{formatCurrency(item.totalPrice)}</p>
                              {item.notes ? <p className="mt-2 text-sm text-amberGlow">{item.notes}</p> : null}
                              {item.operationalStatus === 'picking_up' && item.pickingUpByEmail ? (
                                <p className="mt-2 text-sm text-cyanGlow/80">Recogiendo: {formatOperatorIdentity(item.pickingUpByEmail)}</p>
                              ) : null}
                              {item.operationalStatus === 'draft' ? (
                                <p className="mt-2 text-sm text-amberGlow">Producto temporal. Aun no se ha enviado a preparacion.</p>
                              ) : null}
                            </div>
                            <div className="flex shrink-0 flex-wrap gap-2">
                              <span className="rounded-full border border-cyanGlow/15 bg-cyanGlow/10 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-cyanGlow">
                                {itemStatusLabels[item.operationalStatus]}
                              </span>
                              {showFinancialBadgeInProducts && item.operationalStatus !== 'draft' ? (
                                <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                                  {financialStatusLabels[item.financialStatus]}
                                </span>
                              ) : null}
                            </div>
                          </div>

                          {editingItemId === item.id ? (
                            <div className="mt-4 grid gap-3 md:grid-cols-[7rem_minmax(0,1fr)_auto]">
                             <input
                               value={editingQuantity}
                               onChange={(event) => setEditingQuantity(sanitizeDigitsInput(event.target.value))}
                               inputMode="numeric"
                               pattern="[0-9]*"
                               className={getQuantityInputClassName(isEditingQuantityValid)}
                             />
                              <input value={editingNotes} onChange={(event) => setEditingNotes(event.target.value)} className={inputClassName} placeholder="Observacion del producto" />
                              <div className="flex gap-2">
                               <button type="button" onClick={() => void handleSaveEditing()} disabled={!isEditingQuantityValid || Boolean(busyAction)} className={primaryButtonClassName}>
                                 Guardar
                               </button>
                                <button type="button" onClick={() => setEditingItemId(null)} className={ghostButtonClassName}>
                                  Cancelar
                                </button>
                              </div>
                            </div>
                          ) : null}

                          <div className="mt-4 flex flex-wrap gap-2">
                            {!editingItemId && item.operationalStatus === 'draft' ? (
                              <>
                                <button type="button" onClick={() => handleStartEditing(item)} className={ghostButtonClassName}>
                                  Editar
                                </button>
                                <button type="button" onClick={() => void handleCancelItem(item)} className={dangerButtonClassName}>
                                  Quitar borrador
                                </button>
                              </>
                            ) : null}
                            {!editingItemId && ['sent', 'pending_preparation'].includes(item.operationalStatus) ? (
                              <>
                                <button type="button" onClick={() => setReplaceTargetItemId(item.id)} className={ghostButtonClassName}>
                                  Reemplazar
                                </button>
                                <button type="button" onClick={() => void handleCancelItem(item)} className={dangerButtonClassName}>
                                  Cancelar producto
                                </button>
                              </>
                            ) : null}
                            {!editingItemId && item.operationalStatus === 'ready' ? (
                              <button type="button" onClick={() => void handlePickingUp(item)} className={ghostButtonClassName}>
                                Ir a recoger
                              </button>
                            ) : null}
                            {!editingItemId && item.operationalStatus === 'picking_up' ? (
                              <button type="button" onClick={() => void handleDelivered(item)} className={primaryButtonClassName}>
                                Marcar entregado
                              </button>
                            ) : null}
                          </div>
                        </article>
                      ))
                    ) : (
                      <EmptyState message="Esta mesa todavia no tiene productos activos. Agrega la primera tanda desde el panel superior." />
                    )}
                  </div>
                </>
              ) : (
                <EmptyState message="No hay mesas cargadas todavia." />
              )}
            </Panel>
          </div>

          {isTableSheetOpen && selectedTable ? (
            <div className="fixed inset-0 z-40 flex items-end bg-black/70 xl:hidden">
              <div className="max-h-[92vh] w-full overflow-y-auto rounded-t-[1.8rem] border border-white/10 bg-[#0b0b0f] p-4 shadow-[0_-18px_40px_rgba(0,0,0,0.38)]">
                <div className="mb-4 flex items-center justify-between gap-3">
                  <div>
                    <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/80">Mesa activa</p>
                    <p className="mt-2 font-semibold text-ivory">
                      {selectedTable.name} · {selectedTable.code}
                    </p>
                  </div>
                  <button type="button" onClick={() => setIsTableSheetOpen(false)} className={ghostButtonClassName}>
                    Cerrar
                  </button>
                </div>
                {renderSelectedTableWorkspace()}
              </div>
            </div>
          ) : null}

          {shouldShowFloorSidebar ? (
            <div className="space-y-5">
              <Panel title="Resumen de cuenta" subtitle="Capas separadas: operacion vs cobro">
                {selectedOrder ? (
                  <div className="space-y-4">
                    <SummaryPill label="Operativo" value={`${selectedOrder.items.filter((item) => item.operationalStatus === 'ready').length} listo(s)`} />
                    <SummaryPill label="Financiero" value={financialStatusLabels[selectedOrder.financialStatus]} />
                    <SummaryPill label="Pagado" value={formatCurrency(selectedOrder.summary.totalPaid)} />
                    <SummaryPill label="Restante" value={formatCurrency(selectedOrder.summary.remainingBalance)} />
                  </div>
                ) : (
                  <EmptyState message="Cuando una mesa abra cuenta aqui veras el acumulado y su capa financiera." />
                )}
              </Panel>

              <Panel title="Trazabilidad reciente" subtitle="Ultimos eventos operativos y financieros">
                <div className="space-y-3">
                  {(posState?.logs ?? []).slice(0, 8).map((log) => (
                    <article key={log.id} className="rounded-[1.1rem] border border-white/8 bg-white/[0.02] p-3">
                      <p className="text-sm font-medium text-ivory">{log.eventType}</p>
                      <p className="mt-1 text-xs text-mist">{new Date(log.createdAt).toLocaleString('es-CO')}</p>
                      {log.notes ? <p className="mt-2 text-sm text-mist">{log.notes}</p> : null}
                    </article>
                  ))}
                </div>
              </Panel>
            </div>
          ) : null}
        </section>
      ) : null}

      {activeTab === 'kitchen' && canOperateKitchen ? (
        <PreparationQueuePanel
          areaLabel="Cocina"
          busyAction={busyAction}
          items={kitchenQueue}
          onMoveStatus={handleMovePrepStatus}
          title="Cola de cocina"
        />
      ) : null}

      {activeTab === 'bar' && canOperateBar ? (
        <PreparationQueuePanel
          areaLabel="Bar"
          busyAction={busyAction}
          items={barQueue}
          onMoveStatus={handleMovePrepStatus}
          title="Cola de bebidas"
        />
      ) : null}

      {activeTab === 'cashier' && canOperateCashier ? (
        <section className="mt-8 grid gap-6 xl:grid-cols-[minmax(18rem,0.82fr)_minmax(0,1.15fr)_minmax(0,0.95fr)]">
          <div className="space-y-5">
            <Panel title="Cuentas activas para caja" subtitle="La caja puede cambiar de mesa desde aquí, sin depender de otra pestaña.">
              <div className="space-y-3">
                {cashierTables.map((table) => (
                  <button
                    key={table.id}
                    type="button"
                    onClick={() => {
                      shouldFocusCashierPaymentPanelRef.current = true;
                      setSelectedTableId(table.id);
                    }}
                    className={`w-full rounded-[1.2rem] border p-4 text-left transition ${
                      selectedTable?.id === table.id ? 'border-cyanGlow/28 bg-cyanGlow/10' : 'border-white/8 bg-white/[0.02]'
                    }`}
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div>
                        <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">{table.code}</p>
                        <p className="mt-2 font-semibold text-ivory">{table.name}</p>
                      </div>
                      <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                        {table.activeOrder ? financialStatusLabels[table.activeOrder.financialStatus] : tableStatusLabels[table.status]}
                      </span>
                    </div>
                    {table.activeOrder ? (
                      <div className="mt-3 grid gap-2 text-sm text-mist sm:grid-cols-2">
                        <p>Total: {formatCurrency(table.activeOrder.summary.totalDue)}</p>
                        <p>Saldo: {formatCurrency(table.activeOrder.summary.remainingBalance)}</p>
                      </div>
                    ) : null}
                  </button>
                ))}
                {!cashierTables.length ? <EmptyState message="No hay mesas con saldo o pagos pendientes por confirmar en este momento." /> : null}
              </div>
            </Panel>
          </div>

          <div ref={cashierPaymentPanelRef} tabIndex={-1} className="focus:outline-none">
            <Panel
              title={selectedTable ? `Cobro de ${selectedTable.name} · ${selectedTable.code}` : 'Cobro de mesa'}
              subtitle="Abonos parciales, total, por porcentaje o por productos"
            >
              {selectedOrder ? (
                <>
                <div className="grid gap-3 md:grid-cols-3">
                  <SummaryPill label="Total cuenta" value={formatCurrency(selectedOrder.summary.totalDue)} />
                  <SummaryPill label="Pagado" value={formatCurrency(selectedOrder.summary.totalPaid)} />
                  <SummaryPill label="Saldo" value={formatCurrency(selectedOrder.summary.remainingBalance)} />
                </div>

                <div className="mt-5 grid gap-3 md:grid-cols-2">
                  <Field label="Modo">
                    <select value={paymentMode} onChange={(event) => setPaymentMode(event.target.value as PaymentAllocationMode)} className={inputClassName}>
                      <option value="total">Total</option>
                      <option value="amount">Monto</option>
                      <option value="percentage">Porcentaje</option>
                      <option value="items">Por productos</option>
                    </select>
                  </Field>
                  <Field label="Metodo">
                    <select value={paymentMethod} onChange={(event) => setPaymentMethod(event.target.value as PaymentMethod)} className={inputClassName}>
                      {Object.entries(paymentMethodLabels).map(([method, label]) => (
                        <option key={method} value={method}>
                          {label}
                        </option>
                      ))}
                    </select>
                  </Field>
                </div>

                {paymentMode === 'amount' ? (
                  <Field label="Monto a aplicar">
                    <input
                      value={activePaymentField === 'amount' ? formatGroupedDigitsInputValue(paymentAmount) : formatCurrencyInputValue(paymentAmount)}
                      onChange={(event) => setPaymentAmount(sanitizeDigitsInput(event.target.value))}
                      onFocus={() => setActivePaymentField('amount')}
                      onBlur={() => setActivePaymentField((current) => (current === 'amount' ? null : current))}
                      inputMode="numeric"
                      pattern="[0-9]*"
                      className={getQuantityInputClassName(isPaymentAmountValid)}
                      placeholder="$ 87.000"
                    />
                  </Field>
                ) : null}

                {paymentMode === 'percentage' ? (
                  <Field label="Porcentaje">
                    <input
                      value={activePaymentField === 'percentage' ? paymentPercentage : formatPercentageInputValue(paymentPercentage)}
                      onChange={(event) => setPaymentPercentage(sanitizePercentageInput(event.target.value))}
                      onFocus={() => setActivePaymentField('percentage')}
                      onBlur={() => setActivePaymentField((current) => (current === 'percentage' ? null : current))}
                      inputMode="numeric"
                      pattern="[0-9]*"
                      className={getQuantityInputClassName(isPaymentPercentageValid)}
                      placeholder="50 %"
                    />
                  </Field>
                ) : null}

                {paymentMode === 'items' ? (
                  <div className="mt-4 rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                    <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Productos o unidades a cobrar</p>
                    <div className="mt-3 space-y-2">
                      {selectablePaymentUnits.map((unit) => (
                        <label key={unit.unitKey} className="flex items-center justify-between gap-3 rounded-[1rem] border border-white/8 bg-black/15 px-3 py-2 text-sm text-mist">
                          <span>
                            {unit.label}
                          </span>
                          <span className="flex items-center gap-3">
                            <span>{formatCurrency(unit.amount)}</span>
                            <input
                              type="checkbox"
                              checked={selectedPaymentItemIds.includes(unit.unitKey)}
                              onChange={(event) =>
                                setSelectedPaymentItemIds((current) =>
                                  event.target.checked ? [...current, unit.unitKey] : current.filter((entry) => entry !== unit.unitKey),
                                )
                              }
                            />
                          </span>
                        </label>
                      ))}
                      {!selectablePaymentUnits.length ? <EmptyState message="Ya no hay unidades pendientes por cobrar en esta mesa." /> : null}
                    </div>
                  </div>
                ) : null}

                {paymentMethod === 'cash' ? (
                  <Field label="Recibido">
                    <input
                      value={activePaymentField === 'received' ? formatGroupedDigitsInputValue(paymentReceived) : formatCurrencyInputValue(paymentReceived)}
                      onChange={(event) => setPaymentReceived(sanitizeDigitsInput(event.target.value))}
                      onFocus={() => setActivePaymentField('received')}
                      onBlur={() => setActivePaymentField((current) => (current === 'received' ? null : current))}
                      inputMode="numeric"
                      pattern="[0-9]*"
                      className={getQuantityInputClassName(isPaymentReceivedValid)}
                      placeholder="$ 100.000"
                    />
                  </Field>
                ) : null}

                {(paymentMethod === 'nequi' || paymentMethod === 'bank_transfer' || paymentMethod === 'card') ? (
                  <Field label="Referencia">
                    <input value={paymentReference} onChange={(event) => setPaymentReference(event.target.value)} className={inputClassName} placeholder="Ref. transferencia o ultimos 4 digitos" />
                  </Field>
                ) : null}

                <Field label="Notas">
                  <input value={paymentNotes} onChange={(event) => setPaymentNotes(event.target.value)} className={inputClassName} placeholder="Pago dividido, transferencia de Juan..." />
                </Field>

                <div className="mt-4 grid gap-3 md:grid-cols-2">
                  <SummaryPill label="Aplicar" value={formatCurrency(paymentPreview.amountApplied)} />
                  <SummaryPill label="Cambio / devuelta" value={formatCurrency(paymentPreview.changeDue)} />
                </div>
                {paymentMethod === 'cash' && paymentPreview.changeDue > 0 ? (
                  <div className="mt-3 rounded-[1rem] border border-emerald-300/20 bg-emerald-300/10 px-4 py-3 text-sm font-medium text-emerald-100">
                    Devuelta estimada: {formatCurrency(paymentPreview.changeDue)}
                  </div>
                ) : null}
                {paymentMode === 'items' ? (
                  <div className="mt-3 grid gap-3 md:grid-cols-2">
                    <SummaryPill label="Seleccionado" value={formatCurrency(paymentPreview.selectedRawAmount)} />
                    <SummaryPill label="Exceso" value={formatCurrency(paymentPreview.overage)} />
                  </div>
                ) : null}
                {paymentMode === 'items' && paymentPreview.overage > 0 ? (
                  <p className="mt-3 text-sm text-amberGlow">
                    Seleccionaste mas unidades de las que siguen pendientes. Quita algunas antes de registrar el pago.
                  </p>
                ) : null}
                {selectedOrderHasPendingPayment ? (
                  <p className="mt-3 text-sm text-amberGlow">
                    Esta cuenta ya tiene un pago pendiente por validar. Confirma o rechaza ese movimiento antes de registrar uno nuevo.
                  </p>
                ) : null}

                <button type="button" onClick={() => void handleRecordPayment()} disabled={!canSubmitPayment} className={`${primaryButtonClassName} mt-4`}>
                  Registrar pago
                </button>
                </>
              ) : (
                <EmptyState message="Selecciona una mesa con cuenta activa desde la columna izquierda para operar la caja." />
              )}
            </Panel>
          </div>

          <Panel
            title={
              cashierRightPanel === 'summary'
                ? 'Jornada y resumen del dia'
                : cashierRightPanel === 'previous_sessions'
                  ? 'Jornadas previas'
                  : cashierRightPanel === 'validations'
                    ? 'Validaciones'
                    : 'Movimientos recientes'
            }
            subtitle={
              cashierRightPanel === 'summary'
                ? 'Desde aqui controlas la jornada y ves el pulso real de caja sin perder el contexto del turno.'
                : cashierRightPanel === 'previous_sessions'
                  ? 'Cada jornada cerrada agrupa sus mesas, productos, pagos y cierre en un solo lugar.'
                  : cashierRightPanel === 'validations'
                    ? 'Transferencias y Nequi solo cuando haga falta revisarlas manualmente.'
                    : 'Ultimos eventos operativos y de caja para seguirle la pista al turno.'
            }
          >
            <div className="mb-5 flex flex-wrap gap-2">
              {([
                ['summary', 'Jornada'],
                ['previous_sessions', `Jornadas previas${previousClosedSessions.length ? ` (${previousClosedSessions.length})` : ''}`],
                ['validations', `Validaciones${(posState?.pendingPayments.length ?? 0) ? ` (${posState?.pendingPayments.length ?? 0})` : ''}`],
                ['movements', 'Movimientos'],
              ] as const).map(([tab, label]) => (
                <button
                  key={tab}
                  type="button"
                  onClick={() => setCashierRightPanel(tab)}
                  className={`rounded-full border px-4 py-2 text-[0.68rem] uppercase tracking-[0.22em] transition ${
                    cashierRightPanel === tab ? 'border-cyanGlow/35 bg-cyanGlow/12 text-cyanGlow' : 'border-white/8 bg-white/[0.02] text-mist'
                  }`}
                >
                  {label}
                </button>
              ))}
            </div>

            {cashierRightPanel === 'summary' ? (
              <div className="space-y-5">
                <div className="grid gap-3 sm:grid-cols-2">
                  <SummaryPill
                    label={posState?.activeSalesSession ? 'Jornada activa' : 'Estado de jornada'}
                    value={posState?.activeSalesSession?.sessionLabel ?? 'Sin jornada abierta'}
                  />
                  <SummaryPill
                    label="Fecha contable"
                    value={posState?.activeSalesSession?.businessDate ?? posState?.recentSalesSessions.find((session) => session.status === 'closed')?.businessDate ?? 'Sin cierre'}
                  />
                  <SummaryPill label="Vendido" value={formatCurrency(activeSalesSessionSummary.grossSales)} />
                  <SummaryPill label="Cobrado" value={formatCurrency(activeSalesSessionSummary.totalCollected)} />
                  <SummaryPill label="Pendiente" value={formatCurrency(activeSalesSessionSummary.pendingBalance)} />
                  <SummaryPill label="Pagos por validar" value={String(posState?.pendingPayments.length ?? 0)} />
                  <SummaryPill label="Mesas abiertas" value={String(sessionOpenTableCount)} />
                  <SummaryPill label="Mesas cerradas" value={String(sessionClosedTableCount)} />
                </div>

                <div className="rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                  <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Control de jornada</p>
                  {posState?.activeSalesSession ? (
                    <div className="mt-4 space-y-4">
                      <Field label="Nota de cierre">
                        <input
                          value={salesSessionClosingNotes}
                          onChange={(event) => setSalesSessionClosingNotes(event.target.value)}
                          className={inputClassName}
                          placeholder="Cierre madrugada, caja principal, observaciones..."
                        />
                      </Field>

                      <button
                        type="button"
                        onClick={() => void handleCloseActiveSalesSession()}
                        disabled={Boolean(busyAction) || activeSalesSessionSummary.pendingBalance > 0 || activeSalesSessionSummary.pendingPayments > 0}
                        className={primaryButtonClassName}
                      >
                        Cerrar jornada
                      </button>

                      {activeSalesSessionSummary.pendingBalance > 0 || activeSalesSessionSummary.pendingPayments > 0 ? (
                        <p className="text-sm text-amberGlow">
                          Antes de cerrar debes dejar esta jornada sin saldo pendiente ni pagos por confirmar.
                        </p>
                      ) : null}
                    </div>
                  ) : (
                    <div className="mt-4 space-y-4">
                      <Field label="Nota de apertura">
                        <input
                          value={salesSessionOpeningNotes}
                          onChange={(event) => setSalesSessionOpeningNotes(event.target.value)}
                          className={inputClassName}
                          placeholder="Prueba turno noche, caja principal, observaciones..."
                        />
                      </Field>
                      <button type="button" onClick={() => void handleOpenSalesSession()} disabled={Boolean(busyAction)} className={primaryButtonClassName}>
                        Abrir jornada ahora
                      </button>
                      <p className="text-sm text-mist">Tambien puede abrirse sola cuando se mueve la operacion, pero aqui tienes control explicito para pruebas y turnos reales.</p>
                    </div>
                  )}
                </div>

                <div className="rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                  <div className="flex flex-wrap items-start justify-between gap-3">
                    <div>
                      <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Acceso rapido a jornadas previas</p>
                      <p className="mt-2 text-sm text-mist">Cuando cierres una jornada te llevamos directo a su resumen organizado.</p>
                    </div>
                    <button type="button" onClick={() => setCashierRightPanel('previous_sessions')} className={ghostButtonClassName}>
                      Ver jornadas previas
                    </button>
                  </div>
                  {previousClosedSessions.length ? (
                    <div className="mt-4 rounded-[1rem] border border-white/8 bg-black/15 px-3 py-3 text-sm text-mist">
                      Ultima cerrada: <span className="text-ivory">{previousClosedSessions[0].sessionLabel}</span>
                    </div>
                  ) : (
                    <div className="mt-4 rounded-[1rem] border border-white/8 bg-black/15 px-3 py-3 text-sm text-mist">
                      Todavia no hay jornadas cerradas guardadas.
                    </div>
                  )}
                </div>
              </div>
            ) : null}

            {cashierRightPanel === 'previous_sessions' ? (
              <div className="space-y-4">
                <div className="space-y-3">
                  {previousClosedSessions.map((session) => (
                    <div key={session.id} className="space-y-3">
                      <button
                        ref={(node) => {
                          historicalSessionHeaderRefs.current[session.id] = node;
                        }}
                        type="button"
                        onClick={() => setSelectedHistoricalSessionId((current) => (current === session.id ? null : session.id))}
                        className={`w-full rounded-[1.1rem] border p-4 text-left transition ${
                          selectedHistoricalSession?.id === session.id ? 'border-cyanGlow/28 bg-cyanGlow/10' : 'border-white/8 bg-white/[0.02]'
                        }`}
                      >
                        <div className="flex flex-wrap items-start justify-between gap-3">
                          <div>
                            <p className="font-medium text-ivory">{session.sessionLabel}</p>
                            <p className="mt-1 text-xs uppercase tracking-[0.18em] text-cyanGlow/75">
                              {session.businessDate} · cerrada {session.closedAt ? formatDateTime(session.closedAt) : 'sin hora'}
                            </p>
                          </div>
                          <span className="rounded-full border border-emerald-300/20 bg-emerald-300/10 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-emerald-200">
                            Cerrada
                          </span>
                        </div>
                        <div className="mt-3 grid gap-2 text-sm text-mist sm:grid-cols-2">
                          <p>Vendido: {formatCurrency(session.summary?.grossSales ?? 0)}</p>
                          <p>Cobrado: {formatCurrency(session.summary?.totalCollected ?? 0)}</p>
                          <p>
                            Mesas:{' '}
                            {selectedHistoricalSession?.id === session.id
                              ? selectedHistoricalSessionSales.length
                              : closedSales.filter((order) => order.salesSessionId === session.id).length}
                          </p>
                          <p>Productos: {session.summary?.products.reduce((sum, item) => sum + item.quantity, 0) ?? 0}</p>
                        </div>
                      </button>

                      {selectedHistoricalSession?.id === session.id ? (
                        <div className="space-y-4 rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                          <div className="grid gap-3 sm:grid-cols-2">
                            <SummaryPill label="Jornada" value={selectedHistoricalSession.sessionLabel} />
                            <SummaryPill label="Fecha contable" value={selectedHistoricalSession.businessDate} />
                            <SummaryPill label="Vendido" value={formatCurrency(selectedHistoricalSession.summary?.grossSales ?? 0)} />
                            <SummaryPill label="Cobrado" value={formatCurrency(selectedHistoricalSession.summary?.totalCollected ?? 0)} />
                            <SummaryPill label="Pendiente" value={formatCurrency(selectedHistoricalSession.summary?.pendingBalance ?? 0)} />
                            <SummaryPill label="Mesas cerradas" value={String(selectedHistoricalSessionSales.length)} />
                          </div>

                          <div className="rounded-[1rem] border border-white/8 bg-black/15 p-4">
                            <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Productos vendidos</p>
                            <div className="mt-3 space-y-2">
                              {(selectedHistoricalSession.summary?.products ?? []).slice(0, 10).map((product) => (
                                <div key={`${product.productName}-${product.prepArea}-${product.menuItemSourceKey ?? 'sin-clave'}`} className="flex items-center justify-between gap-3 rounded-[0.9rem] border border-white/8 bg-white/[0.02] px-3 py-2 text-sm">
                                  <div>
                                    <p className="font-medium text-ivory">{product.productName}</p>
                                    <p className="mt-1 text-xs uppercase tracking-[0.18em] text-mist">{product.quantity} unidad(es)</p>
                                  </div>
                                  <p className="text-mist">{formatCurrency(product.totalAmount)}</p>
                                </div>
                              ))}
                              {!(selectedHistoricalSession.summary?.products ?? []).length ? <EmptyState message="No hay productos resumidos en esta jornada." /> : null}
                            </div>
                          </div>

                          <div className="space-y-3">
                            {selectedHistoricalSessionSales.map((order) => (
                              <details key={order.id} className="rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                                <summary className="list-none cursor-pointer">
                                  <div className="flex flex-wrap items-start justify-between gap-3">
                                    <div>
                                      <p className="font-medium text-ivory">{resolveOrderTableLabel(order, tablesById)}</p>
                                      <p className="mt-1 text-xs uppercase tracking-[0.18em] text-cyanGlow/75">
                                        Cerrada {formatDateTime(order.closedAt ?? order.updatedAt)}
                                      </p>
                                    </div>
                                    <span className="rounded-full border border-emerald-300/20 bg-emerald-300/10 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-emerald-200">
                                      Pagada
                                    </span>
                                  </div>
                                  <div className="mt-3 grid gap-2 text-sm text-mist">
                                    <p>Total: {formatCurrency(order.summary.totalDue)}</p>
                                    <p>Pagado: {formatCurrency(order.summary.totalPaid)}</p>
                                    <p>Metodos: {formatPaymentMethodsSummary(order.payments.filter((payment) => payment.status === 'confirmed'))}</p>
                                  </div>
                                </summary>

                                <div className="mt-4 space-y-4 border-t border-white/8 pt-4">
                                  <div>
                                    <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Productos</p>
                                    <div className="mt-3 space-y-2">
                                      {order.items
                                        .filter((item) => item.operationalStatus !== 'cancelled')
                                        .map((item) => (
                                          <div key={item.id} className="rounded-[1rem] border border-white/8 bg-black/15 px-3 py-3 text-sm text-mist">
                                            <div className="flex items-start justify-between gap-3">
                                              <p className="font-medium text-ivory">
                                                {item.quantity} × {item.productName}
                                              </p>
                                              <p>{formatCurrency(item.totalPrice)}</p>
                                            </div>
                                            {item.notes ? <p className="mt-2 text-sm text-cyanGlow">{item.notes}</p> : null}
                                          </div>
                                        ))}
                                    </div>
                                  </div>

                                  <div>
                                    <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">Pagos registrados</p>
                                    <div className="mt-3 space-y-2">
                                      {order.payments.map((payment) => (
                                        <div key={payment.id} className="rounded-[1rem] border border-white/8 bg-black/15 px-3 py-3 text-sm text-mist">
                                          <div className="flex flex-wrap items-start justify-between gap-3">
                                            <div>
                                              <p className="font-medium text-ivory">{paymentMethodLabels[payment.method]}</p>
                                              <p className="mt-1 text-xs uppercase tracking-[0.18em] text-mist">{formatDateTime(payment.confirmedAt ?? payment.createdAt)}</p>
                                            </div>
                                            <div className="text-right">
                                              <p className="font-medium text-ivory">{formatCurrency(payment.amountApplied)}</p>
                                              <p className="mt-1 text-xs uppercase tracking-[0.18em] text-mist">
                                                {payment.status === 'confirmed' ? 'Confirmado' : payment.status === 'rejected' ? 'Rechazado' : 'Pendiente'}
                                              </p>
                                            </div>
                                          </div>
                                          {payment.reference ? <p className="mt-2 text-sm text-amberGlow">{payment.reference}</p> : null}
                                          {payment.notes ? <p className="mt-2 text-sm text-cyanGlow">{payment.notes}</p> : null}
                                        </div>
                                      ))}
                                    </div>
                                  </div>
                                </div>
                              </details>
                            ))}
                            {!selectedHistoricalSessionSales.length ? <EmptyState message="Esta jornada todavia no tiene mesas cerradas asociadas." /> : null}
                          </div>
                        </div>
                      ) : null}
                    </div>
                  ))}
                  {!previousClosedSessions.length ? <EmptyState message="Todavia no hay jornadas cerradas guardadas." /> : null}
                </div>
              </div>
            ) : null}

            {cashierRightPanel === 'validations' ? (
              (posState?.pendingPayments ?? []).length ? (
                <div className="space-y-3">
                  {(posState?.pendingPayments ?? []).map((payment) => {
                    const paymentOrder = ordersById.get(payment.orderId);
                    return (
                      <article
                        key={payment.id}
                        ref={(node) => {
                          pendingPaymentCardRefs.current[payment.id] = node;
                        }}
                        tabIndex={-1}
                        className={`rounded-[1.2rem] border p-4 ${
                          highlightedPendingPaymentId === payment.id ? 'border-cyanGlow/35 bg-cyanGlow/10' : 'border-white/8 bg-black/15'
                        }`}
                      >
                        <div className="flex flex-wrap items-start justify-between gap-3">
                          <div>
                            <p className="font-medium text-ivory">{paymentMethodLabels[payment.method]}</p>
                            <p className="mt-1 text-xs uppercase tracking-[0.18em] text-cyanGlow/75">
                              {paymentOrder ? resolveOrderTableLabel(paymentOrder, tablesById) : 'Mesa sin contexto'}
                            </p>
                            <p className="mt-2 text-sm text-mist">{formatCurrency(payment.amountApplied)}</p>
                            {payment.reference ? <p className="mt-2 text-sm text-amberGlow">{payment.reference}</p> : null}
                            {highlightedPendingPaymentId === payment.id ? (
                              <p className="mt-2 text-sm text-cyanGlow">Pago recien registrado. Confirma o rechaza este movimiento ahora.</p>
                            ) : null}
                          </div>
                          <div className="flex gap-2">
                            <button type="button" onClick={() => void handleConfirmPendingPayment(payment.id)} className={primaryButtonClassName}>
                              Confirmar
                            </button>
                            <button type="button" onClick={() => void handleRejectPendingPayment(payment.id)} className={dangerButtonClassName}>
                              Rechazar
                            </button>
                          </div>
                        </div>
                      </article>
                    );
                  })}
                </div>
              ) : (
                <EmptyState message="No hay transferencias ni pagos manuales pendientes por revisar." />
              )
            ) : null}

            {cashierRightPanel === 'movements' ? (
              <div className="space-y-3">
                {(posState?.logs ?? []).slice(0, 12).map((log) => (
                  <article key={log.id} className="rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
                    <div className="flex flex-wrap items-start justify-between gap-3">
                      <div>
                        <p className="font-medium text-ivory">{formatPosEventLabel(log.eventType)}</p>
                        <p className="mt-1 text-xs uppercase tracking-[0.18em] text-cyanGlow/75">{formatDateTime(log.createdAt)}</p>
                      </div>
                      <span className="rounded-full border border-white/8 bg-black/20 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                        {formatOperatorIdentity(log.actorEmail)}
                      </span>
                    </div>
                    {resolveLogContextLabel(log, ordersById, tablesById) ? (
                      <p className="mt-3 text-sm text-mist">{resolveLogContextLabel(log, ordersById, tablesById)}</p>
                    ) : null}
                    {log.notes ? <p className="mt-2 text-sm text-cyanGlow">{log.notes}</p> : null}
                  </article>
                ))}
                {!(posState?.logs ?? []).length ? <EmptyState message="Todavia no hay movimientos recientes en la trazabilidad POS." /> : null}
              </div>
            ) : null}
          </Panel>
        </section>
      ) : null}
    </AdminLayout>
  );
}

type RealtimeSignalTarget = 'bar' | 'cashier' | 'floor' | 'kitchen';
type RealtimeSignalTone = 'cashier' | 'prep' | 'ready';

interface RealtimeSignal {
  body: string;
  dedupeKey: string;
  target: RealtimeSignalTarget;
  title: string;
  tone: RealtimeSignalTone;
}

function resolveRealtimeSignal(event: PosRealtimeEvent, state: PosState | null, currentActorEmail: string): RealtimeSignal | null {
  if (event.table === 'pos_order_items' && event.eventType === 'UPDATE' && event.newRecord) {
    const newStatus = String(event.newRecord.operational_status ?? '');
    const oldStatus = String(event.oldRecord?.operational_status ?? '');
    const updatedByEmail = String(event.newRecord.updated_by_email ?? event.newRecord.created_by_email ?? '').trim().toLowerCase();

    if (!newStatus || newStatus === oldStatus || updatedByEmail === currentActorEmail) {
      return null;
    }

    const itemId = String(event.newRecord.id ?? '');
    const prepArea = String(event.newRecord.prep_area ?? '');
    const quantity = Number(event.newRecord.quantity ?? 0);
    const productName = String(event.newRecord.product_name ?? 'Producto');
    const tableLabel = resolveRealtimeItemTableLabel(state, itemId);
    const itemSummary = `${quantity > 0 ? `${quantity} x ` : ''}${productName}`;
    const suffix = tableLabel ? ` · ${tableLabel}` : '';

    if (newStatus === 'pending_preparation') {
      return {
        body: `${itemSummary}${suffix}`,
        dedupeKey: `item:${itemId}:pending_preparation`,
        target: prepArea === 'kitchen' ? 'kitchen' : 'bar',
        title: prepArea === 'kitchen' ? 'Nuevo pedido en cocina' : 'Nuevo pedido en bar',
        tone: 'prep',
      };
    }

    if (newStatus === 'ready') {
      return {
        body: `${itemSummary}${suffix}`,
        dedupeKey: `item:${itemId}:ready`,
        target: 'floor',
        title: 'Producto listo para recoger',
        tone: 'ready',
      };
    }

    return null;
  }

  if (event.table === 'pos_payments' && event.eventType === 'INSERT' && event.newRecord) {
    const status = String(event.newRecord.status ?? '');
    const createdByEmail = String(event.newRecord.created_by_email ?? '').trim().toLowerCase();
    if (status !== 'pending' || createdByEmail === currentActorEmail) {
      return null;
    }

    const paymentId = String(event.newRecord.id ?? '');
    const orderId = String(event.newRecord.order_id ?? '');
    const amountApplied = Number(event.newRecord.amount_applied ?? 0);
    const method = String(event.newRecord.method ?? 'pago');
    const order = state?.openOrders.find((entry) => entry.id === orderId) ?? state?.closedSales.find((entry) => entry.id === orderId) ?? null;
    const tableLabel = order ? resolveOrderTableLabel(order, new Map((state?.tables ?? []).map((table) => [table.id, table]))) : '';

    return {
      body: `${paymentMethodLabels[method as PaymentMethod] ?? method} · ${formatCurrency(amountApplied)}${tableLabel ? ` · ${tableLabel}` : ''}`,
      dedupeKey: `payment:${paymentId}:pending`,
      target: 'cashier',
      title: 'Pago pendiente por validar',
      tone: 'cashier',
    };
  }

  return null;
}

function resolveRealtimeItemTableLabel(state: PosState | null, itemId: string) {
  if (!state || !itemId) {
    return '';
  }

  for (const order of [...state.openOrders, ...state.closedSales]) {
    const item = order.items.find((entry) => entry.id === itemId);
    if (!item) {
      continue;
    }

    const table = state.tables.find((entry) => entry.id === order.tableId);
    if (table) {
      return `${table.name} · ${table.code}`;
    }

    if (item.tableName || item.tableCode) {
      return `${item.tableName ?? 'Mesa'}${item.tableCode ? ` · ${item.tableCode}` : ''}`;
    }
  }

  return '';
}

function triggerRealtimeAttention(
  signal: RealtimeSignal,
  audioContext: AudioContext | null,
  recentKeys: Map<string, number>,
) {
  const now = Date.now();
  const recentTs = recentKeys.get(signal.dedupeKey);
  if (recentTs && now - recentTs < 1400) {
    return;
  }

  recentKeys.set(signal.dedupeKey, now);
  for (const [key, timestamp] of recentKeys.entries()) {
    if (now - timestamp > 8000) {
      recentKeys.delete(key);
    }
  }

  playRealtimeTone(audioContext, signal.tone);

  if (typeof navigator !== 'undefined' && typeof navigator.vibrate === 'function') {
    navigator.vibrate(signal.tone === 'ready' ? [160, 80, 160] : [220, 110, 220]);
  }

  if (typeof Notification !== 'undefined' && Notification.permission === 'granted') {
    try {
      const notification = new Notification(signal.title, {
        body: signal.body,
        tag: signal.dedupeKey,
      });
      window.setTimeout(() => notification.close(), 4200);
    } catch {
      // noop
    }
  }
}

function playRealtimeTone(audioContext: AudioContext | null, tone: RealtimeSignalTone) {
  if (!audioContext) {
    return;
  }

  if (audioContext.state === 'suspended') {
    void audioContext.resume().catch(() => {});
  }

  const startAt = audioContext.currentTime;
  const frequencies =
    tone === 'ready'
      ? [880, 1174]
      : tone === 'cashier'
        ? [784, 988]
        : [659, 880];

  frequencies.forEach((frequency, index) => {
    const oscillator = audioContext.createOscillator();
    const gain = audioContext.createGain();
    oscillator.type = tone === 'prep' ? 'square' : 'sine';
    oscillator.frequency.value = frequency;
    gain.gain.setValueAtTime(0.0001, startAt + index * 0.16);
    gain.gain.exponentialRampToValueAtTime(0.06, startAt + index * 0.16 + 0.02);
    gain.gain.exponentialRampToValueAtTime(0.0001, startAt + index * 0.16 + 0.18);
    oscillator.connect(gain);
    gain.connect(audioContext.destination);
    oscillator.start(startAt + index * 0.16);
    oscillator.stop(startAt + index * 0.16 + 0.2);
  });
}

function PreparationQueuePanel({
  areaLabel,
  busyAction,
  items,
  onMoveStatus,
  title,
}: {
  areaLabel: string;
  busyAction: string | null;
  items: PosOrderItem[];
  onMoveStatus: (item: PosOrderItem, nextStatus: 'in_process' | 'ready') => Promise<void>;
  title: string;
}) {
  return (
    <section className="mt-8">
      <Panel title={title} subtitle={`Solo ves la cola operativa que corresponde a ${areaLabel.toLowerCase()}. Cada producto muestra su mesa y origen para facilitar el pickup.`}>
        <div className="space-y-3">
          {items.map((item) => (
            <article key={item.id} className="rounded-[1.2rem] border border-white/8 bg-white/[0.02] p-4">
              <div className="flex flex-wrap items-start justify-between gap-3">
                <div>
                  <p className="font-medium text-ivory">
                    {item.quantity} × {item.productName}
                  </p>
                  <div className="mt-3 flex flex-wrap items-center gap-2">
                    {item.tableName ? (
                      <span className="rounded-full border border-cyanGlow/25 bg-cyanGlow/12 px-3 py-1 text-sm font-semibold uppercase tracking-[0.18em] text-cyanGlow">
                        {item.tableName}
                      </span>
                    ) : null}
                    {item.tableCode ? (
                      <span className="text-xs uppercase tracking-[0.18em] text-cyanGlow/75">Mesa {item.tableCode}</span>
                    ) : null}
                    <span className="text-xs uppercase tracking-[0.18em] text-cyanGlow/75">Tanda {item.serviceRound}</span>
                  </div>
                  <p className="mt-2 text-sm text-mist">Estado: {itemStatusLabels[item.operationalStatus]}</p>
                  <p className="mt-2 text-sm text-mist">
                    Pedido por {item.orderOpenedByEmail ?? item.createdByEmail}
                    {item.orderAssignedStaffEmail ? ` · asignado a ${item.orderAssignedStaffEmail}` : ''}
                  </p>
                  {item.notes ? <p className="mt-2 text-sm text-amberGlow">{item.notes}</p> : null}
                </div>
                <div className="flex flex-wrap gap-2">
                  {['pending_preparation', 'sent'].includes(item.operationalStatus) ? (
                    <button type="button" onClick={() => void onMoveStatus(item, 'in_process')} disabled={Boolean(busyAction)} className={ghostButtonClassName}>
                      En proceso
                    </button>
                  ) : null}
                  {item.operationalStatus === 'in_process' ? (
                    <button type="button" onClick={() => void onMoveStatus(item, 'ready')} disabled={Boolean(busyAction)} className={primaryButtonClassName}>
                      Marcar listo
                    </button>
                  ) : null}
                </div>
              </div>
            </article>
          ))}
          {!items.length ? <EmptyState message="No hay productos pendientes en esta cola por ahora." /> : null}
        </div>
      </Panel>
    </section>
  );
}

function Panel({ children, subtitle, title }: { children: ReactNode; subtitle: string; title: string }) {
  return (
    <section className="rounded-[1.3rem] border border-white/10 bg-white/[0.03] p-4 shadow-[0_18px_40px_rgba(0,0,0,0.2)] sm:rounded-[1.7rem] sm:p-5">
      <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">{title}</p>
      <p className="mt-2 text-sm leading-6 text-mist sm:mt-3 sm:leading-7">{subtitle}</p>
      <div className="mt-3 sm:mt-4">{children}</div>
    </section>
  );
}

function MetricCard({ accent = 'ivory', label, value }: { accent?: 'amber' | 'cyan' | 'emerald' | 'ivory'; label: string; value: string }) {
  const accentClassName =
    accent === 'amber' ? 'text-amberGlow' : accent === 'cyan' ? 'text-cyanGlow' : accent === 'emerald' ? 'text-emerald-200' : 'text-ivory';

  return (
    <article className="rounded-[1.15rem] border border-white/10 bg-white/[0.03] px-4 py-3 sm:rounded-[1.5rem] sm:p-5">
      <div className="flex items-center justify-between gap-3 sm:block">
        <p className="text-[0.62rem] uppercase tracking-[0.22em] text-mist sm:text-[0.68rem] sm:tracking-[0.24em]">{label}</p>
        <p className={`font-display text-[1.35rem] leading-none sm:mt-4 sm:text-[2.2rem] ${accentClassName}`}>{value}</p>
      </div>
    </article>
  );
}

function SummaryPill({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-[1rem] border border-white/8 bg-white/[0.02] px-3 py-2.5 sm:rounded-[1.15rem] sm:px-4 sm:py-3">
      <p className="text-[0.68rem] uppercase tracking-[0.22em] text-mist">{label}</p>
      <p className="mt-2 text-sm font-medium text-ivory">{value}</p>
    </div>
  );
}

function Field({ children, label }: { children: ReactNode; label: string }) {
  return (
    <label className="block">
      <span className="text-[0.68rem] uppercase tracking-[0.24em] text-mist">{label}</span>
      <div className="mt-2">{children}</div>
    </label>
  );
}

function EmptyState({ message }: { message: string }) {
  return <div className="rounded-[1rem] border border-dashed border-white/10 bg-white/[0.02] px-3 py-4 text-sm leading-6 text-mist sm:rounded-[1.2rem] sm:px-4 sm:py-5 sm:leading-7">{message}</div>;
}

function mergeUpdatedItemsIntoPosState(state: PosState, updatedItems: PosOrderItem[]) {
  if (!updatedItems.length) {
    return state;
  }

  const updatesById = new Map(updatedItems.map((item) => [item.id, item]));
  const tables = state.tables.map((table) => {
    if (!table.activeOrder) {
      return table;
    }

    const orderUpdates = updatedItems.filter((item) => item.orderId === table.activeOrder?.id);
    if (!orderUpdates.length) {
      return table;
    }

    const existingItemsById = new Map(table.activeOrder.items.map((item) => [item.id, item]));
    const mergedItems = table.activeOrder.items.map((item) => {
      const updated = updatesById.get(item.id);
      return updated ? { ...item, ...updated } : item;
    });

    for (const updatedItem of orderUpdates) {
      if (!existingItemsById.has(updatedItem.id)) {
        mergedItems.push(updatedItem);
      }
    }

    const summary = buildOrderSummaryForUi(mergedItems, table.activeOrder.payments);

    return {
      ...table,
      activeOrder: {
        ...table.activeOrder,
        financialStatus: deriveOrderFinancialStatusForUi(mergedItems, summary),
        items: mergedItems,
        summary,
      },
    };
  });

  return rebuildDerivedStateFromTables(state, tables);
}

function mergeAddedItemsIntoPosState(state: PosState, selectedTable: PosTableWithOrder, createdItems: PosOrderItem[], actorEmail: string) {
  if (!createdItems.length) {
    return state;
  }

  const now = new Date().toISOString();
  const tables = state.tables.map((table) => {
    if (table.id !== selectedTable.id) {
      return table;
    }

    const existingOrder = table.activeOrder;
    const items = existingOrder ? [...existingOrder.items, ...createdItems] : [...createdItems];
    const payments = existingOrder?.payments ?? [];
    const summary = buildOrderSummaryForUi(items, payments);
    const nextOrder =
      existingOrder != null
        ? {
            ...existingOrder,
            financialStatus: deriveOrderFinancialStatusForUi(items, summary),
            items,
            summary,
          }
        : {
            assignedStaffEmail: actorEmail,
            cancellationReason: null,
            cashierEmail: null,
            closedAt: null,
            createdAt: now,
            financialStatus: 'pending_payment' as const,
            id: createdItems[0].orderId,
            items,
            notes: '',
            openedAt: now,
            openedByEmail: actorEmail,
            payments: [] as typeof payments,
            summary,
            tableId: table.id,
            updatedAt: now,
          };

    return {
      ...table,
      activeOrder: nextOrder,
      activeOrderId: nextOrder.id,
      assignedStaffEmail: table.assignedStaffEmail ?? actorEmail,
      status: 'occupied' as const,
    };
  });

  return rebuildDerivedStateFromTables(state, tables);
}

function mergePaymentIntoPosState(state: PosState, updatedPayment: PosPayment) {
  const tables = state.tables.map((table) => {
    if (!table.activeOrder || table.activeOrder.id !== updatedPayment.orderId) {
      return table;
    }

    const existingIndex = table.activeOrder.payments.findIndex((payment) => payment.id === updatedPayment.id);
    const payments =
      existingIndex >= 0
        ? table.activeOrder.payments.map((payment) => (payment.id === updatedPayment.id ? { ...payment, ...updatedPayment } : payment))
        : [...table.activeOrder.payments, updatedPayment];
    const summary = buildOrderSummaryForUi(table.activeOrder.items, payments);

    return {
      ...table,
      activeOrder: {
        ...table.activeOrder,
        financialStatus: deriveOrderFinancialStatusForUi(table.activeOrder.items, summary),
        payments,
        summary,
      },
    };
  });

  return rebuildDerivedStateFromTables(state, tables);
}

function insertTableIntoPosState(state: PosState, createdTable: PosTable) {
  const tables = [...state.tables, { ...createdTable, activeOrder: null }].sort((left, right) => left.code.localeCompare(right.code));
  return rebuildDerivedStateFromTables(state, tables);
}

function removeTableFromPosState(state: PosState, tableId: string) {
  const tables = state.tables.filter((table) => table.id !== tableId);
  return rebuildDerivedStateFromTables(state, tables);
}

function rebuildDerivedStateFromTables(state: PosState, tables: PosTableWithOrder[]) {
  const openOrders = tables
    .flatMap((table) => (table.activeOrder ? [table.activeOrder] : []))
    .sort((left, right) => right.openedAt.localeCompare(left.openedAt));
  const pendingPayments = openOrders.flatMap((order) => order.payments.filter((payment) => payment.status === 'pending'));
  const { pendingPreparationBar, pendingPreparationKitchen } = buildPendingPreparationListsFromTables(tables);

  return {
    ...state,
    generatedAt: new Date().toISOString(),
    closedSales: state.closedSales,
    openOrders,
    pendingPreparationBar,
    pendingPreparationKitchen,
    pendingPayments,
    tables,
  };
}

function buildOrderSummaryForUi(items: PosOrderItem[], payments: PosPayment[]) {
  const billableItems = items.filter((item) => item.operationalStatus !== 'cancelled' && item.financialStatus !== 'cancelled');
  const subtotal = billableItems.reduce((sum, item) => sum + item.totalPrice, 0);
  const confirmedPayments = payments.filter((payment) => payment.status === 'confirmed');
  const pendingPayments = payments.filter((payment) => payment.status === 'pending');
  const totalPaid = confirmedPayments.reduce((sum, payment) => sum + payment.amountApplied, 0);
  const remainingBalance = Math.max(subtotal - totalPaid, 0);

  return {
    confirmedPayments: confirmedPayments.length,
    pendingPayments: pendingPayments.length,
    remainingBalance,
    subtotal,
    totalDue: subtotal,
    totalPaid,
  };
}

function deriveOrderFinancialStatusForUi(items: PosOrderItem[], summary: ReturnType<typeof buildOrderSummaryForUi>) {
  const activeItems = items.filter((item) => item.operationalStatus !== 'cancelled');
  if (!activeItems.length) {
    return 'cancelled' as const;
  }

  if (summary.remainingBalance <= 0 && summary.totalDue > 0) {
    return 'paid_total' as const;
  }

  if (summary.totalPaid > 0) {
    return 'partially_paid' as const;
  }

  return 'pending_payment' as const;
}

interface SelectablePaymentUnit {
  amount: number;
  itemId: string;
  label: string;
  unitKey: string;
}

function isPaymentUnitKey(value: string) {
  return value.includes('::');
}

function parsePaymentTargetItemId(value: string) {
  return isPaymentUnitKey(value) ? value.split('::')[0] ?? value : value;
}

function buildOutstandingByItem(order: PosOrderWithRelations | null) {
  const outstanding = new Map<string, number>();

  if (!order) {
    return outstanding;
  }

  const activeItems = order.items.filter((item) => item.operationalStatus !== 'cancelled');
  for (const item of activeItems) {
    outstanding.set(item.id, item.totalPrice);
  }

  const confirmedPayments = order.payments
    .filter((payment) => payment.status === 'confirmed')
    .sort((left, right) => left.createdAt.localeCompare(right.createdAt));
  const activeItemsById = new Map(activeItems.map((item) => [item.id, item]));

  for (const payment of confirmedPayments) {
    let remaining = payment.amountApplied;
    const targetIds =
      payment.allocationMode === 'items' && payment.targetItemIds?.length ? payment.targetItemIds : activeItems.map((item) => item.id);

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

function buildSelectablePaymentUnits(order: PosOrderWithRelations | null, outstandingByItem: Map<string, number>) {
  if (!order) {
    return [] as SelectablePaymentUnit[];
  }

  const units: SelectablePaymentUnit[] = [];
  for (const item of order.items) {
    if (item.operationalStatus === 'cancelled') {
      continue;
    }

    const outstandingAmount = outstandingByItem.get(item.id) ?? item.totalPrice;
    if (outstandingAmount <= 0 || item.unitPrice <= 0) {
      continue;
    }

    const remainingUnits = Math.max(Math.round(outstandingAmount / item.unitPrice), 0);
    for (let index = 0; index < remainingUnits; index += 1) {
      units.push({
        amount: item.unitPrice,
        itemId: item.id,
        label: `1 × ${item.productName} · unidad ${index + 1}`,
        unitKey: `${item.id}::${index + 1}`,
      });
    }
  }

  return units;
}

function buildPendingPreparationListsFromTables(tables: PosTableWithOrder[]) {
  const items = tables
    .flatMap((table) => {
      if (!table.activeOrder) {
        return [] as PosOrderItem[];
      }

      return table.activeOrder.items.map((item) => ({
        ...item,
        orderAssignedStaffEmail: table.activeOrder?.assignedStaffEmail,
        orderOpenedByEmail: table.activeOrder?.openedByEmail,
        tableCode: table.code,
        tableId: table.id,
        tableName: table.name,
      }));
    })
    .filter((item) => !['delivered', 'cancelled', 'draft'].includes(item.operationalStatus))
    .sort((left, right) => resolvePreparationQueueTimestampForUi(left).localeCompare(resolvePreparationQueueTimestampForUi(right)));

  return {
    pendingPreparationBar: items.filter((item) => item.prepArea === 'bar'),
    pendingPreparationKitchen: items.filter((item) => item.prepArea === 'kitchen'),
  };
}

function buildLiveSalesSessionSummary(activeSession: PosSalesSession | null, orders: PosOrderWithRelations[]): PosSalesSessionSummary {
  if (!activeSession) {
    return {
      confirmedPayments: 0,
      deliveredProducts: 0,
      grossSales: 0,
      openOrders: 0,
      orderCount: 0,
      paymentMethods: [],
      pendingBalance: 0,
      pendingPayments: 0,
      products: [],
      totalCollected: 0,
    };
  }

  const sessionOrders = orders.filter((order) => order.salesSessionId === activeSession.id);
  const productsMap = new Map<string, PosSalesSessionSummary['products'][number]>();
  const paymentMethodsMap = new Map<string, PosSalesSessionSummary['paymentMethods'][number]>();

  for (const order of sessionOrders) {
    for (const item of order.items) {
      if (item.operationalStatus === 'cancelled' || item.financialStatus === 'cancelled') {
        continue;
      }

      const key = `${item.productName}::${item.prepArea}::${item.menuItemSourceKey ?? ''}`;
      const existing = productsMap.get(key);
      if (existing) {
        existing.quantity += item.quantity;
        existing.totalAmount += item.totalPrice;
      } else {
        productsMap.set(key, {
          menuItemSourceKey: item.menuItemSourceKey,
          prepArea: item.prepArea,
          productName: item.productName,
          quantity: item.quantity,
          totalAmount: item.totalPrice,
        });
      }
    }

    for (const payment of order.payments.filter((entry) => entry.status === 'confirmed')) {
      const existing = paymentMethodsMap.get(payment.method);
      if (existing) {
        existing.paymentCount += 1;
        existing.totalAmount += payment.amountApplied;
      } else {
        paymentMethodsMap.set(payment.method, {
          method: payment.method,
          paymentCount: 1,
          totalAmount: payment.amountApplied,
        });
      }
    }
  }

  return {
    confirmedPayments: sessionOrders.reduce((sum, order) => sum + order.payments.filter((payment) => payment.status === 'confirmed').length, 0),
    deliveredProducts: sessionOrders.reduce(
      (sum, order) => sum + order.items.filter((item) => item.operationalStatus === 'delivered').reduce((acc, item) => acc + item.quantity, 0),
      0,
    ),
    grossSales: sessionOrders.reduce((sum, order) => sum + order.summary.totalDue, 0),
    openOrders: sessionOrders.filter((order) => order.closedAt == null).length,
    orderCount: sessionOrders.length,
    paymentMethods: Array.from(paymentMethodsMap.values()).sort((left, right) => right.totalAmount - left.totalAmount),
    pendingBalance: sessionOrders.reduce((sum, order) => sum + order.summary.remainingBalance, 0),
    pendingPayments: sessionOrders.reduce((sum, order) => sum + order.summary.pendingPayments, 0),
    products: Array.from(productsMap.values()).sort((left, right) => right.quantity - left.quantity || right.totalAmount - left.totalAmount),
    totalCollected: sessionOrders.reduce(
      (sum, order) => sum + order.payments.filter((payment) => payment.status === 'confirmed').reduce((acc, payment) => acc + payment.amountApplied, 0),
      0,
    ),
  };
}

function formatCurrency(value: number) {
  return new Intl.NumberFormat('es-CO', {
    currency: 'COP',
    maximumFractionDigits: 0,
    style: 'currency',
  }).format(value);
}

function formatOperatorIdentity(email: string | null | undefined) {
  if (!email) {
    return 'Sin asignar';
  }

  const localPart = email.split('@')[0] ?? email;
  return localPart
    .replace(/[._-]+/g, ' ')
    .trim()
    .split(/\s+/)
    .filter(Boolean)
    .map((chunk) => chunk.charAt(0).toUpperCase() + chunk.slice(1))
    .join(' ');
}

function resolveOrderTableLabel(order: PosOrderWithRelations, tablesById: Map<string, PosTableWithOrder>) {
  const table = tablesById.get(order.tableId);
  if (!table) {
    return 'Mesa sin referencia';
  }

  return `${table.name} · ${table.code}`;
}

function formatDateTime(value: string) {
  return new Intl.DateTimeFormat('es-CO', {
    day: '2-digit',
    hour: 'numeric',
    minute: '2-digit',
    month: '2-digit',
  }).format(new Date(value));
}

function formatPaymentMethodsSummary(entries: PosPayment[] | PosSalesSessionSummary['paymentMethods']) {
  if (!entries.length) {
    return 'Sin pagos confirmados';
  }

  if (isPosPaymentArray(entries)) {
    const grouped = new Map<PaymentMethod, number>();
    for (const payment of entries) {
      if (payment.status !== 'confirmed') {
        continue;
      }
      grouped.set(payment.method, (grouped.get(payment.method) ?? 0) + payment.amountApplied);
    }

    return Array.from(grouped.entries())
      .sort((left, right) => right[1] - left[1])
      .map(([method, total]) => `${paymentMethodLabels[method]} ${formatCurrency(total)}`)
      .join(' · ');
  }

  return entries.map((entry) => `${paymentMethodLabels[entry.method]} ${formatCurrency(entry.totalAmount)}`).join(' · ');
}

function isPosPaymentArray(entries: PosPayment[] | PosSalesSessionSummary['paymentMethods']): entries is PosPayment[] {
  return entries.length > 0 && 'status' in entries[0];
}

function formatPosEventLabel(eventType: string) {
  const labels: Record<string, string> = {
    items_added: 'Productos agregados',
    item_cancelled: 'Producto cancelado',
    item_delivered: 'Producto entregado',
    item_marked_in_process: 'Producto en proceso',
    item_marked_picking_up: 'Producto en recogida',
    item_marked_ready: 'Producto listo',
    item_payment_status_updated: 'Estado de pago actualizado',
    item_replaced: 'Producto reemplazado',
    item_updated: 'Producto actualizado',
    order_reconciled: 'Cuenta reconciliada',
    payment_recorded: 'Pago registrado',
    sales_session_closed: 'Jornada cerrada',
    sales_session_opened: 'Jornada abierta',
    table_created: 'Mesa creada',
    table_deleted: 'Mesa eliminada',
  };

  return labels[eventType] ?? eventType.replace(/_/g, ' ');
}

function resolveLogContextLabel(
  log: PosState['logs'][number],
  ordersById: Map<string, PosOrderWithRelations>,
  tablesById: Map<string, PosTableWithOrder>,
) {
  if (log.orderId) {
    const order = ordersById.get(log.orderId);
    if (order) {
      return resolveOrderTableLabel(order, tablesById);
    }
  }

  if (log.tableId) {
    const table = tablesById.get(log.tableId);
    if (table) {
      return `${table.name} · ${table.code}`;
    }
  }

  return null;
}

function resolveReplacementAnchorTimestamp(item: PosOrderItem, itemsById: Map<string, PosOrderItem>) {
  let anchor = item;
  const visited = new Set<string>();

  while (anchor.replacementForItemId && !visited.has(anchor.replacementForItemId)) {
    visited.add(anchor.replacementForItemId);
    const previous = itemsById.get(anchor.replacementForItemId);
    if (!previous) {
      break;
    }
    anchor = previous;
  }

  return anchor.sentAt ?? anchor.createdAt;
}

function resolvePreparationQueueTimestampForUi(item: PosOrderItem) {
  return item.sentAt ?? item.createdAt;
}

function parseOptionalNumber(value: string) {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : null;
}

function parseNumber(value: string) {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : 0;
}

function sanitizeDigitsInput(value: string) {
  return value.replace(/[^\d]/g, '');
}

function formatGroupedDigitsInputValue(value: string) {
  if (!value) {
    return '';
  }

  const digits = sanitizeDigitsInput(value);
  if (!digits) {
    return '';
  }

  return new Intl.NumberFormat('es-CO', {
    maximumFractionDigits: 0,
  }).format(Number(digits));
}

function formatCurrencyInputValue(value: string) {
  if (!value) {
    return '';
  }

  const groupedDigits = formatGroupedDigitsInputValue(value);
  return groupedDigits ? `$ ${groupedDigits}` : '';
}

function formatPercentageInputValue(value: string) {
  if (!value) {
    return '';
  }

  const digits = sanitizeDigitsInput(value);
  if (!digits) {
    return '';
  }

  return `${digits} %`;
}

function sanitizePercentageInput(value: string) {
  const digits = sanitizeDigitsInput(value);
  if (!digits) {
    return '';
  }

  return String(Math.min(Number(digits), 100));
}

const inputClassName =
  'w-full rounded-[1rem] border border-white/10 bg-obsidian/50 px-4 py-3 text-sm text-ivory outline-none transition focus:border-cyanGlow/40';
const invalidInputClassName =
  'w-full rounded-[1rem] border border-rose-300/45 bg-obsidian/50 px-4 py-3 text-sm text-ivory outline-none transition focus:border-rose-300/65';
const primaryButtonClassName =
  'rounded-full border border-cyanGlow/28 bg-cyanGlow/12 px-4 py-2.5 text-xs font-semibold uppercase tracking-[0.22em] text-cyanGlow transition hover:border-cyanGlow/42 hover:bg-cyanGlow/18 hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyanGlow/24 disabled:cursor-not-allowed disabled:opacity-60';
const ghostButtonClassName =
  'rounded-full border border-white/14 bg-white/[0.06] px-4 py-2.5 text-xs font-semibold uppercase tracking-[0.22em] text-ivory transition hover:border-cyanGlow/24 hover:bg-white/[0.1] hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-cyanGlow/20';
const dangerButtonClassName =
  'rounded-full border border-rose-300/24 bg-rose-300/12 px-4 py-2.5 text-xs font-semibold uppercase tracking-[0.22em] text-rose-100 transition hover:border-rose-300/38 hover:bg-rose-300/16 hover:text-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rose-300/20';

function getQuantityInputClassName(isValid: boolean) {
  return isValid ? inputClassName : invalidInputClassName;
}

