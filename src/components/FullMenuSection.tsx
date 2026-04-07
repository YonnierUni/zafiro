import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { Locale } from '../models/business';
import {
  formatMenuPrice,
  getLocalizedCategoryLabel,
  getMenuItemDisplayDescription,
  groupMenuItemsByTypeAndSubgroup,
  resolveMenuImageSrc,
  sanitizeMenuText,
  type MenuCategory,
  type MenuDataItem,
} from '../models/menuData';
import { SectionHeading } from './SectionHeading';

interface FullMenuSectionProps {
  items: MenuDataItem[];
  dictionary: HomeDictionary;
  locale: Locale;
}

const categoryOrder: MenuCategory[] = ['cocteles', 'bebidas', 'comida'];

export function FullMenuSection({ items, dictionary, locale }: FullMenuSectionProps) {
  const groupedItems = groupMenuItemsByTypeAndSubgroup(items);

  return (
    <section id="full-menu" className="mx-auto max-w-7xl px-5 py-12 sm:px-6 sm:py-24 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <SectionHeading
        eyebrow={dictionary.fullMenu.eyebrow}
        title={dictionary.fullMenu.title}
        description={dictionary.fullMenu.description}
      />

      <div className="mt-8 space-y-8 sm:mt-12 sm:space-y-10">
        {categoryOrder.map((category) => {
          const categoryGroups = groupedItems[category];

          if (!categoryGroups.length) {
            return null;
          }

          return (
            <section
              key={category}
              className="rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-4 sm:p-6 xl:p-7"
            >
              <div className="flex flex-col gap-3 border-b border-white/10 pb-4 sm:flex-row sm:items-end sm:justify-between sm:pb-5">
                <div>
                  <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                    {dictionary.fullMenu.categoryEyebrow}
                  </p>
                  <h3 className="mt-2 font-display text-[2rem] text-ivory sm:text-[2.4rem]">
                    {getLocalizedCategoryLabel(category, locale)}
                  </h3>
                </div>
                <span className="w-fit rounded-full border border-white/10 bg-obsidian/45 px-3 py-1.5 text-[0.68rem] uppercase tracking-[0.24em] text-amberGlow">
                  {categoryGroups.reduce((total, group) => total + group.items.length, 0)}{' '}
                  {locale === 'es' ? 'opciones' : 'items'}
                </span>
              </div>

              <div className="mt-5 space-y-5">
                {categoryGroups.map((group) => (
                  <div key={`${category}-${group.subgroup}`} className="space-y-4">
                    <div className="flex items-center gap-3">
                      <span className="h-px flex-1 bg-gradient-to-r from-white/10 to-transparent" />
                      <p className="text-[0.68rem] uppercase tracking-[0.24em] text-mist">
                        {group.subgroup}
                      </p>
                    </div>

                    <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                      {group.items.map((item, index) => (
                        <motion.article
                          key={`${category}-${group.subgroup}-${item.slug}`}
                          initial={{ opacity: 0, y: 18 }}
                          whileInView={{ opacity: 1, y: 0 }}
                          viewport={{ once: true, amount: 0.12 }}
                          transition={{ duration: 0.45, delay: index * 0.02 }}
                          className="interactive-card overflow-hidden rounded-[1.6rem] border border-white/10 bg-obsidian/55"
                        >
                          {item.imagen ? (
                            <div className="relative aspect-[4/3] overflow-hidden border-b border-white/10 bg-black/20">
                              <img
                                src={resolveMenuImageSrc(item.imagen)}
                                alt={`${sanitizeMenuText(item.name)} menu item`}
                                loading="lazy"
                                className="h-full w-full object-cover transition duration-700 hover:scale-[1.04]"
                              />
                              <div className="absolute inset-0 bg-gradient-to-t from-midnight via-midnight/15 to-transparent" />
                            </div>
                          ) : (
                            <div className="border-b border-white/10 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.16),_transparent_40%),rgba(255,255,255,0.03)] px-4 py-4">
                              <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">
                                {getLocalizedCategoryLabel(category, locale)}
                              </p>
                            </div>
                          )}

                          <div className="p-4 sm:p-5">
                            <div className="flex items-start justify-between gap-3">
                              <h4 className="font-display text-[1.7rem] leading-tight text-ivory sm:text-[1.9rem]">
                                {sanitizeMenuText(item.name)}
                              </h4>
                              <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-xs font-semibold text-amberGlow">
                                {formatMenuPrice(item.precioVenta)}
                              </span>
                            </div>

                            {getMenuItemDisplayDescription(item) ? (
                              <p className="mt-3 text-sm leading-6 text-mist">
                                {getMenuItemDisplayDescription(item)}
                              </p>
                            ) : null}
                          </div>
                        </motion.article>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </section>
          );
        })}
      </div>
    </section>
  );
}
