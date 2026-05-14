import type { MenuCategory } from '../models/menuData';
import { normalizeMenuCategory } from '../models/menuData';

interface MenuImagePlaceholderProps {
  category: MenuCategory | string;
  className?: string;
}

export function MenuImagePlaceholder({ category, className = '' }: MenuImagePlaceholderProps) {
  const normalizedCategory = normalizeMenuCategory(category);

  return (
    <div
      className={`relative flex h-full w-full items-center justify-center overflow-hidden bg-[radial-gradient(circle_at_50%_18%,rgba(36,107,255,0.22),transparent_32%),radial-gradient(circle_at_72%_68%,rgba(235,184,92,0.14),transparent_28%),linear-gradient(145deg,rgba(8,12,24,0.96),rgba(3,5,11,0.98)_58%,rgba(9,13,24,1))] ${className}`}
    >
      <div className="absolute inset-0 bg-[linear-gradient(120deg,rgba(255,255,255,0.08),transparent_30%,rgba(255,255,255,0.035)_62%,transparent)] opacity-60" />
      <div className="absolute inset-6 rounded-[1.2rem] border border-white/8 shadow-[inset_0_0_42px_rgba(36,107,255,0.08)]" />
      <div className="relative flex flex-col items-center gap-3 text-center">
        <div className="flex h-14 w-14 items-center justify-center rounded-full border border-white/12 bg-white/[0.045] text-cyanGlow shadow-[0_0_34px_rgba(36,107,255,0.18)] backdrop-blur-md">
          <MenuFallbackIcon category={normalizedCategory} />
        </div>
        <p className="px-5 text-[0.68rem] font-semibold uppercase tracking-[0.26em] text-ivory/85">
          Imagen próximamente
        </p>
      </div>
    </div>
  );
}

function MenuFallbackIcon({ category }: { category: MenuCategory }) {
  if (category === 'comida') {
    return (
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-7 w-7" fill="none" stroke="currentColor" strokeWidth="1.45">
        <path d="M5 3v18" strokeLinecap="round" />
        <path d="M8 3v6a3 3 0 0 1-6 0V3" strokeLinecap="round" strokeLinejoin="round" />
        <path d="M16 3c2.2 1.3 3.5 3.5 3.5 6.2 0 2.4-1 4.3-2.7 5.7V21" strokeLinecap="round" strokeLinejoin="round" />
      </svg>
    );
  }

  if (category === 'bebidas') {
    return (
      <svg aria-hidden="true" viewBox="0 0 24 24" className="h-7 w-7" fill="none" stroke="currentColor" strokeWidth="1.45">
        <path d="M9 3h6" strokeLinecap="round" />
        <path d="M10 3v4.2l-1.8 2.1A4.6 4.6 0 0 0 7 12.3V19a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2v-6.7a4.6 4.6 0 0 0-1.2-3L14 7.2V3" strokeLinecap="round" strokeLinejoin="round" />
        <path d="M8 14h8" strokeLinecap="round" />
      </svg>
    );
  }

  return (
    <svg aria-hidden="true" viewBox="0 0 24 24" className="h-7 w-7" fill="none" stroke="currentColor" strokeWidth="1.45">
      <path d="M8 3h8l-1 8.3a3 3 0 0 1-6 0L8 3Z" strokeLinejoin="round" />
      <path d="M12 14v7" strokeLinecap="round" />
      <path d="M8.5 21h7" strokeLinecap="round" />
      <path d="M9 7h6" strokeLinecap="round" />
    </svg>
  );
}
