import type { ReactNode } from 'react';
import { Link } from 'react-router-dom';
import zafiroLogoWhite from '../assets/zafiro-logo-white.png';

interface AdminLayoutProps {
  children: ReactNode;
}

export function AdminLayout({ children }: AdminLayoutProps) {
  return (
    <div className="min-h-screen bg-obsidian text-ivory">
      <header className="sticky top-0 z-40 border-b border-white/10 bg-obsidian/80 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-5 py-4 sm:px-6 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
          <div className="flex items-center gap-3">
            <img src={zafiroLogoWhite} alt="ZAFIRO Bar Lounge logo" className="h-10 w-auto object-contain sm:h-11" />
            <div>
              <p className="font-display text-2xl tracking-[0.18em] text-ivory">ZAFIRO Admin</p>
              <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">
                Panel interno de administración
              </p>
            </div>
          </div>

          <Link
            to="/"
            className="interactive-button rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.24em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08]"
          >
            Volver al sitio
          </Link>
        </div>
      </header>

      <main className="mx-auto max-w-7xl px-5 py-12 sm:px-6 sm:py-16 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
        {children}
      </main>
    </div>
  );
}
