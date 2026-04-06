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
    <section id="menu" className="mx-auto max-w-7xl px-5 py-20 sm:px-6 sm:py-24 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <SectionHeading
        eyebrow={dictionary.menu.eyebrow}
        title={dictionary.menu.title}
        description={dictionary.menu.description}
      />
      <div className="mt-10 grid gap-4 sm:mt-12 sm:gap-5 md:grid-cols-2 xl:grid-cols-12 xl:auto-rows-[minmax(17rem,_1fr)]">
        {items.map((item, index) => (
          <motion.article
            key={item.name}
            initial={{ opacity: 0, y: 20 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true, amount: 0.2 }}
            transition={{ duration: 0.55, delay: index * 0.06 }}
            className={`interactive-card rounded-[1.75rem] border border-white/10 bg-gradient-to-br ${item.accent} p-[1px] ${getMenuLayoutClasses(index)}`}
          >
            <div className="h-full overflow-hidden rounded-[1.7rem] bg-midnight/90">
              <div className={`relative overflow-hidden border-b border-white/10 bg-obsidian ${getMenuImageAspectClasses(index)}`}>
                <img
                  src={item.imageSrc}
                  alt={item.imageAlt[locale]}
                  loading="lazy"
                  className={`h-full w-full object-cover transition duration-700 hover:scale-[1.05] ${index === 0 ? 'xl:scale-[1.02]' : ''}`}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-midnight via-midnight/20 to-transparent" />
                <div className="absolute inset-x-0 bottom-0 flex items-end justify-between gap-3 p-4 sm:p-5">
                  <p className="max-w-[70%] text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80 sm:text-xs">
                    {item.category[locale]}
                  </p>
                  <span className="rounded-full border border-white/10 bg-black/45 px-3 py-2 text-xs font-semibold text-amberGlow backdrop-blur-md sm:text-sm">
                    {item.price[locale]}
                  </span>
                </div>
              </div>

              <div className="p-5 sm:p-6">
                <div className="flex items-start justify-between gap-4">
                  <div>
                    <h3 className={`font-display leading-none text-ivory ${index === 0 ? 'text-[2.15rem] sm:text-[2.4rem] xl:text-[2.8rem]' : 'text-[2rem] sm:text-3xl'}`}>
                      {item.name}
                    </h3>
                  </div>
                </div>
                <p className={`mt-4 text-sm leading-7 text-mist ${index === 0 ? 'xl:max-w-[42ch] xl:text-[1.02rem] xl:leading-8' : ''}`}>
                  {item.description[locale]}
                </p>
                {item.variants ? (
                  <div className="interactive-card mt-5 rounded-2xl border border-white/10 bg-white/[0.04] px-4 py-3 text-sm leading-7 text-mist">
                    <p className="text-[0.68rem] font-semibold uppercase tracking-[0.24em] text-amberGlow">
                      {locale === 'es' ? 'Variantes' : 'Variants'}
                    </p>
                    <p className="mt-2">{item.variants[locale]}</p>
                  </div>
                ) : null}
              </div>
            </div>
          </motion.article>
        ))}
      </div>
      <div className="mt-6 flex items-center justify-between gap-4 border-t border-white/10 pt-5 xl:mt-8">
        <p className="max-w-2xl text-sm leading-7 text-mist">{dictionary.menu.note}</p>
        <div className="hidden rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-[0.68rem] uppercase tracking-[0.26em] text-cyanGlow/80 lg:block">
          {items.length} {locale === 'es' ? 'selecciones destacadas' : 'featured selections'}
        </div>
      </div>
    </section>
  );
}

function getMenuLayoutClasses(index: number) {
  switch (index) {
    case 0:
      return 'xl:col-span-5 xl:row-span-2';
    case 1:
      return 'xl:col-span-4';
    case 2:
      return 'xl:col-span-3';
    case 3:
      return 'xl:col-span-3';
    case 4:
      return 'xl:col-span-4';
    case 5:
      return 'xl:col-span-5';
    default:
      return 'xl:col-span-6';
  }
}

function getMenuImageAspectClasses(index: number) {
  return index === 0 ? 'aspect-[5/4] xl:aspect-[4/5]' : 'aspect-[4/3]';
}
