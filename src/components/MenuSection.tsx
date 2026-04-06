import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { Locale } from '../models/business';
import type { MenuItem } from '../models/menu';
import { SectionHeading } from './SectionHeading';

interface MenuSectionProps {
  items: MenuItem[];
  dictionary: HomeDictionary;
  locale: Locale;
}

export function MenuSection({ items, dictionary, locale }: MenuSectionProps) {
  return (
    <section id="menu" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <SectionHeading
        eyebrow={dictionary.menu.eyebrow}
        title={dictionary.menu.title}
        description={dictionary.menu.description}
      />
      <div className="mt-12 grid gap-5 md:grid-cols-2 xl:grid-cols-3">
        {items.map((item, index) => (
          <motion.article
            key={item.name}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.55, delay: index * 0.06 }}
            className={`rounded-[1.75rem] border border-white/10 bg-gradient-to-br ${item.accent} p-[1px]`}
          >
            <div className="h-full rounded-[1.7rem] bg-midnight/90 p-6">
              <div className="flex items-start justify-between gap-4">
                <div>
                  <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/75">{item.category[locale]}</p>
                  <h3 className="mt-3 font-display text-3xl text-ivory">{item.name}</h3>
                </div>
                <span className="rounded-full border border-white/10 bg-white/5 px-3 py-2 text-sm font-semibold text-amberGlow">
                  {item.price}
                </span>
              </div>
              <p className="mt-5 text-sm leading-7 text-mist">{item.description[locale]}</p>
            </div>
          </motion.article>
        ))}
      </div>
    </section>
  );
}
