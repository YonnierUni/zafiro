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
      <main>
        <HeroSection business={business} metrics={dictionary.metrics} dictionary={dictionary} locale={locale} />
        <AboutSection business={business} dictionary={dictionary} locale={locale} />
        <MenuSection items={featuredMenu} dictionary={dictionary} locale={locale} />
        <GallerySection gallery={gallery} dictionary={dictionary} locale={locale} />
        <ExperienceSection highlights={highlights} dictionary={dictionary} locale={locale} />
        <ContactSection business={business} dictionary={dictionary} locale={locale} />
        <LocationSection business={business} dictionary={dictionary} locale={locale} />
      </main>
      <Footer business={business} dictionary={dictionary} locale={locale} />
    </div>
  );
}
