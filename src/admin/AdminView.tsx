import { Link } from 'react-router-dom';
import { AdminLayout } from './AdminLayout';

export function AdminView() {
  return (
    <AdminLayout>
      <section className="max-w-3xl">
        <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">ZAFIRO Admin</p>
        <h1 className="mt-4 font-display text-[2.8rem] leading-none text-ivory sm:text-[3.6rem]">
          Panel interno de administración
        </h1>
        <p className="mt-5 max-w-2xl text-base leading-8 text-mist sm:text-lg">
          Desde aquí se administrará el menú, la operación por mesas, pagos parciales y herramientas internas.
        </p>
      </section>

      <section className="mt-10 grid gap-5 xl:grid-cols-[minmax(0,1.05fr)_minmax(0,1.05fr)_minmax(18rem,0.8fr)]">
        <Link
          to="/admin/menu"
          className="interactive-card rounded-[1.9rem] border border-white/10 bg-[linear-gradient(135deg,rgba(36,107,255,0.12),rgba(255,255,255,0.03))] p-6 shadow-[0_18px_40px_rgba(0,0,0,0.24)] transition hover:border-cyanGlow/30"
        >
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-cyanGlow/80">Módulo activo</p>
          <h2 className="mt-3 font-display text-[2rem] text-ivory sm:text-[2.4rem]">Menú</h2>
          <p className="mt-3 max-w-xl text-sm leading-7 text-mist sm:text-base">
            Revisión interna de productos, visibilidad, disponibilidad, destacados, orden y precios del menú público.
          </p>
          <span className="interactive-link mt-5 inline-flex text-xs font-semibold uppercase tracking-[0.24em] text-cyanGlow/85">
            Abrir módulo de menú
          </span>
        </Link>

        <Link
          to="/admin/pos"
          className="interactive-card rounded-[1.9rem] border border-white/10 bg-[linear-gradient(135deg,rgba(9,28,58,0.92),rgba(36,107,255,0.12))] p-6 shadow-[0_18px_40px_rgba(0,0,0,0.24)] transition hover:border-cyanGlow/30"
        >
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-cyanGlow/80">Próximamente</p>
          <h2 className="mt-3 font-display text-[2rem] text-ivory sm:text-[2.4rem]">Mini POS / Mesas</h2>
          <p className="mt-3 max-w-xl text-sm leading-7 text-mist sm:text-base">
            Operación por mesas, cuentas abiertas, pagos parciales, cambio y caja en una sola base interna.
          </p>
          <span className="interactive-link mt-5 inline-flex text-xs font-semibold uppercase tracking-[0.24em] text-cyanGlow/85">
            Ver pantalla base
          </span>
        </Link>

        <article className="rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6">
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-amberGlow">Estado</p>
          <div className="mt-4 inline-flex rounded-full border border-amberGlow/25 bg-amberGlow/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.22em] text-amberGlow">
            En preparación
          </div>
          <p className="mt-5 text-sm leading-7 text-mist">
            Este panel ya puede leer el menú actual y dejar preparado el futuro Mini POS sin afectar la web pública.
          </p>
        </article>
      </section>
    </AdminLayout>
  );
}
