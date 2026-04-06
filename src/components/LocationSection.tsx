import type { HomeDictionary } from '../controllers/homeController';
import type { BusinessInfo, Locale } from '../models/business';
import { SectionHeading } from './SectionHeading';

interface LocationSectionProps {
  business: BusinessInfo;
  dictionary: HomeDictionary;
  locale: Locale;
}

export function LocationSection({ business, dictionary, locale }: LocationSectionProps) {
  return (
    <section className="mx-auto max-w-7xl px-5 py-24 sm:px-6 lg:px-8">
      <div className="grid gap-8 lg:grid-cols-[0.9fr_1.1fr]">
        <SectionHeading
          eyebrow={dictionary.location.eyebrow}
          title={dictionary.location.title}
          description={dictionary.location.description}
        />
        <div className="grid gap-5 sm:grid-cols-2">
          <div className="rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.16),_transparent_38%),rgba(255,255,255,0.04)] p-6 shadow-glow">
            <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/80">{dictionary.location.where}</p>
            <h3 className="mt-4 font-display text-3xl text-ivory">
              {business.city}, {business.region}
            </h3>
            <div className="mt-5 space-y-4 text-sm leading-7 text-mist">
              <div className="rounded-2xl border border-white/10 bg-obsidian/45 p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                  {dictionary.location.cityLabel}
                </p>
                <p className="mt-2 text-ivory">{business.city}, {business.region}</p>
              </div>
              <div className="rounded-2xl border border-white/10 bg-obsidian/45 p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
                  {dictionary.location.districtLabel}
                </p>
                <p className="mt-2 text-ivory">{business.district[locale]}</p>
              </div>
              <div className="rounded-2xl border border-dashed border-white/10 bg-white/[0.03] p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                  {dictionary.location.addressLabel}
                </p>
                <p className="mt-2">{business.address[locale]}</p>
              </div>
              <div className="rounded-2xl border border-dashed border-white/10 bg-white/[0.03] p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
                  {dictionary.location.arrivalLabel}
                </p>
                <p className="mt-2">{business.arrivalNote[locale]}</p>
              </div>
            </div>
            <p className="mt-5 text-sm leading-7 text-mist">{dictionary.location.whereDescription}</p>
          </div>
          <div className="rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top_right,_rgba(214,165,93,0.15),_transparent_32%),rgba(255,255,255,0.04)] p-6">
            <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">{dictionary.location.hours}</p>
            <div className="mt-4 space-y-3 text-sm text-mist">
              {business.hours.map((item) => (
                <div
                  key={item.day.en}
                  className="flex items-center justify-between gap-4 rounded-2xl border border-white/10 bg-obsidian/45 px-4 py-3"
                >
                  <span>{item.day[locale]}</span>
                  <span className="text-right text-ivory">{item.time[locale]}</span>
                </div>
              ))}
            </div>
            <p className="mt-5 text-sm leading-7 text-mist">{dictionary.location.hoursNote}</p>
          </div>
          <div className="rounded-[1.75rem] border border-white/10 bg-white/5 p-6 sm:col-span-2">
            <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/80">{dictionary.location.contactMethods}</p>
            <div className="mt-5 grid gap-3 md:grid-cols-3">
              {business.contactMethods.map((method) => (
                <div
                  key={method.title.en}
                  className="rounded-2xl border border-white/10 bg-obsidian/70 px-4 py-4 text-sm leading-6 text-mist"
                >
                  <p className="text-xs font-semibold uppercase tracking-[0.26em] text-cyanGlow/80">
                    {method.title[locale]}
                  </p>
                  <p className="mt-3">{method.detail[locale]}</p>
                </div>
              ))}
            </div>
            <p className="mt-5 text-sm leading-7 text-mist">{dictionary.location.contactNote}</p>
          </div>
        </div>
      </div>
    </section>
  );
}
