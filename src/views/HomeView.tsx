import { useEffect, useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { AboutSection } from '../components/AboutSection';
import { ContactSection } from '../components/ContactSection';
import { ExperienceSection } from '../components/ExperienceSection';
import { Footer } from '../components/Footer';
import { GallerySection } from '../components/GallerySection';
import { HeroSection } from '../components/HeroSection';
import { LocationSection } from '../components/LocationSection';
import { MenuSection } from '../components/MenuSection';
import { NavBar } from '../components/NavBar';
import { getHomePageData } from '../controllers/homeController';
import { loadMenuData } from '../controllers/menuController';
import type { Locale } from '../models/business';
import { buildFallbackFeaturedMenuItem, buildFeaturedMenuItems } from '../models/menu';
import { getVisibleMenuItems, normalizeMenuCategory, type MenuDataItem } from '../models/menuData';

const defaultLocale: Locale = 'es';

export function HomeView() {
  const location = useLocation();
  const [locale, setLocale] = useState<Locale>(defaultLocale);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [menuItems, setMenuItems] = useState<MenuDataItem[]>([]);
  const { business, gallery, highlights, dictionary } = getHomePageData(locale);

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  useEffect(() => {
    if ((location.state as { scrollToTop?: boolean } | null)?.scrollToTop) {
      window.scrollTo({ top: 0, left: 0, behavior: 'auto' });
    }
  }, [location.state]);

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

  const featuredMenu = buildFeaturedMenuItems(menuItems);
  const featuredMenuFallback = menuItems
    .filter((item) => normalizeMenuCategory(item.tipo) === 'cocteles' && item.imagen)
    .slice(0, 7)
    .map(buildFallbackFeaturedMenuItem);
  const renderedFeaturedMenu = featuredMenu.length ? featuredMenu : featuredMenuFallback;

  return (
    <div className="bg-obsidian text-ivory">
      <NavBar
        business={business}
        dictionary={dictionary}
        locale={locale}
        onLocaleChange={setLocale}
        onMobileMenuChange={setIsMobileMenuOpen}
        reserveLabel={business.reserveLabel[locale]}
      />
      <main className="relative overflow-hidden">
        <HeroSection business={business} metrics={dictionary.metrics} dictionary={dictionary} locale={locale} />
        <div className="desktop-section-shell desktop-section-divider">
          <AboutSection business={business} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <MenuSection items={renderedFeaturedMenu} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <GallerySection gallery={gallery} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <ExperienceSection highlights={highlights} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <ContactSection business={business} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <LocationSection business={business} dictionary={dictionary} locale={locale} />
        </div>
      </main>
      <Footer business={business} dictionary={dictionary} locale={locale} />
      <div
        className={`fixed inset-x-4 bottom-[calc(1rem+env(safe-area-inset-bottom))] z-40 transform-gpu transition-[opacity,transform] duration-300 ease-[cubic-bezier(0.22,1,0.36,1)] md:hidden ${
          isMobileMenuOpen
            ? 'pointer-events-none translate-y-3 scale-[0.985] opacity-0'
            : 'translate-y-0 scale-100 opacity-100'
        }`}
      >
        <div className="flex items-center gap-2.5 rounded-[1.35rem] border border-sapphire/15 bg-[rgba(10,12,20,0.74)] p-2 shadow-[0_18px_44px_rgba(0,0,0,0.24)] backdrop-blur-lg">
          <a
            href={business.primaryCta.href}
            target="_blank"
            rel="noreferrer"
            className="inline-flex min-h-11 flex-1 items-center justify-center rounded-full bg-ivory px-4 py-2.5 text-xs font-bold uppercase tracking-[0.18em] text-obsidian"
          >
            {business.primaryCta.label[locale]}
          </a>
          <Link
            to="/menu"
            className="inline-flex min-h-11 flex-1 items-center justify-center rounded-full border border-white/10 bg-white/[0.03] px-4 py-2.5 text-xs font-semibold uppercase tracking-[0.18em] text-ivory"
          >
            {locale === 'es' ? 'Ver carta completa' : 'View full menu'}
          </Link>
        </div>
      </div>
    </div>
  );
}
