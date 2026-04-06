import { motion } from 'framer-motion';
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
      <div className="absolute inset-x-0 top-14 h-px bg-gradient-to-r from-transparent via-cyanGlow/40 to-transparent" />
      <div className="mx-auto grid min-h-[92vh] max-w-7xl items-center gap-10 px-5 py-16 sm:px-6 lg:grid-cols-[1.1fr_0.9fr] lg:px-8">
        <motion.div
          initial={{ opacity: 0, y: 24 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: 'easeOut' }}
          className="relative z-10"
        >
          <p className="mb-4 text-xs font-semibold uppercase tracking-[0.38em] text-amberGlow/85">
            {business.heroOverline[locale]}
          </p>
          <span className="inline-flex rounded-full border border-white/10 bg-white/5 px-4 py-2 text-xs uppercase tracking-[0.3em] text-cyanGlow/80 shadow-glow">
            {business.badge[locale]}
          </span>
          <h1 className="mt-6 max-w-3xl font-display text-6xl leading-[0.92] text-ivory sm:text-7xl lg:text-8xl">
            {business.name}
          </h1>
          <p className="mt-4 max-w-xl text-xs font-semibold uppercase tracking-[0.34em] text-cyanGlow/80 sm:text-sm">
            {business.tagline[locale]}
          </p>
          <p className="mt-6 max-w-xl text-base leading-8 text-mist sm:text-lg">{business.headline[locale]}</p>
          <p className="mt-4 max-w-xl text-sm leading-7 text-mist/90 sm:text-base">{business.description[locale]}</p>

          <div className="mt-8 flex flex-col gap-4 sm:flex-row">
            <a
              href={business.primaryCta.href}
              target="_blank"
              rel="noreferrer"
              className="rounded-full bg-ivory px-6 py-3 text-center text-sm font-bold uppercase tracking-[0.22em] text-obsidian transition hover:bg-amberGlow"
            >
              {business.primaryCta.label[locale]}
            </a>
            <a
              href={business.secondaryCta.href}
              className="rounded-full border border-white/15 bg-white/5 px-6 py-3 text-center text-sm font-semibold uppercase tracking-[0.22em] text-ivory transition hover:border-cyanGlow/40 hover:bg-white/10"
            >
              {business.secondaryCta.label[locale]}
            </a>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, scale: 0.96 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.9, delay: 0.15, ease: 'easeOut' }}
          className="relative"
        >
          <div className="absolute inset-0 translate-x-6 translate-y-6 rounded-[2rem] bg-sapphire/10 blur-3xl" />
          <div className="relative rounded-[2rem] border border-white/10 bg-white/5 p-6 shadow-glow backdrop-blur-md">
            <div className="rounded-[1.5rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(113,216,255,0.18),_transparent_35%),linear-gradient(180deg,_rgba(255,255,255,0.08),_rgba(255,255,255,0.02))] p-6">
              <div className="flex items-center justify-between text-xs uppercase tracking-[0.3em] text-cyanGlow/80">
                <span>{dictionary.hero.tonightLabel}</span>
                <span>{dictionary.hero.cityLabel}</span>
              </div>
              <div className="mt-8 grid gap-4">
                {metrics.map((metric) => (
                  <div
                    key={metric.label}
                    className="rounded-2xl border border-white/10 bg-obsidian/55 px-5 py-4"
                  >
                    <div className="font-display text-4xl text-ivory">{metric.value}</div>
                    <div className="mt-2 text-sm text-mist">{metric.label}</div>
                  </div>
                ))}
              </div>
              <div className="mt-6 rounded-2xl border border-amberGlow/20 bg-amberGlow/10 p-5">
                <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">
                  {business.signatureMoodLabel[locale]}
                </p>
                <p className="mt-3 text-sm leading-7 text-ivory/90">{business.signatureMoodText[locale]}</p>
                <p className="mt-3 text-sm leading-7 text-mist">{business.identityLine[locale]}</p>
              </div>
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
