interface SectionHeadingProps {
  eyebrow: string;
  title: string;
  description: string;
  align?: 'left' | 'center';
}

export function SectionHeading({
  eyebrow,
  title,
  description,
  align = 'left',
}: SectionHeadingProps) {
  const alignment = align === 'center' ? 'mx-auto text-center' : 'text-left';
  const descriptionAlignment = align === 'center' ? 'mx-auto' : '';

  return (
    <div className={`max-w-2xl ${alignment} xl:max-w-[36rem]`}>
      <p className="mb-3 text-[0.68rem] font-semibold uppercase tracking-[0.3em] text-cyanGlow/80 sm:text-xs sm:tracking-[0.35em] xl:mb-4">
        {eyebrow}
      </p>
      <h2 className="font-display text-[2rem] leading-[0.98] text-ivory sm:text-5xl xl:text-[3.55rem] xl:leading-[0.94]">
        {title}
      </h2>
      <p className={`mt-4 max-w-xl text-sm leading-7 text-mist sm:text-base xl:mt-5 xl:max-w-[32rem] xl:text-[1.02rem] xl:leading-8 ${descriptionAlignment}`}>
        {description}
      </p>
    </div>
  );
}
