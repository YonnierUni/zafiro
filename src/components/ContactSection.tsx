import { motion } from 'framer-motion';
import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';

interface ContactSectionProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function ContactSection({ business, dictionary, locale }: ContactSectionProps) {
  return (
    <section id="contact" className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <motion.div
        initial={{ opacity: 0, y: 24 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, amount: 0.3 }}
        transition={{ duration: 0.7 }}
        className="overflow-hidden rounded-[2rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.28),_transparent_35%),linear-gradient(135deg,_rgba(255,255,255,0.08),_rgba(255,255,255,0.03))] p-8 shadow-glow sm:p-10"
      >
        <p className="text-xs uppercase tracking-[0.35em] text-cyanGlow/80">{dictionary.contact.eyebrow}</p>
        <div className="mt-6 flex flex-col gap-8 lg:flex-row lg:items-end lg:justify-between">
          <div className="max-w-2xl">
            <h2 className="font-display text-5xl leading-none text-ivory sm:text-6xl">
              {dictionary.contact.title}
            </h2>
            <p className="mt-5 text-sm leading-7 text-mist sm:text-base">{dictionary.contact.description}</p>
          </div>
          <a
            href={business.primaryCta.href}
            target="_blank"
            rel="noreferrer"
            className="inline-flex rounded-full bg-ivory px-6 py-3 text-sm font-bold uppercase tracking-[0.22em] text-obsidian transition hover:bg-amberGlow"
          >
            {business.primaryCta.label[locale]}
          </a>
        </div>
      </motion.div>
    </section>
  );
}
