import type { LocalizedText, Locale } from '../models/business';

interface MediaSlot {
  src?: string;
  alt: LocalizedText;
  eyebrow: LocalizedText;
  title: LocalizedText;
  description: LocalizedText;
}

interface MediaFrameProps {
  media: MediaSlot;
  locale: Locale;
  className?: string;
  aspectClassName?: string;
  imageClassName?: string;
  contentPosition?: 'bottom' | 'center';
  showOverlayContent?: boolean;
  overlayClassName?: string;
  frameClassName?: string;
}

export function MediaFrame({
  media,
  locale,
  className = '',
  aspectClassName = 'aspect-[4/5]',
  imageClassName = '',
  contentPosition = 'bottom',
  showOverlayContent = true,
  overlayClassName = 'bg-[linear-gradient(180deg,rgba(8,9,14,0.06),rgba(8,9,14,0.78)_70%,rgba(8,9,14,0.94))]',
  frameClassName = 'border-white/10',
}: MediaFrameProps) {
  const contentAlignment =
    contentPosition === 'center' ? 'justify-center text-center items-center' : 'justify-end';

  return (
    <div className={`interactive-image-shell group relative overflow-hidden rounded-[1.9rem] border ${frameClassName} ${className}`}>
      <div className={`relative ${aspectClassName} bg-[linear-gradient(180deg,rgba(255,255,255,0.06),rgba(255,255,255,0.02))]`}>
        {media.src ? (
          <img
            src={media.src}
            alt={media.alt[locale]}
            className={`absolute inset-0 h-full w-full object-cover transition duration-700 group-hover:scale-[1.045] ${imageClassName}`}
          />
        ) : (
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_left,_rgba(36,107,255,0.24),_transparent_26%),radial-gradient(circle_at_bottom_right,_rgba(214,165,93,0.18),_transparent_24%),linear-gradient(180deg,rgba(18,20,29,0.95),rgba(9,9,11,0.98))]">
            <div className="absolute inset-5 rounded-[1.45rem] border border-dashed border-white/10" />
            <div className="absolute left-6 top-6 h-24 w-24 rounded-full bg-cyanGlow/10 blur-2xl" />
            <div className="absolute bottom-10 right-8 h-28 w-28 rounded-full bg-amberGlow/10 blur-2xl" />
            <div className="absolute inset-x-8 bottom-8 h-24 rounded-[1.5rem] border border-white/10 bg-white/[0.03]" />
          </div>
        )}

        <div className={`absolute inset-0 transition duration-500 group-hover:opacity-95 ${overlayClassName}`} />

        <div className={`relative z-10 flex h-full p-6 sm:p-7 ${contentAlignment}`}>
          <div className="max-w-md">
            {showOverlayContent ? (
              <>
                <p className="text-[0.68rem] font-semibold uppercase tracking-[0.3em] text-cyanGlow/80">
                  {media.eyebrow[locale]}
                </p>
                <h3 className="mt-3 font-display text-3xl leading-tight text-ivory sm:text-4xl">
                  {media.title[locale]}
                </h3>
                <p className="mt-3 text-sm leading-7 text-mist">{media.description[locale]}</p>
              </>
            ) : null}
          </div>
        </div>
      </div>
    </div>
  );
}
