import zafiroLogoWhite from '../assets/zafiro-logo-white.png';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';

interface FooterProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function Footer({ business, dictionary, locale }: FooterProps) {
  const socialProfiles = business.socialProfiles.filter((profile) => profile.label.en !== 'WhatsApp');

  return (
    <footer className="border-t border-white/10">
      <div className="mx-auto grid max-w-7xl gap-8 px-5 py-10 sm:px-6 lg:px-8 xl:max-w-[90rem] xl:grid-cols-12 xl:gap-6 2xl:px-10">
        <div className="interactive-card rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.18),_transparent_32%),rgba(255,255,255,0.03)] p-6 xl:col-span-5 xl:p-8">
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
            {dictionary.footer.eyebrow}
          </p>

          <div className="mt-5 flex items-center gap-4 xl:gap-5">
            <img
              src={zafiroLogoWhite}
              alt={`${business.name} logo`}
              className="h-12 w-auto object-contain sm:h-14 xl:h-16"
            />
            <div>
              <p className="font-display text-3xl text-ivory sm:text-4xl xl:text-[3.2rem]">{business.shortName}</p>
              <p className="mt-1 text-xs uppercase tracking-[0.28em] text-mist">{business.tagline[locale]}</p>
            </div>
          </div>

          <p className="mt-5 max-w-xl text-sm leading-7 text-mist xl:text-[1.02rem] xl:leading-8">
            {business.footerDescription[locale]}
          </p>
          <p className="mt-6 max-w-lg font-display text-[1.9rem] leading-tight text-ivory/95 sm:text-[2.2rem] xl:text-[2.8rem]">
            {business.closingPhrase[locale]}
          </p>
          <p className="mt-5 max-w-xl border-t border-white/10 pt-5 text-sm leading-7 text-mist">
            {dictionary.footer.closingNote}
          </p>
        </div>

        <div className="interactive-card rounded-[1.75rem] border border-white/10 bg-white/[0.04] p-6 text-sm text-mist xl:col-span-3 xl:p-7">
          <p className="text-xs font-semibold uppercase tracking-[0.35em] text-amberGlow">
            {dictionary.footer.contactLabel}
          </p>
          <p className="mt-4 max-w-sm leading-7">{dictionary.footer.contactDescription}</p>

          <div className="interactive-card mt-5 rounded-2xl border border-white/10 bg-obsidian/55 p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
              {business.primaryCta.label[locale]}
            </p>
            <a
              href={business.primaryCta.href}
              target="_blank"
              rel="noreferrer"
              className="interactive-link mt-2 inline-block text-ivory transition hover:text-cyanGlow"
            >
              {business.primaryCta.value?.[locale]}
            </a>
          </div>

          <p className="mt-5 border-t border-white/10 pt-5 leading-7">{business.footerNote[locale]}</p>
        </div>

        <div className="interactive-card rounded-[1.75rem] border border-white/10 bg-white/[0.04] p-6 text-sm text-mist xl:col-span-4 xl:p-7">
          <div className="flex items-center justify-between gap-4 border-b border-white/10 pb-4">
            <p className="text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
              {dictionary.footer.socialLabel}
            </p>
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-mist">{dictionary.footer.rights}</p>
          </div>

          <div className="mt-5 grid gap-3">
            {socialProfiles.map((profile) => (
              <a
                key={profile.label.en}
                href={profile.href}
                target="_blank"
                rel="noreferrer"
                className="interactive-card rounded-2xl border border-white/10 bg-obsidian/55 px-4 py-4 transition hover:border-cyanGlow/30 hover:text-ivory"
              >
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                  {profile.label[locale]}
                </p>
                <p className="mt-2 leading-7 text-ivory">{profile.value[locale]}</p>
                <p className="mt-2 leading-7 text-mist">{profile.helper[locale]}</p>
              </a>
            ))}
          </div>

          <div className="interactive-card mt-5 rounded-2xl border border-white/10 bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))] px-4 py-4">
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
              {dictionary.footer.availabilityLabel}
            </p>
            <p className="mt-2 leading-7 text-ivory">{dictionary.footer.availabilityDescription}</p>
          </div>
        </div>
      </div>
    </footer>
  );
}
