import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';
import { SocialIcon } from './SocialIcon';

interface ContactSectionProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function ContactSection({ business, dictionary, locale }: ContactSectionProps) {
  const instagramProfile = business.socialProfiles.find((profile) => profile.label.en === 'Instagram');

  return (
    <section id="contact" className="mx-auto max-w-7xl px-5 py-12 sm:px-6 sm:py-24 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: 24 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, amount: 0.3 }}
        transition={{ duration: 0.7 }}
        className="interactive-card overflow-hidden rounded-[2rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.28),_transparent_35%),linear-gradient(135deg,_rgba(255,255,255,0.08),_rgba(255,255,255,0.03))] p-5 shadow-glow sm:p-10"
      >
        <p className="text-[0.68rem] uppercase tracking-[0.3em] text-cyanGlow/80 sm:text-xs sm:tracking-[0.35em]">
          {dictionary.contact.eyebrow}
        </p>
        <div className="mt-4 flex flex-col gap-5 lg:mt-6 lg:flex-row lg:items-end lg:justify-between lg:gap-8">
          <div className="max-w-2xl">
            <h2 className="font-display text-[2.8rem] leading-[0.94] text-ivory sm:text-6xl">
              {dictionary.contact.title}
            </h2>
            <p className="mt-4 hidden text-sm leading-7 text-mist sm:block sm:text-base">{dictionary.contact.description}</p>
            <div className="mt-4 grid gap-3 sm:mt-5 sm:grid-cols-2">
              <a
                href={business.primaryCta.href}
                target="_blank"
                rel="noreferrer"
                className="interactive-card group rounded-2xl border border-white/10 bg-obsidian/45 px-4 py-3"
              >
                <div className="flex items-center gap-2 text-cyanGlow/80">
                  <SocialIcon kind="whatsapp" />
                  <p className="text-[0.68rem] font-semibold uppercase tracking-[0.24em]">
                    {business.primaryCta.label[locale]}
                  </p>
                </div>
                <p className="mt-2 text-sm text-ivory transition group-hover:text-ivory/90">{business.primaryCta.value?.[locale]}</p>
                <p className="mt-2 hidden text-sm text-mist sm:block">{business.primaryCta.helper?.[locale]}</p>
              </a>
              <a
                href={instagramProfile?.href}
                target="_blank"
                rel="noreferrer"
                className="interactive-card group rounded-2xl border border-white/10 bg-obsidian/45 px-4 py-3"
              >
                <div className="flex items-center gap-2 text-amberGlow">
                  <SocialIcon kind="instagram" />
                  <p className="text-[0.68rem] font-semibold uppercase tracking-[0.24em]">Instagram</p>
                </div>
                <p className="mt-2 text-sm text-ivory transition group-hover:text-ivory/90">{instagramProfile?.value[locale]}</p>
                <p className="mt-2 hidden text-sm text-mist sm:block">{instagramProfile?.helper[locale]}</p>
              </a>
            </div>
          </div>
          <a
            href={business.primaryCta.href}
            target="_blank"
            rel="noreferrer"
            className="interactive-button inline-flex w-full items-center justify-center rounded-full bg-ivory px-6 py-3.5 text-sm font-bold uppercase tracking-[0.18em] text-obsidian transition hover:bg-amberGlow sm:w-auto sm:px-7 sm:py-3"
          >
            {business.primaryCta.label[locale]}
          </a>
        </div>
      </motion.div>
    </section>
  );
}
