import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { Locale } from '../models/business';
import type { ExperienceHighlight } from '../models/experience';
import { SectionHeading } from './SectionHeading';

interface ExperienceSectionProps {
  highlights: ExperienceHighlight[];
  dictionary: HomeDictionary;
  locale: Locale;
}

export function ExperienceSection({ highlights, dictionary, locale }: ExperienceSectionProps) {
  return (
    <section id="experience" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <div className="grid gap-10 lg:grid-cols-[0.85fr_1.15fr]">
        <SectionHeading
          eyebrow={dictionary.experience.eyebrow}
          title={dictionary.experience.title}
          description={dictionary.experience.description}
        />
        <div className="grid gap-5">
          {highlights.map((item, index) => (
            <motion.article
              key={item.title.en}
              initial={{ opacity: 0, x: 24 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true, amount: 0.2 }}
              transition={{ duration: 0.55, delay: index * 0.08 }}
              className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6"
            >
              <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">0{index + 1}</p>
              <h3 className="mt-4 font-display text-3xl text-ivory">{item.title[locale]}</h3>
              <p className="mt-4 text-sm leading-7 text-mist">{item.description[locale]}</p>
            </motion.article>
          ))}
        </div>
      </div>
    </section>
  );
}
