import { useEffect, useState } from 'react';
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
import type { Locale } from '../models/business';

const defaultLocale: Locale = 'es';

export function HomeView() {
  const [locale, setLocale] = useState<Locale>(defaultLocale);
  const { business, featuredMenu, gallery, highlights, dictionary } = getHomePageData(locale);

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  return (
    <div className="bg-obsidian text-ivory">
      <NavBar
        business={business}
        dictionary={dictionary}
        locale={locale}
        onLocaleChange={setLocale}
        reserveLabel={business.reserveLabel[locale]}
      />
      <main className="relative overflow-hidden">
        <HeroSection business={business} metrics={dictionary.metrics} dictionary={dictionary} locale={locale} />
        <div className="desktop-section-shell desktop-section-divider">
          <AboutSection business={business} dictionary={dictionary} locale={locale} />
        </div>
        <div className="desktop-section-shell desktop-section-divider">
          <MenuSection items={featuredMenu} dictionary={dictionary} locale={locale} />
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
      <div className="fixed inset-x-4 bottom-4 z-40 md:hidden">
        <div className="flex items-center gap-3 rounded-[1.4rem] border border-white/10 bg-obsidian/85 p-3 shadow-glow backdrop-blur-xl">
          <a
            href={business.primaryCta.href}
            target="_blank"
            rel="noreferrer"
            className="inline-flex flex-1 items-center justify-center rounded-full bg-ivory px-4 py-3 text-xs font-bold uppercase tracking-[0.18em] text-obsidian"
          >
            {business.primaryCta.label[locale]}
          </a>
          <a
            href={business.secondaryCta.href}
            className="inline-flex flex-1 items-center justify-center rounded-full border border-white/10 bg-white/[0.04] px-4 py-3 text-xs font-semibold uppercase tracking-[0.18em] text-ivory"
          >
            {business.secondaryCta.label[locale]}
          </a>
        </div>
      </div>
    </div>
  );
}
