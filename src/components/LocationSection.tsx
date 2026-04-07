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
    <section className="mx-auto max-w-7xl px-5 py-12 sm:px-6 sm:py-24 lg:px-8 xl:max-w-[90rem] 2xl:px-10">
      <div className="grid gap-5 lg:grid-cols-12 lg:gap-10 xl:gap-12">
        <div className="lg:col-span-4">
          <SectionHeading
            eyebrow={dictionary.location.eyebrow}
            title={dictionary.location.title}
            description={dictionary.location.description}
          />
        </div>

        <div className="grid gap-4 sm:gap-5 lg:col-span-8 lg:grid-cols-8 lg:grid-rows-[minmax(15rem,1fr)_minmax(13rem,1fr)] xl:gap-6">
          <div className="interactive-card rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.16),_transparent_38%),rgba(255,255,255,0.04)] p-4 shadow-glow sm:p-6 lg:col-span-5 lg:row-span-2 xl:p-7">
            <p className="text-xs uppercase tracking-[0.3em] text-cyanGlow/80">{dictionary.location.where}</p>
            <h3 className="mt-3 font-display text-[2rem] text-ivory sm:mt-4 sm:text-[2.35rem] xl:text-[2.9rem]">
              {business.city}, {business.region}
            </h3>

            <div className="mt-5 grid gap-3 text-sm leading-6 text-mist sm:mt-6 sm:gap-4 xl:grid-cols-2">
              <div className="interactive-card rounded-2xl border border-white/10 bg-obsidian/45 p-4 xl:col-span-2">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">
                  {dictionary.location.addressLabel}
                </p>
                <p className="mt-2 text-base text-ivory">{business.address[locale]}</p>
              </div>

              <div className="interactive-card rounded-2xl border border-white/10 bg-obsidian/45 p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
                  {dictionary.location.districtLabel}
                </p>
                <p className="mt-2 text-ivory">{business.district[locale]}</p>
              </div>

              <div className="interactive-card rounded-2xl border border-dashed border-white/10 bg-white/[0.03] p-4">
                <p className="text-[0.68rem] uppercase tracking-[0.28em] text-amberGlow">
                  {dictionary.location.arrivalLabel}
                </p>
                <p className="mt-2">{business.arrivalNote[locale]}</p>
              </div>
            </div>

            <p className="mt-5 hidden border-t border-white/10 pt-5 text-sm leading-6 text-mist sm:block xl:max-w-[38ch] xl:text-[1rem] xl:leading-7">
              {dictionary.location.whereDescription}
            </p>
          </div>

          <div className="interactive-card rounded-[1.75rem] border border-white/10 bg-[radial-gradient(circle_at_top_right,_rgba(214,165,93,0.15),_transparent_32%),rgba(255,255,255,0.04)] p-4 sm:p-6 lg:col-span-3 xl:p-7">
            <p className="text-xs uppercase tracking-[0.3em] text-amberGlow">{dictionary.location.hours}</p>
            <div className="mt-4 space-y-3 text-sm text-mist sm:mt-5">
              {business.hours.map((item) => (
                <div
                  key={item.day.en}
                  className="interactive-card rounded-2xl border border-white/10 bg-obsidian/45 px-4 py-4"
                >
                  <span className="block text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">
                    {item.day[locale]}
                  </span>
                  <span className="mt-2 block text-base text-ivory">{item.time[locale]}</span>
                </div>
              ))}
            </div>
            <p className="mt-5 hidden text-sm leading-6 text-mist sm:block">{dictionary.location.hoursNote}</p>
          </div>
        </div>
      </div>
    </section>
  );
}
