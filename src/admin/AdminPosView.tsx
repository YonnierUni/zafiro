import { Link } from 'react-router-dom';
import type { Order, Table, TableType, TableZone } from '../shared/operations/operations.types';
import { AdminLayout } from './AdminLayout';
import { adminPosOrders, adminPosPayments, adminPosStaff, adminPosTables } from './mockPosData';

interface TableCardModel {
  table: Table;
  order?: Order;
  waiterName?: string;
  paymentPendingCount: number;
  visualState: 'available' | 'occupied' | 'partially_paid' | 'reserved';
}

const zoneLabels: Record<TableZone, string> = {
  salon: 'Salón',
  bar: 'Barra',
  terrace: 'Terraza',
  vip: 'VIP',
  other: 'Otra zona',
};

const typeLabels: Record<TableType, string> = {
  fixed: 'Fija',
  temporary: 'Temporal',
};

const formatCurrency = (value: number) =>
  new Intl.NumberFormat('es-CO', {
    style: 'currency',
    currency: 'COP',
    maximumFractionDigits: 0,
  }).format(value);

const getVisualState = (table: Table, order?: Order): TableCardModel['visualState'] => {
  if (table.status === 'reserved') return 'reserved';
  if (order?.status === 'partially_paid') return 'partially_paid';
  if (table.status === 'occupied' || order?.status === 'open') return 'occupied';
  return 'available';
};

const stateConfig: Record<
  TableCardModel['visualState'],
  {
    label: string;
    accent: string;
    pill: string;
    border: string;
  }
> = {
  available: {
    label: 'Disponible',
    accent: 'text-emerald-300',
    pill: 'border border-emerald-400/25 bg-emerald-400/10 text-emerald-200',
    border: 'border-emerald-400/18',
  },
  occupied: {
    label: 'Ocupada',
    accent: 'text-cyanGlow',
    pill: 'border border-cyanGlow/25 bg-cyanGlow/10 text-cyanGlow',
    border: 'border-cyanGlow/20',
  },
  partially_paid: {
    label: 'Pago parcial',
    accent: 'text-amberGlow',
    pill: 'border border-amberGlow/25 bg-amberGlow/10 text-amberGlow',
    border: 'border-amberGlow/22',
  },
  reserved: {
    label: 'Reservada',
    accent: 'text-fuchsia-200',
    pill: 'border border-fuchsia-300/25 bg-fuchsia-300/10 text-fuchsia-100',
    border: 'border-fuchsia-300/18',
  },
};

const tableCards: TableCardModel[] = adminPosTables.map((table) => {
  const order = adminPosOrders.find((entry) => entry.id === table.activeOrderId);
  const waiter = adminPosStaff.find((staff) => staff.id === table.assignedStaffUserId);
  const paymentPendingCount = order
    ? adminPosPayments.filter((payment) => payment.orderId === order.id && payment.status === 'pending').length
    : 0;

  return {
    table,
    order,
    waiterName: waiter?.name,
    paymentPendingCount,
    visualState: getVisualState(table, order),
  };
});

const openOrders = adminPosOrders.filter((order) => order.status === 'open' || order.status === 'partially_paid');
const partialOrders = adminPosOrders.filter((order) => order.status === 'partially_paid');
const totalPending = openOrders.reduce((sum, order) => sum + order.paymentSummary.remainingBalance, 0);
const pendingPaymentsCount = adminPosPayments.filter((payment) => payment.status === 'pending').length;

const futureSections = [
  {
    title: 'Cuenta activa',
    description:
      'Aquí se consolidará el detalle de la mesa en curso, los productos cargados, descuentos simples y saldos pendientes.',
  },
  {
    title: 'Búsqueda rápida de productos',
    description:
      'Luego permitirá buscar productos mientras se escribe para agregar pedidos con velocidad desde caja o desde el mesero.',
  },
  {
    title: 'Pagos y cambio',
    description:
      'Más adelante reunirá abonos parciales, pagos por producto, monto recibido, cambio y confirmaciones de Nequi o transferencia.',
  },
  {
    title: 'Caja',
    description:
      'Servirá como base para efectivo esperado, pagos pendientes por confirmar y un cierre operativo simple al final del turno.',
  },
];

export function AdminPosView() {
  return (
    <AdminLayout>
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div className="max-w-3xl">
          <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">Mini POS / Mesas</p>
          <h1 className="mt-4 font-display text-[2.6rem] leading-none text-ivory sm:text-[3.4rem]">
            Operación por mesas
          </h1>
          <p className="mt-5 max-w-2xl text-base leading-8 text-mist sm:text-lg">
            Esta primera vista mock organiza mesas, cuentas abiertas y señales operativas clave para la futura caja de
            ZAFIRO, sin tocar todavía backend ni persistencia real.
          </p>
        </div>

        <div className="flex flex-wrap items-center gap-3">
          <button
            type="button"
            disabled
            className="rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.24em] text-ivory/60"
          >
            Crear mesa adicional
          </button>
          <span className="rounded-full border border-amberGlow/25 bg-amberGlow/10 px-4 py-2 text-[0.68rem] font-semibold uppercase tracking-[0.22em] text-amberGlow">
            Próximamente
          </span>
          <Link
            to="/admin"
            className="interactive-button rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.24em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08]"
          >
            Volver a admin
          </Link>
        </div>
      </section>

      <section className="mt-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
        <article className="rounded-[1.6rem] border border-white/10 bg-[linear-gradient(145deg,rgba(36,107,255,0.12),rgba(255,255,255,0.03))] p-5 shadow-[0_16px_36px_rgba(0,0,0,0.2)]">
          <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Mesas abiertas</p>
          <p className="mt-4 font-display text-[2.2rem] leading-none text-ivory">{openOrders.length}</p>
          <p className="mt-3 text-sm leading-6 text-mist">Mesas con cuenta activa en curso.</p>
        </article>
        <article className="rounded-[1.6rem] border border-white/10 bg-[linear-gradient(145deg,rgba(255,184,77,0.12),rgba(255,255,255,0.03))] p-5 shadow-[0_16px_36px_rgba(0,0,0,0.2)]">
          <p className="text-[0.68rem] uppercase tracking-[0.24em] text-amberGlow">Pago parcial</p>
          <p className="mt-4 font-display text-[2.2rem] leading-none text-ivory">{partialOrders.length}</p>
          <p className="mt-3 text-sm leading-6 text-mist">Cuentas que ya recibieron abonos.</p>
        </article>
        <article className="rounded-[1.6rem] border border-white/10 bg-[linear-gradient(145deg,rgba(11,18,32,0.96),rgba(255,255,255,0.03))] p-5 shadow-[0_16px_36px_rgba(0,0,0,0.2)]">
          <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Pendiente por cobrar</p>
          <p className="mt-4 font-display text-[2.2rem] leading-none text-ivory">{formatCurrency(totalPending)}</p>
          <p className="mt-3 text-sm leading-6 text-mist">Saldo vivo entre mesas abiertas y parciales.</p>
        </article>
        <article className="rounded-[1.6rem] border border-white/10 bg-[linear-gradient(145deg,rgba(150,120,255,0.12),rgba(255,255,255,0.03))] p-5 shadow-[0_16px_36px_rgba(0,0,0,0.2)]">
          <p className="text-[0.68rem] uppercase tracking-[0.24em] text-ivory/70">Por confirmar</p>
          <p className="mt-4 font-display text-[2.2rem] leading-none text-ivory">{pendingPaymentsCount}</p>
          <p className="mt-3 text-sm leading-6 text-mist">Pagos Nequi o transferencia pendientes de validar.</p>
        </article>
      </section>

      <section className="mt-10">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Vista mock</p>
            <h2 className="mt-3 font-display text-[2rem] text-ivory sm:text-[2.5rem]">Mesas activas del turno</h2>
          </div>
          <p className="max-w-2xl text-sm leading-7 text-mist sm:text-right sm:text-base">
            Esta fase muestra cómo se verá el pulso operativo del bar: mesas disponibles, reservas, cuentas abiertas y
            pagos parciales en una sola lectura.
          </p>
        </div>

        <div className="mt-6 grid gap-5 lg:grid-cols-2 xl:grid-cols-3">
          {tableCards.map(({ table, order, waiterName, paymentPendingCount, visualState }) => {
            const config = stateConfig[visualState];
            const paid = order?.paymentSummary.totalPaid ?? 0;
            const pending = order?.paymentSummary.remainingBalance ?? 0;
            const total = order?.paymentSummary.totalDue ?? 0;

            return (
              <article
                key={table.id}
                className={`overflow-hidden rounded-[1.85rem] border bg-[linear-gradient(180deg,rgba(255,255,255,0.04),rgba(10,10,12,0.96))] shadow-[0_18px_42px_rgba(0,0,0,0.22)] ${config.border}`}
              >
                <div className="border-b border-white/8 bg-[radial-gradient(circle_at_top,rgba(36,107,255,0.16),transparent_58%)] px-5 py-5">
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <p className="text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/75">{table.code}</p>
                      <h3 className="mt-3 font-display text-[1.9rem] leading-none text-ivory">{table.name}</h3>
                    </div>
                    <span className={`rounded-full px-3 py-1.5 text-[0.68rem] font-semibold uppercase tracking-[0.22em] ${config.pill}`}>
                      {config.label}
                    </span>
                  </div>

                  <div className="mt-4 flex flex-wrap gap-2">
                    <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                      {zoneLabels[table.zone]}
                    </span>
                    <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                      {typeLabels[table.type]}
                    </span>
                    {table.capacity ? (
                      <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                        {table.capacity} puestos
                      </span>
                    ) : null}
                  </div>
                </div>

                <div className="space-y-4 px-5 py-5">
                  <div className="grid gap-3 sm:grid-cols-2">
                    <div className="rounded-2xl border border-white/8 bg-white/[0.03] p-4">
                      <p className="text-[0.68rem] uppercase tracking-[0.22em] text-ivory/55">Mesero</p>
                      <p className="mt-2 text-sm font-medium text-ivory">{waiterName ?? 'Sin asignar'}</p>
                    </div>
                    <div className="rounded-2xl border border-white/8 bg-white/[0.03] p-4">
                      <p className="text-[0.68rem] uppercase tracking-[0.22em] text-ivory/55">Cuenta</p>
                      <p className={`mt-2 text-sm font-medium ${config.accent}`}>
                        {order ? config.label : 'Sin consumo activo'}
                      </p>
                    </div>
                  </div>

                  {order ? (
                    <div className="rounded-[1.4rem] border border-white/8 bg-black/20 p-4">
                      <div className="grid gap-3 sm:grid-cols-3">
                        <div>
                          <p className="text-[0.68rem] uppercase tracking-[0.22em] text-ivory/55">Total</p>
                          <p className="mt-2 text-sm font-medium text-ivory">{formatCurrency(total)}</p>
                        </div>
                        <div>
                          <p className="text-[0.68rem] uppercase tracking-[0.22em] text-ivory/55">Pagado</p>
                          <p className="mt-2 text-sm font-medium text-emerald-200">{formatCurrency(paid)}</p>
                        </div>
                        <div>
                          <p className="text-[0.68rem] uppercase tracking-[0.22em] text-ivory/55">Pendiente</p>
                          <p className="mt-2 text-sm font-medium text-amberGlow">{formatCurrency(pending)}</p>
                        </div>
                      </div>

                      <div className="mt-4 flex flex-wrap gap-2">
                        <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-mist">
                          {order.items.length} productos en cuenta
                        </span>
                        {paymentPendingCount > 0 ? (
                          <span className="rounded-full border border-fuchsia-300/20 bg-fuchsia-300/10 px-3 py-1 text-[0.65rem] uppercase tracking-[0.22em] text-fuchsia-100">
                            {paymentPendingCount} pago pendiente por confirmar
                          </span>
                        ) : null}
                      </div>
                    </div>
                  ) : (
                    <div className="rounded-[1.4rem] border border-dashed border-white/10 bg-white/[0.02] p-4 text-sm leading-7 text-mist">
                      {table.status === 'reserved'
                        ? table.notes ?? 'Reserva programada para esta mesa.'
                        : 'Lista para recibir una nueva cuenta cuando se habilite el flujo operativo real.'}
                    </div>
                  )}

                  {table.notes && order ? <p className="text-sm leading-7 text-mist">{table.notes}</p> : null}
                </div>
              </article>
            );
          })}
        </div>
      </section>

      <section className="mt-10 grid gap-5 xl:grid-cols-4">
        {futureSections.map((section) => (
          <article
            key={section.title}
            className="rounded-[1.7rem] border border-white/10 bg-white/[0.03] p-5 shadow-[0_14px_32px_rgba(0,0,0,0.18)]"
          >
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Siguiente capa</p>
            <h3 className="mt-3 font-display text-[1.65rem] leading-none text-ivory">{section.title}</h3>
            <p className="mt-3 text-sm leading-7 text-mist">{section.description}</p>
          </article>
        ))}
      </section>
    </AdminLayout>
  );
}
