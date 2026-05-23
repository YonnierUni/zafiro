import { Link, Navigate } from 'react-router-dom';
import { AdminLayout } from './AdminLayout';
import { useSupabaseAuth } from '../auth/SupabaseAuthProvider';

export function AdminView() {
  const { canAccessCatalog, canAccessPos, staffProfile } = useSupabaseAuth();

  if (canAccessPos && !canAccessCatalog) {
    return <Navigate to="/admin/pos" replace />;
  }

  if (canAccessCatalog && !canAccessPos) {
    return <Navigate to="/admin/menu" replace />;
  }

  const availableModules = [
    canAccessCatalog
      ? {
          cta: 'Abrir modulo de menu',
          description: 'Revision interna de productos, visibilidad, disponibilidad, destacados, orden y precios del menu publico.',
          title: 'Menu',
          to: '/admin/menu',
          tone: 'catalog',
        }
      : null,
    canAccessPos
      ? {
          cta: 'Abrir operacion POS',
          description: 'Operacion por mesas, productos por pedido, preparacion separada y caja parcial o total en tiempo real.',
          title: 'Mini POS / Mesas',
          to: '/admin/pos',
          tone: 'pos',
        }
      : null,
  ].filter(Boolean) as Array<{
    cta: string;
    description: string;
    title: string;
    to: string;
    tone: 'catalog' | 'pos';
  }>;

  return (
    <AdminLayout>
      <section className="max-w-3xl">
        <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">ZAFIRO Admin</p>
        <h1 className="mt-4 font-display text-[2.8rem] leading-none text-ivory sm:text-[3.6rem]">Panel interno de administracion</h1>
        <p className="mt-5 max-w-2xl text-base leading-8 text-mist sm:text-lg">
          Desde aqui entras solo a los modulos que tu cuenta tiene habilitados dentro del backoffice operativo de ZAFIRO.
        </p>
      </section>

      <section className="mt-10 grid gap-5 xl:grid-cols-[minmax(0,1.05fr)_minmax(0,1.05fr)_minmax(18rem,0.8fr)]">
        {availableModules.map((module) => (
          <Link
            key={module.to}
            to={module.to}
            className={`interactive-card rounded-[1.9rem] border border-white/10 p-6 shadow-[0_18px_40px_rgba(0,0,0,0.24)] transition hover:border-cyanGlow/30 ${
              module.tone === 'catalog'
                ? 'bg-[linear-gradient(135deg,rgba(36,107,255,0.12),rgba(255,255,255,0.03))]'
                : 'bg-[linear-gradient(135deg,rgba(9,28,58,0.92),rgba(36,107,255,0.12))]'
            }`}
          >
            <p className="text-[0.68rem] uppercase tracking-[0.26em] text-cyanGlow/80">Modulo habilitado</p>
            <h2 className="mt-3 font-display text-[2rem] text-ivory sm:text-[2.4rem]">{module.title}</h2>
            <p className="mt-3 max-w-xl text-sm leading-7 text-mist sm:text-base">{module.description}</p>
            <span className="interactive-link mt-5 inline-flex text-xs font-semibold uppercase tracking-[0.24em] text-cyanGlow/85">
              {module.cta}
            </span>
          </Link>
        ))}

        <article className="rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6">
          <p className="text-[0.68rem] uppercase tracking-[0.26em] text-amberGlow">Tu acceso</p>
          <div className="mt-4 inline-flex rounded-full border border-emerald-300/25 bg-emerald-300/10 px-4 py-2 text-xs font-semibold uppercase tracking-[0.22em] text-emerald-200">
            {availableModules.length} modulo(s)
          </div>
          <p className="mt-5 text-sm leading-7 text-mist">
            {staffProfile
              ? `${staffProfile.fullName} solo vera lo que su sesion tiene habilitado. Si una cuenta no tiene menu, no se muestra menu. Si no tiene POS, no entra a POS.`
              : 'El backoffice ya puede filtrar vistas por permisos reales sin afectar la web publica.'}
          </p>
        </article>
      </section>
    </AdminLayout>
  );
}
