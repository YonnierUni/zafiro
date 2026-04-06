import { motion } from 'framer-motion';
import { MediaFrame } from './MediaFrame';
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
  const curatedGallery = gallery.slice(0, 3);

  return (
    <section id="gallery" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <SectionHeading
        eyebrow={dictionary.gallery.eyebrow}
        title={dictionary.gallery.title}
        description={dictionary.gallery.description}
      />

      <div className="mt-12 grid gap-5 lg:grid-cols-12 lg:grid-rows-[minmax(19rem,1fr)_minmax(17rem,1fr)] xl:mt-14 xl:gap-6 xl:grid-rows-[minmax(20rem,1fr)_minmax(18rem,1fr)]">
        {curatedGallery.map((item, index) => (
          <motion.div
            key={item.title.en}
            initial={{ opacity: 0, scale: 0.985 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true, amount: 0.25 }}
            transition={{ duration: 0.55, delay: index * 0.06 }}
            className={`interactive-card group relative overflow-hidden rounded-[2rem] border border-white/10 bg-gradient-to-br ${item.accent} p-[1px] ${getGalleryLayoutClasses(
              item.layout,
            )}`}
          >
            <div className={`relative h-full min-h-[320px] overflow-hidden rounded-[1.95rem] bg-gradient-to-br ${item.panelTone} p-6 sm:p-8 xl:p-9`}>
              <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.22),_transparent_26%),radial-gradient(circle_at_85%_20%,_rgba(214,165,93,0.18),_transparent_20%),linear-gradient(180deg,rgba(255,255,255,0.04),rgba(255,255,255,0))]" />
              <div className="absolute inset-5 rounded-[1.45rem] border border-white/10 opacity-70" />
              <div className="absolute -right-12 top-8 h-32 w-32 rounded-full border border-cyanGlow/15 bg-cyanGlow/10 blur-2xl transition duration-500 group-hover:scale-110" />

              <div className="relative flex h-full flex-col justify-between">
                <div className="flex flex-wrap items-center gap-3">
                  <span className="w-fit rounded-full border border-white/10 bg-obsidian/50 px-3 py-1 text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                    {item.tag[locale]}
                  </span>
                </div>

                <div className={`mt-8 grid gap-5 lg:items-end ${getGalleryInnerGridClasses(item.layout)}`}>
                  <div className={item.layout === 'hero' ? 'max-w-[36rem]' : 'max-w-[34rem]'}>
                    <p className="text-xs font-semibold uppercase tracking-[0.3em] text-amberGlow/85">
                      {item.focus[locale]}
                    </p>
                    <h3 className={`mt-4 font-display leading-tight text-ivory ${item.layout === 'hero' ? 'text-4xl sm:text-[2.9rem] xl:text-[3.4rem]' : 'text-4xl sm:text-[2.7rem]'}`}>
                      {item.title[locale]}
                    </h3>
                    <p className={`mt-4 max-w-2xl text-sm leading-7 text-mist sm:text-base ${item.layout === 'hero' ? 'xl:text-[1.02rem] xl:leading-8' : ''}`}>
                      {item.description[locale]}
                    </p>
                  </div>

                  <MediaFrame
                    media={item.media}
                    locale={locale}
                    className="overflow-hidden bg-black/10 shadow-[0_16px_44px_rgba(5,8,15,0.38)]"
                    frameClassName="border-white/6"
                    aspectClassName={getGalleryMediaAspectClasses(item.layout)}
                    contentPosition="center"
                    overlayClassName={getGalleryOverlayClasses(item.layout)}
                    imageClassName={getGalleryImageClasses(item.layout)}
                    showOverlayContent={false}
                  />
                </div>

                <div className="mt-8 border-t border-white/10 pt-4 xl:mt-10">
                  <p className="max-w-xl text-sm leading-7 text-mist/85">{item.media.description[locale]}</p>
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

function getGalleryInnerGridClasses(layout: GalleryMoment['layout']) {
  switch (layout) {
    case 'hero':
      return 'xl:grid-cols-[minmax(0,1.15fr)_minmax(20rem,0.85fr)]';
    case 'wide':
      return 'lg:grid-cols-[0.95fr_1.05fr]';
    default:
      return 'lg:grid-cols-[1.05fr_0.95fr]';
  }
}

function getGalleryMediaAspectClasses(layout: GalleryMoment['layout']) {
  switch (layout) {
    case 'hero':
      return 'aspect-[4/3] xl:aspect-[6/5]';
    case 'tall':
      return 'aspect-[4/3] xl:aspect-[4/4.8]';
    default:
      return 'aspect-[4/3] xl:aspect-[16/10]';
  }
}

function getGalleryImageClasses(layout: GalleryMoment['layout']) {
  switch (layout) {
    case 'hero':
      return 'object-[center_42%] scale-[1.02] xl:scale-[1.04]';
    case 'tall':
      return 'object-[center_35%] scale-[1.03]';
    case 'wide':
      return 'object-[center_40%] scale-[1.02]';
    default:
      return 'object-center';
  }
}

function getGalleryOverlayClasses(layout: GalleryMoment['layout']) {
  switch (layout) {
    case 'hero':
      return 'bg-[linear-gradient(180deg,rgba(7,9,16,0.12),rgba(7,9,16,0.34)_55%,rgba(7,9,16,0.68)_100%)]';
    case 'tall':
      return 'bg-[linear-gradient(180deg,rgba(7,9,16,0.08),rgba(7,9,16,0.26)_52%,rgba(7,9,16,0.62)_100%)]';
    default:
      return 'bg-[linear-gradient(180deg,rgba(7,9,16,0.08),rgba(7,9,16,0.22)_48%,rgba(7,9,16,0.58)_100%)]';
  }
}
