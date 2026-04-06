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
    <section id="about" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <div className="grid gap-10 lg:grid-cols-[0.95fr_1.05fr]">
        <SectionHeading
          eyebrow={dictionary.about.eyebrow}
          title={dictionary.about.title}
          description={business.story[locale]}
        />
        <motion.div
          initial={{ opacity: 0, y: 18 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.2 }}
          transition={{ duration: 0.7 }}
          className="grid gap-5 sm:grid-cols-2"
        >
          <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 shadow-glow">
            <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/80">
              {dictionary.about.atmosphereLabel}
            </p>
            <p className="mt-4 text-sm leading-7 text-mist">{business.ambiance[locale]}</p>
          </div>
          <div className="rounded-[1.75rem] border border-white/10 bg-gradient-to-br from-sapphire/15 via-white/5 to-transparent p-6">
            <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">{dictionary.about.whyPeopleCome}</p>
            <ul className="mt-4 space-y-3 text-sm leading-7 text-mist">
              {dictionary.about.bullets.map((bullet) => (
                <li key={bullet}>{bullet}</li>
              ))}
            </ul>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
