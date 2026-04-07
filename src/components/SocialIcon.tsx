type SocialIconKind = 'instagram' | 'facebook' | 'tiktok' | 'whatsapp';

interface SocialIconProps {
  kind: SocialIconKind;
  className?: string;
}

export function SocialIcon({ kind, className = 'h-4 w-4' }: SocialIconProps) {
  switch (kind) {
    case 'instagram':
      return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.7" className={className} aria-hidden="true">
          <rect x="3.5" y="3.5" width="17" height="17" rx="5" />
          <circle cx="12" cy="12" r="4" />
          <circle cx="17.2" cy="6.8" r="1" fill="currentColor" stroke="none" />
        </svg>
      );
    case 'facebook':
      return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.7" className={className} aria-hidden="true">
          <path d="M13 20v-6.2h2.5l.4-2.8H13V9.2c0-.8.3-1.5 1.6-1.5H16V5.2c-.3 0-1.2-.2-2.4-.2-2.4 0-4.1 1.4-4.1 4.1V11H7v2.8h2.5V20" />
        </svg>
      );
    case 'tiktok':
      return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.7" className={className} aria-hidden="true">
          <path d="M14.5 4c.3 2 1.5 3.5 3.5 4v2.6c-1.4 0-2.7-.4-3.9-1.2v5.2a4.6 4.6 0 1 1-4.6-4.6c.4 0 .8.1 1.2.2v2.7a2.1 2.1 0 1 0 1.3 2V4h2.5Z" />
        </svg>
      );
    case 'whatsapp':
      return (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.7" className={className} aria-hidden="true">
          <path d="M20 11.7A8.3 8.3 0 0 1 7.7 19l-3.7 1 1.1-3.5A8.3 8.3 0 1 1 20 11.7Z" />
          <path d="M9.2 8.8c.2-.4.4-.4.7-.4h.6c.2 0 .4 0 .5.4l.6 1.5c.1.3 0 .5-.1.7l-.5.6c-.1.1-.2.3 0 .5.3.6 1.1 1.7 2.3 2.3.2.1.4.1.5 0l.6-.5c.2-.2.5-.2.7-.1l1.5.6c.3.1.4.3.4.5v.6c0 .3 0 .5-.4.7-.4.2-1.2.4-2 .2a7.7 7.7 0 0 1-4.7-4.7c-.2-.8 0-1.6.2-2Z" />
        </svg>
      );
  }
}
