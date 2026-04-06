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
    <section id="experience" className="mx-auto max-w-7xl px-5 py-20 sm:px-6 sm:py-24 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <div className="grid gap-8 lg:grid-cols-12 lg:gap-10 xl:gap-12">
        <div className="lg:col-span-4">
          <SectionHeading
            eyebrow={dictionary.experience.eyebrow}
            title={dictionary.experience.title}
            description={dictionary.experience.description}
          />
        </div>

        <div className="grid gap-4 sm:gap-5 lg:col-span-8 lg:grid-cols-8 lg:grid-rows-[minmax(14rem,1fr)_minmax(12rem,1fr)] xl:gap-6">
          {highlights.map((item, index) => (
            <motion.article
              key={item.title.en}
              initial={{ opacity: 0, x: 24 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true, amount: 0.2 }}
              transition={{ duration: 0.55, delay: index * 0.08 }}
              className={`rounded-[1.75rem] border border-white/10 p-5 sm:p-6 xl:p-7 ${getExperienceCardClasses(index)}`}
            >
              <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">0{index + 1}</p>
              <h3
                className={`mt-4 font-display leading-none text-ivory ${
                  index === 0 ? 'text-[2.1rem] sm:text-[2.35rem] xl:text-[2.9rem]' : 'text-[2rem] sm:text-3xl'
                }`}
              >
                {item.title[locale]}
              </h3>
              <p className={`mt-4 text-sm leading-6 text-mist ${index === 0 ? 'xl:max-w-[34ch] xl:text-[1rem] xl:leading-7' : ''}`}>
                {item.description[locale]}
              </p>
              {index === 0 ? (
                <div className="mt-6 hidden h-px bg-gradient-to-r from-cyanGlow/30 via-white/15 to-transparent lg:block" />
              ) : null}
            </motion.article>
          ))}
        </div>
      </div>
    </section>
  );
}

function getExperienceCardClasses(index: number) {
  switch (index) {
    case 0:
      return 'bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.18),_transparent_32%),rgba(255,255,255,0.04)] shadow-glow lg:col-span-5 lg:row-span-2';
    case 1:
      return 'bg-[radial-gradient(circle_at_top_right,_rgba(214,165,93,0.14),_transparent_28%),rgba(255,255,255,0.04)] lg:col-span-3';
    case 2:
      return 'bg-white/[0.04] lg:col-span-3';
    default:
      return 'bg-white/[0.04]';
  }
}
