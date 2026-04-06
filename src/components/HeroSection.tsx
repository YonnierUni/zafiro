import { motion } from 'framer-motion';
import { MediaFrame } from './MediaFrame';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';

interface HeroSectionProps {
  business: BusinessInfo;
  metrics: Array<{ label: string; value: string }>;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function HeroSection({ business, metrics, dictionary, locale }: HeroSectionProps) {
  return (
    <section id="home" className="relative overflow-hidden bg-hero-radial">
      <div className="pointer-events-none absolute inset-x-0 top-0 h-[32rem] bg-[radial-gradient(circle_at_12%_18%,rgba(36,107,255,0.2),transparent_24%),radial-gradient(circle_at_82%_14%,rgba(214,165,93,0.14),transparent_20%)] lg:h-[42rem]" />
      <div className="pointer-events-none absolute right-[8%] top-28 hidden h-72 w-72 rounded-full bg-sapphire/12 blur-3xl lg:block" />
      <div className="pointer-events-none absolute left-[6%] top-44 hidden h-52 w-52 rounded-full bg-amberGlow/8 blur-3xl xl:block" />
      <div className="absolute inset-x-0 top-14 h-px bg-gradient-to-r from-transparent via-cyanGlow/40 to-transparent" />

      <div className="mx-auto grid min-h-[84vh] max-w-7xl items-center gap-8 px-5 py-12 sm:px-6 sm:py-16 lg:min-h-[92vh] lg:grid-cols-[minmax(0,1.02fr)_minmax(32rem,0.98fr)] lg:gap-12 lg:px-8 xl:min-h-[96vh] xl:max-w-[90rem] xl:gap-16 2xl:px-10">
        <motion.div
          initial={{ opacity: 0, y: 24 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: 'easeOut' }}
          className="relative z-10 lg:pr-4 xl:pr-8"
        >
          <p className="mb-3 text-[0.68rem] font-semibold uppercase tracking-[0.32em] text-amberGlow/85 sm:mb-4 sm:text-xs sm:tracking-[0.38em]">
            {business.heroOverline[locale]}
          </p>
          <span className="inline-flex rounded-full border border-white/10 bg-white/5 px-4 py-2 text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80 shadow-glow sm:text-xs sm:tracking-[0.3em]">
            {business.badge[locale]}
          </span>

          <h1 className="mt-5 max-w-3xl font-display text-[3.3rem] leading-[0.9] text-ivory sm:mt-6 sm:text-7xl lg:max-w-[14ch] lg:text-[5.4rem] xl:max-w-[13ch] xl:text-[6.4rem]">
            {business.name}
          </h1>

          <p className="mt-3 max-w-xl text-[0.68rem] font-semibold uppercase tracking-[0.28em] text-cyanGlow/80 sm:mt-4 sm:text-sm sm:tracking-[0.34em] xl:max-w-2xl">
            {business.tagline[locale]}
          </p>

          <p className="mt-5 max-w-xl text-[1rem] leading-7 text-mist sm:mt-6 sm:text-lg sm:leading-8 lg:max-w-2xl xl:text-[1.2rem] xl:leading-9">
            {business.headline[locale]}
          </p>

          <p className="mt-3 max-w-xl text-sm leading-7 text-mist/90 sm:mt-4 sm:text-base lg:max-w-[42rem] xl:text-[1.02rem] xl:leading-8">
            {business.description[locale]}
          </p>

          <div className="mt-7 flex flex-col gap-3 sm:mt-8 sm:flex-row sm:gap-4 xl:mt-9">
            <a
              href={business.primaryCta.href}
              target="_blank"
              rel="noreferrer"
              className="rounded-full bg-ivory px-6 py-3.5 text-center text-sm font-bold uppercase tracking-[0.18em] text-obsidian transition hover:bg-amberGlow sm:px-6 sm:py-3 xl:min-w-[15rem]"
            >
              {business.primaryCta.label[locale]}
            </a>
            <a
              href={business.secondaryCta.href}
              className="rounded-full border border-white/15 bg-white/5 px-6 py-3.5 text-center text-sm font-semibold uppercase tracking-[0.18em] text-ivory transition hover:border-cyanGlow/40 hover:bg-white/10 sm:px-6 sm:py-3 xl:min-w-[15rem]"
            >
              {business.secondaryCta.label[locale]}
            </a>
          </div>

          <div className="mt-5 grid gap-3 sm:mt-6 sm:max-w-xl sm:grid-cols-2 lg:max-w-2xl xl:mt-8">
            <div className="rounded-2xl border border-white/10 bg-white/[0.04] px-4 py-3 backdrop-blur-sm xl:px-5 xl:py-4">
              <p className="text-[0.68rem] font-semibold uppercase tracking-[0.24em] text-cyanGlow/80">
                {business.primaryCta.label[locale]}
              </p>
              <p className="mt-2 text-sm text-ivory">{business.primaryCta.value?.[locale]}</p>
            </div>
            <div className="rounded-2xl border border-white/10 bg-white/[0.04] px-4 py-3 backdrop-blur-sm xl:px-5 xl:py-4">
              <p className="text-[0.68rem] font-semibold uppercase tracking-[0.24em] text-amberGlow">
                {locale === 'es' ? 'Ubicaci\u00f3n' : 'Location'}
              </p>
              <p className="mt-2 text-sm text-ivory">{business.district[locale]}</p>
              <p className="text-sm text-mist">{business.address[locale]}</p>
            </div>
          </div>

          <div className="mt-4 grid gap-3 sm:grid-cols-3 lg:max-w-2xl xl:mt-6">
            {metrics.map((metric) => (
              <div
                key={metric.label}
                className="rounded-2xl border border-white/10 bg-obsidian/35 px-4 py-3 backdrop-blur-sm xl:px-5 xl:py-4"
              >
                <div className="font-display text-2xl text-ivory xl:text-[2.2rem]">{metric.value}</div>
                <div className="mt-1 text-xs leading-5 text-mist xl:text-sm">{metric.label}</div>
              </div>
            ))}
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, scale: 0.96 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.9, delay: 0.15, ease: 'easeOut' }}
          className="relative lg:pl-6 xl:pl-8"
        >
          <div className="absolute inset-x-[4%] top-[10%] h-[78%] rounded-[2.6rem] bg-[radial-gradient(circle_at_center,rgba(36,107,255,0.14),transparent_58%)] blur-3xl" />
          <div className="absolute right-[8%] top-[10%] hidden h-36 w-36 rounded-full bg-amberGlow/10 blur-3xl lg:block" />

          <div className="relative">
            <MediaFrame
              media={business.heroMedia}
              locale={locale}
              className="overflow-hidden bg-transparent shadow-[0_28px_90px_rgba(6,8,15,0.55)]"
              frameClassName="border-white/5"
              aspectClassName="aspect-[6/5] sm:aspect-[5/4] lg:aspect-[11/12] xl:aspect-[5/6]"
              imageClassName="object-[center_34%] scale-[1.03] lg:scale-[1.08]"
              overlayClassName="bg-[linear-gradient(180deg,rgba(6,8,15,0.06),rgba(6,8,15,0.18)_24%,rgba(6,8,15,0.38)_52%,rgba(6,8,15,0.78)_100%)]"
              showOverlayContent={false}
            />

            <div className="pointer-events-none absolute inset-x-0 bottom-0 h-36 bg-[linear-gradient(180deg,rgba(6,8,15,0)_0%,rgba(6,8,15,0.32)_42%,rgba(6,8,15,0.86)_100%)] lg:h-44" />

            <div className="relative mt-4 sm:mt-5 lg:absolute lg:bottom-6 lg:left-6 lg:right-6 lg:mt-0 xl:bottom-8 xl:left-8 xl:right-8">
              <div className="grid gap-3 lg:grid-cols-[minmax(0,1fr)_auto] lg:items-end">
                <div className="hidden rounded-[1.6rem] border border-white/10 bg-[linear-gradient(180deg,rgba(8,10,18,0.28),rgba(8,10,18,0.62))] px-5 py-4 backdrop-blur-xl lg:block xl:px-6">
                  <p className="text-[0.68rem] uppercase tracking-[0.24em] text-amberGlow sm:text-xs sm:tracking-[0.3em]">
                    {business.signatureMoodLabel[locale]}
                  </p>
                  <p className="mt-2 max-w-[30ch] text-sm leading-7 text-ivory/92 xl:text-[1rem] xl:leading-8">
                    {business.signatureMoodText[locale]}
                  </p>
                </div>

                <div className="rounded-[1.5rem] border border-white/10 bg-[linear-gradient(180deg,rgba(10,12,20,0.72),rgba(10,12,20,0.9))] px-4 py-3 shadow-[0_16px_40px_rgba(5,8,16,0.34)] backdrop-blur-xl sm:px-5 sm:py-4">
                  <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80 sm:text-xs sm:tracking-[0.3em]">
                    {dictionary.hero.cityLabel}
                  </p>
                  <p className="mt-2 text-sm text-ivory">{business.district[locale]}</p>
                  <p className="text-sm text-mist">{business.identityLine[locale]}</p>
                </div>
              </div>

              <div className="mt-4 rounded-2xl border border-amberGlow/20 bg-amberGlow/10 p-4 lg:hidden">
                <p className="text-[0.68rem] uppercase tracking-[0.24em] text-amberGlow sm:text-xs sm:tracking-[0.3em]">
                  {business.signatureMoodLabel[locale]}
                </p>
                <p className="mt-3 text-sm leading-7 text-ivory/90">{business.signatureMoodText[locale]}</p>
                <p className="mt-3 border-t border-white/10 pt-3 text-sm leading-7 text-mist">
                  {business.identityLine[locale]}
                </p>
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
