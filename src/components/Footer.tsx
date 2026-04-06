import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';

interface FooterProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function Footer({ business, dictionary, locale }: FooterProps) {
  return (
    <footer className="border-t border-white/10">
      <div className="mx-auto grid max-w-7xl gap-8 px-5 py-10 sm:px-6 lg:grid-cols-[1.2fr_0.9fr_0.9fr] lg:px-8">
        <div className="rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.16),_transparent_35%),rgba(255,255,255,0.03)] p-6">
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
            {dictionary.footer.eyebrow}
          </p>
          <div className="mt-4 flex items-center gap-4">
            <img
              src={zafiroLogoWhite}
              alt={`${business.name} logo`}
              className="h-12 w-auto object-contain sm:h-14"
            />
            <div>
              <p className="font-display text-3xl text-ivory sm:text-4xl">{business.shortName}</p>
              <p className="mt-1 text-xs uppercase tracking-[0.28em] text-mist">{business.tagline[locale]}</p>
            </div>
          </div>
          <p className="mt-3 max-w-md text-sm leading-7 text-mist">{business.footerDescription[locale]}</p>
          <p className="mt-5 max-w-md text-base leading-8 text-ivory/90">{business.closingPhrase[locale]}</p>
          <p className="mt-4 max-w-md text-sm leading-7 text-mist">{dictionary.footer.closingNote}</p>
        </div>

        <div className="rounded-[1.75rem] border border-white/10 bg-white/[0.04] p-6 text-sm text-mist">
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-amberGlow">
            {dictionary.footer.contactLabel}
          </p>
          <p className="mt-4 max-w-sm leading-7">{dictionary.footer.contactDescription}</p>
          <div className="mt-5 rounded-2xl border border-white/10 bg-obsidian/55 p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
              {business.primaryCta.label[locale]}
            </p>
            <a
              href={business.primaryCta.href}
              target="_blank"
              rel="noreferrer"
              className="mt-2 block text-ivory transition hover:text-cyanGlow"
            >
              {business.primaryCta.value?.[locale]}
            </a>
            <p className="mt-3 leading-7 text-mist">{business.primaryCta.helper?.[locale]}</p>
          </div>
          <div className="mt-3 rounded-2xl border border-dashed border-white/10 bg-white/[0.03] p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
              {locale === 'es' ? 'Canal directo futuro' : 'Future direct line'}
            </p>
            <p className="mt-2 leading-7">
              {locale === 'es'
                ? 'Espacio reservado para una linea oficial de llamadas o atencion rapida.'
                : 'Reserved space for an official phone line or quick-response channel.'}
            </p>
          </div>
        </div>

        <div className="rounded-[1.75rem] border border-white/10 bg-white/[0.04] p-6 text-sm text-mist lg:text-right">
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
            {dictionary.footer.socialLabel}
          </p>
          <div className="mt-5 grid gap-3">
            {business.socialProfiles.map((profile) => (
              <a
                key={profile.label.en}
                href={profile.href}
                target="_blank"
                rel="noreferrer"
                className="rounded-2xl border border-white/10 bg-obsidian/55 px-4 py-4 text-left transition hover:border-cyanGlow/30 hover:text-ivory"
              >
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                  {profile.label[locale]}
                </p>
                <p className="mt-2 leading-7 text-ivory">{profile.value[locale]}</p>
                <p className="mt-2 leading-7 text-mist">{profile.helper[locale]}</p>
              </a>
            ))}
          </div>
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
            {dictionary.footer.availabilityLabel}
          </p>
          <p className="mt-5 leading-7">
            {business.city}, {business.region}
          </p>
          <p className="leading-7">{dictionary.footer.availabilityDescription}</p>
          <p className="mt-4 leading-7">{business.footerNote[locale]}</p>
          <p className="mt-5 leading-7">{dictionary.footer.rights}</p>
        </div>
      </div>
    </footer>
  );
}
