import { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import { Footer } from '../components/Footer';
import { FullMenuSection } from '../components/FullMenuSection';
import { getHomePageData } from '../controllers/homeController';
import { loadMenuData } from '../controllers/menuController';
import type { Locale } from '../models/business';
import { getVisibleMenuItems, type MenuDataItem } from '../models/menuData';

const defaultLocale: Locale = 'es';

export function MenuView() {
  const navigate = useNavigate();
  const [locale, setLocale] = useState<Locale>(defaultLocale);
  const [menuItems, setMenuItems] = useState<MenuDataItem[]>([]);
  const { business, dictionary } = getHomePageData(locale);

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  useEffect(() => {
    window.scrollTo({ top: 0, left: 0, behavior: 'auto' });
  }, []);

  const goHomeToTop = () => {
    navigate('/', { state: { scrollToTop: true } });
  };

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
              state={{ scrollToTop: true }}
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
        <div className="mx-auto max-w-7xl px-5 pt-5 sm:px-6 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
          <button
            type="button"
            onClick={goHomeToTop}
            className="interactive-link inline-flex text-xs font-semibold uppercase tracking-[0.24em] text-cyanGlow/80 sm:text-[0.68rem]"
          >
            {locale === 'es' ? '← Volver al inicio' : '← Back home'}
          </button>
        </div>
        <FullMenuSection items={menuItems} dictionary={dictionary} locale={locale} />
      </main>

      <Footer business={business} dictionary={dictionary} locale={locale} />
      <div className="fixed inset-x-4 bottom-[calc(1rem+env(safe-area-inset-bottom))] z-40 md:hidden">
        <div className="flex items-center gap-2.5 rounded-[1.35rem] border border-sapphire/15 bg-[rgba(10,12,20,0.74)] p-2 shadow-[0_18px_44px_rgba(0,0,0,0.24)] backdrop-blur-lg">
          <button
            type="button"
            onClick={goHomeToTop}
            className="interactive-button inline-flex min-h-11 flex-1 items-center justify-center rounded-full border border-white/10 bg-white/[0.03] px-4 py-2.5 text-xs font-semibold uppercase tracking-[0.18em] text-ivory"
          >
            {locale === 'es' ? 'Volver al inicio' : 'Home'}
          </button>
          <a
            href={business.primaryCta.href}
            target="_blank"
            rel="noreferrer"
            className="interactive-button inline-flex min-h-11 flex-1 items-center justify-center rounded-full bg-ivory px-4 py-2.5 text-xs font-bold uppercase tracking-[0.18em] text-obsidian"
          >
            {locale === 'es' ? 'Reservar' : 'Reserve'}
          </a>
        </div>
      </div>
    </div>
  );
}
