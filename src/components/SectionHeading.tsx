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

  return (
    <div className={`max-w-2xl ${alignment}`}>
      <p className="mb-3 text-xs font-semibold uppercase tracking-[0.35em] text-cyanGlow/80">
        {eyebrow}
      </p>
      <h2 className="font-display text-4xl leading-none text-ivory sm:text-5xl">{title}</h2>
      <p className="mt-4 text-sm leading-7 text-mist sm:text-base">{description}</p>
    </div>
  );
}
