import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';
import { SectionHeading } from './SectionHeading';

interface AboutSectionProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function AboutSection({ business, dictionary, locale }: AboutSectionProps) {
  return (
    <section id="about" className="mx-auto max-w-7xl px-5 py-20 sm:px-6 sm:py-24 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <div className="grid gap-8 lg:grid-cols-12 lg:gap-10 xl:gap-12">
        <div className="lg:col-span-5 xl:col-span-4">
          <SectionHeading
            eyebrow={dictionary.about.eyebrow}
            title={dictionary.about.title}
            description={business.story[locale]}
          />
        </div>

        <motion.div
          initial={{ opacity: 0, y: 18 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.2 }}
          transition={{ duration: 0.7 }}
          className="grid gap-4 sm:grid-cols-2 sm:gap-5 lg:col-span-7 lg:grid-cols-6 lg:grid-rows-[minmax(12rem,1fr)_minmax(10rem,1fr)] xl:gap-6"
        >
          <div className="rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.16),_transparent_34%),rgba(255,255,255,0.04)] p-5 shadow-glow sm:p-6 lg:col-span-3 lg:row-span-2 xl:p-7">
            <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/80">
              {dictionary.about.atmosphereLabel}
            </p>
            <p className="mt-4 text-sm leading-6 text-mist xl:text-[1rem] xl:leading-7">
              {business.ambiance[locale]}
            </p>
            <div className="mt-6 rounded-2xl border border-white/10 bg-obsidian/45 px-4 py-4">
              <p className="text-[0.68rem] uppercase tracking-[0.24em] text-amberGlow">
                {business.signatureMoodLabel[locale]}
              </p>
              <p className="mt-3 text-sm leading-6 text-ivory/90">{business.signatureMoodText[locale]}</p>
            </div>
          </div>

          <div className="rounded-[1.75rem] border border-white/10 bg-gradient-to-br from-sapphire/15 via-white/5 to-transparent p-5 sm:p-6 lg:col-span-3 xl:p-7">
            <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">{dictionary.about.whyPeopleCome}</p>
            <ul className="mt-4 space-y-2.5 text-sm leading-6 text-mist">
              {dictionary.about.bullets.map((bullet) => (
                <li key={bullet} className="border-b border-white/10 pb-3 last:border-b-0 last:pb-0">
                  {bullet}
                </li>
              ))}
            </ul>
          </div>

          <div className="rounded-[1.75rem] border border-white/10 bg-white/[0.04] p-5 sm:p-6 lg:col-span-3 xl:p-7">
            <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
              {locale === 'es' ? 'Identidad del lugar' : 'Venue identity'}
            </p>
            <p className="mt-4 font-display text-[1.7rem] leading-tight text-ivory sm:text-[2rem] xl:text-[2.35rem]">
              {business.identityLine[locale]}
            </p>
            <p className="mt-4 text-sm leading-6 text-mist">
              {locale === 'es'
                ? 'Pensado para noches que se sienten especiales desde la primera copa, sin perder calidez ni cercanía.'
                : 'Designed for nights that feel elevated from the first drink, without losing warmth or approachability.'}
            </p>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
