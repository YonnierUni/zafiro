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
          Desde aquí se administrará el menú, disponibilidad, destacados y precios.
        </p>
      </section>

      <section className="mt-10 grid gap-5 lg:grid-cols-[minmax(0,1.15fr)_minmax(18rem,0.85fr)]">
        <article className="rounded-[1.9rem] border border-white/10 bg-[linear-gradient(135deg,rgba(36,107,255,0.12),rgba(255,255,255,0.03))] p-6 shadow-[0_18px_40px_rgba(0,0,0,0.24)]">
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-cyanGlow/80">Próximo módulo</p>
          <h2 className="mt-3 font-display text-[2rem] text-ivory sm:text-[2.4rem]">Menú</h2>
          <p className="mt-3 max-w-xl text-sm leading-7 text-mist sm:text-base">
            Esta sección será la base para gestionar productos visibles, disponibilidad, destacados, orden, precios e
            imágenes del menú público.
          </p>
        </article>

        <article className="rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6">
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-amberGlow">Estado</p>
          <div className="mt-4 inline-flex rounded-full border border-amberGlow/25 bg-amberGlow/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.22em] text-amberGlow">
            En preparación
          </div>
          <p className="mt-5 text-sm leading-7 text-mist">
            En el siguiente paso se empezará a estructurar el módulo interno del menú sin afectar la web pública.
          </p>
        </article>
      </section>
    </AdminLayout>
  );
}
