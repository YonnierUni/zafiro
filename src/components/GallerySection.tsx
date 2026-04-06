import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { Locale } from '../models/business';
import type { GalleryMoment } from '../models/experience';
import { SectionHeading } from './SectionHeading';

interface GallerySectionProps {
  gallery: GalleryMoment[];
  dictionary: HomeDictionary;
  locale: Locale;
}

export function GallerySection({ gallery, dictionary, locale }: GallerySectionProps) {
  return (
    <section id="gallery" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <SectionHeading
        eyebrow={dictionary.gallery.eyebrow}
        title={dictionary.gallery.title}
        description={dictionary.gallery.description}
      />
      <div className="mt-12 grid gap-5 lg:grid-cols-12 lg:grid-rows-[minmax(19rem,1fr)_minmax(17rem,1fr)]">
        {gallery.map((item, index) => (
          <motion.div
            key={item.title.en}
            initial={{ opacity: 0, scale: 0.98 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true, amount: 0.25 }}
            transition={{ duration: 0.6, delay: index * 0.07 }}
            className={`group relative overflow-hidden rounded-[2rem] border border-white/10 bg-gradient-to-br ${item.accent} p-[1px] ${getGalleryLayoutClasses(
              item.layout,
            )}`}
          >
            <div className={`relative h-full min-h-[320px] overflow-hidden rounded-[1.95rem] bg-gradient-to-br ${item.panelTone} p-6 sm:p-8`}>
              <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.22),_transparent_26%),radial-gradient(circle_at_85%_20%,_rgba(214,165,93,0.18),_transparent_20%),linear-gradient(180deg,rgba(255,255,255,0.04),rgba(255,255,255,0))]" />
              <div className="absolute inset-5 rounded-[1.45rem] border border-white/10 opacity-90" />
              <div className="absolute -right-12 top-8 h-32 w-32 rounded-full border border-cyanGlow/15 bg-cyanGlow/10 blur-2xl transition duration-500 group-hover:scale-110" />
              <div className="absolute bottom-6 right-6 left-6 h-28 rounded-[1.4rem] border border-dashed border-white/10 bg-white/[0.02]" />

              <div className="relative flex h-full flex-col justify-between">
                <div className="flex flex-wrap items-center justify-between gap-3">
                  <span className="w-fit rounded-full border border-white/10 bg-obsidian/50 px-3 py-1 text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                    {item.tag[locale]}
                  </span>
                  <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1 text-[0.65rem] uppercase tracking-[0.24em] text-mist">
                    {item.placeholderLabel[locale]}
                  </span>
                </div>

                <div className="mt-10 max-w-[34rem]">
                  <p className="text-xs font-semibold uppercase tracking-[0.3em] text-amberGlow/85">
                    {item.focus[locale]}
                  </p>
                  <h3 className="mt-4 font-display text-4xl leading-tight text-ivory sm:text-[2.7rem]">
                    {item.title[locale]}
                  </h3>
                  <p className="mt-4 max-w-2xl text-sm leading-7 text-mist sm:text-base">
                    {item.description[locale]}
                  </p>
                </div>

                <div className="mt-10 flex items-end justify-between gap-4">
                  <div className="grid w-full max-w-xs grid-cols-3 gap-3">
                    <div className="h-20 rounded-2xl border border-white/10 bg-white/[0.03]" />
                    <div className="h-20 rounded-2xl border border-white/10 bg-white/[0.05]" />
                    <div className="h-20 rounded-2xl border border-white/10 bg-white/[0.03]" />
                  </div>
                  <div className="hidden rounded-full border border-white/10 bg-obsidian/45 px-4 py-2 text-xs uppercase tracking-[0.3em] text-ivory/80 sm:block">
                    {locale === 'es' ? 'Espacio para imagen real' : 'Future image slot'}
                  </div>
                </div>
              </div>
            </div>
          </motion.div>
        ))}
      </div>
    </section>
  );
}

function getGalleryLayoutClasses(layout: GalleryMoment['layout']) {
  switch (layout) {
    case 'hero':
      return 'lg:col-span-7 lg:row-span-2';
    case 'tall':
      return 'lg:col-span-5 lg:row-span-1';
    case 'wide':
      return 'lg:col-span-5 lg:row-span-1';
    case 'standard':
      return 'lg:col-span-5 lg:row-span-1';
    default:
      return '';
  }
}
