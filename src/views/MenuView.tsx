import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import { Footer } from '../components/Footer';
import { FullMenuSection } from '../components/FullMenuSection';
import { getHomePageData } from '../controllers/homeController';
import { loadMenuData } from '../controllers/menuController';
import type { Locale } from '../models/business';
import { getVisibleMenuItems, type MenuDataItem } from '../models/menuData';

const defaultLocale: Locale = 'es';

export function MenuView() {
  const [locale, setLocale] = useState<Locale>(defaultLocale);
  const [menuItems, setMenuItems] = useState<MenuDataItem[]>([]);
  const { business, dictionary } = getHomePageData(locale);

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  useEffect(() => {
    let isMounted = true;

    loadMenuData()
      .then((data) => {
        if (isMounted) {
          setMenuItems(getVisibleMenuItems(data.items));
        }
      })
      .catch((error) => {
        console.error('Unable to load menu data.', error);

        if (isMounted) {
          setMenuItems([]);
        }
      });

    return () => {
      isMounted = false;
    };
  }, []);

  return (
    <div className="bg-obsidian text-ivory">
      <header className="sticky top-0 z-50 border-b border-white/10 bg-obsidian/65 backdrop-blur-xl">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-4 px-5 py-4 sm:px-6 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
          <Link to="/" className="interactive-button flex items-center gap-3 rounded-full text-ivory">
            <img src={zafiroLogoWhite} alt={`${business.name} logo`} className="h-10 w-auto object-contain sm:h-11" />
            <span className="hidden font-display text-2xl tracking-[0.18em] text-ivory sm:block">
              {business.shortName}
            </span>
          </Link>

          <div className="flex items-center gap-3">
            <div className="hidden rounded-full border border-white/10 bg-white/5 p-1 md:flex">
              {(['en', 'es'] as const).map((option) => (
                <button
                  key={option}
                  type="button"
                  onClick={() => setLocale(option)}
                  className={`interactive-button rounded-full px-3 py-2 text-xs font-semibold uppercase tracking-[0.22em] transition ${
                    locale === option ? 'bg-ivory text-obsidian' : 'text-mist hover:text-ivory'
                  }`}
                >
                  {dictionary.languageToggle[option]}
                </button>
              ))}
            </div>

            <Link
              to="/"
              className="interactive-button hidden rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.24em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08] sm:block"
            >
              {locale === 'es' ? 'Volver al inicio' : 'Back home'}
            </Link>

            <a
              href={business.primaryCta.href}
              target="_blank"
              rel="noreferrer"
              className="interactive-button rounded-full border border-sapphire/40 bg-sapphire/15 px-4 py-2 text-xs font-semibold uppercase tracking-[0.25em] text-ivory transition hover:border-cyanGlow/50 hover:bg-sapphire/25"
            >
              {business.reserveLabel[locale]}
            </a>
          </div>
        </div>
      </header>

      <main className="relative overflow-hidden">
        <FullMenuSection items={menuItems} dictionary={dictionary} locale={locale} />
      </main>

      <Footer business={business} dictionary={dictionary} locale={locale} />
    </div>
  );
}
