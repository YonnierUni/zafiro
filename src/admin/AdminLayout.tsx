import type { ReactNode } from 'react';
import { Link, useLocation } from 'react-router-dom';
import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import { useSupabaseAuth } from '../auth/SupabaseAuthProvider';

interface AdminLayoutProps {
  children: ReactNode;
}

const roleLabels: Record<string, string> = {
  superadmin: 'Superadmin',
  waiter: 'Mesero',
  kitchen: 'Cocina',
  bar: 'Bar',
  cashier: 'Caja',
};

export function AdminLayout({ children }: AdminLayoutProps) {
  const { canAccessCatalog, canAccessPos, isAuthenticated, signOut, staffProfile, staffRoles, user } = useSupabaseAuth();
  const location = useLocation();
  const primaryRole = staffRoles[0] ? roleLabels[staffRoles[0]] ?? staffRoles[0] : null;
  const shouldShowAdminHubLink = isAuthenticated && canAccessCatalog && canAccessPos && location.pathname !== '/admin';

  return (
    <div className="min-h-screen bg-obsidian text-ivory">
      <header className="sticky top-0 z-40 border-b border-white/10 bg-obsidian/80 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl flex-col gap-3 px-4 py-3 sm:px-6 sm:py-4 lg:flex-row lg:items-center lg:justify-between lg:px-8 xl:max-w-[90rem] 2xl:px-10">
          <div className="flex min-w-0 items-center gap-3">
            <img src={zafiroLogoWhite} alt="ZAFIRO Bar Lounge logo" className="h-8 w-auto object-contain sm:h-11" />
            <div>
              <p className="font-display text-lg tracking-[0.12em] text-ivory sm:text-2xl sm:tracking-[0.18em]">ZAFIRO Admin</p>
              <p className="text-[0.62rem] uppercase tracking-[0.18em] text-cyanGlow/80 sm:text-[0.68rem] sm:tracking-[0.24em]">Panel interno</p>
            </div>
          </div>

          <div className="flex w-full flex-wrap items-center justify-start gap-2 lg:w-auto lg:justify-end lg:gap-3">
            {isAuthenticated ? (
              <>
                <div className="max-w-full truncate rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-[0.62rem] uppercase tracking-[0.18em] text-mist sm:px-4 sm:py-2 sm:text-[0.68rem] sm:tracking-[0.22em]">
                  {staffProfile?.fullName ?? user?.email ?? 'Sesion activa'}
                </div>
                {primaryRole ? (
                  <div className="rounded-full border border-cyanGlow/20 bg-cyanGlow/10 px-3 py-1.5 text-[0.62rem] uppercase tracking-[0.18em] text-cyanGlow sm:px-4 sm:py-2 sm:text-[0.68rem] sm:tracking-[0.22em]">
                    {`${primaryRole} ZAFIRO`}
                  </div>
                ) : null}
              </>
            ) : null}
            {shouldShowAdminHubLink ? (
              <Link
                to="/admin"
                className="interactive-button rounded-full border border-cyanGlow/20 bg-cyanGlow/10 px-3 py-1.5 text-[0.68rem] font-semibold uppercase tracking-[0.18em] text-cyanGlow transition hover:border-cyanGlow/35 hover:bg-cyanGlow/14 hover:text-white sm:px-4 sm:py-2 sm:text-xs sm:tracking-[0.24em]"
              >
                Volver al panel
              </Link>
            ) : null}
            {isAuthenticated ? (
              <button
                type="button"
                onClick={() => void signOut()}
                className="interactive-button rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-[0.68rem] font-semibold uppercase tracking-[0.18em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08] sm:px-4 sm:py-2 sm:text-xs sm:tracking-[0.24em]"
              >
                Cerrar sesion
              </button>
            ) : null}
            <Link
              to="/"
              className="interactive-button rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-[0.68rem] font-semibold uppercase tracking-[0.18em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08] sm:px-4 sm:py-2 sm:text-xs sm:tracking-[0.24em]"
            >
              Volver al sitio
            </Link>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-7xl px-4 py-7 sm:px-6 sm:py-16 lg:px-8 xl:max-w-[90rem] 2xl:px-10">{children}</main>
    </div>
  );
}
