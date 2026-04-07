import heroRooftopNight from '../assets/images/hero/hero-rooftop-night.jpg';

export type Locale = 'en' | 'es';

export interface LocalizedText {
  en: string;
  es: string;
}

export interface ActionLink {
  label: LocalizedText;
  href: string;
  value?: LocalizedText;
  helper?: LocalizedText;
}

export interface ContactMethod {
  title: LocalizedText;
  detail: LocalizedText;
}

export interface SocialProfile {
  label: LocalizedText;
  href: string;
  value: LocalizedText;
  helper: LocalizedText;
}

export interface MediaAsset {
  src?: string;
  alt: LocalizedText;
  eyebrow: LocalizedText;
  title: LocalizedText;
  description: LocalizedText;
}

export interface BusinessInfo {
  name: string;
  shortName: string;
  city: string;
  region: string;
  heroOverline: LocalizedText;
  district: LocalizedText;
  address: LocalizedText;
  arrivalNote: LocalizedText;
  badge: LocalizedText;
  tagline: LocalizedText;
  identityLine: LocalizedText;
  headline: LocalizedText;
  description: LocalizedText;
  story: LocalizedText;
  ambiance: LocalizedText;
  signatureMoodLabel: LocalizedText;
  signatureMoodText: LocalizedText;
  reserveLabel: LocalizedText;
  reservationMessage: LocalizedText;
  primaryCta: ActionLink;
  secondaryCta: ActionLink;
  heroMedia: MediaAsset;
  hours: Array<{ day: LocalizedText; time: LocalizedText }>;
  contactMethods: ContactMethod[];
  socialProfiles: SocialProfile[];
  footerDescription: LocalizedText;
  closingPhrase: LocalizedText;
  footerNote: LocalizedText;
}

const whatsappNumber = '573212900379';
const whatsappDisplay = '+57 321 2900379';

const whatsappMessage: LocalizedText = {
  en: 'Hello, ZAFIRO Bar Lounge. I would like information about reservations and availability.',
  es: 'Hola, ZAFIRO Bar Lounge. Quiero información sobre reservas y disponibilidad.',
};

export const businessInfo: BusinessInfo = {
  name: 'ZAFIRO Bar Lounge',
  shortName: 'ZAFIRO',
  city: 'Florencia',
  region: 'Caquetá, Colombia',
  heroOverline: {
    en: 'Rooftop lounge concept in Florencia, Caquetá',
    es: 'Concepto rooftop lounge en Florencia, Caquetá',
  },
  district: {
    en: 'Barrio La Libertad',
    es: 'Barrio La Libertad',
  },
  address: {
    en: 'Calle 25 #21A - 07',
    es: 'Calle 25 #21A - 07',
  },
  arrivalNote: {
    en: 'Across from Gran Plaza, Florencia, Caquetá.',
    es: 'Frente al Gran Plaza, Florencia, Caquetá.',
  },
  badge: {
    en: 'Polished nights in Florencia',
    es: 'Noches con sello premium en Florencia',
  },
  tagline: {
    en: 'Rooftop Lounge Bar • Cocktails and light bites',
    es: 'Rooftop Lounge Bar • Cócteles y cocina ligera',
  },
  identityLine: {
    en: 'Rooftop Lounge Bar • Cocktails and light bites',
    es: 'Rooftop Lounge Bar • Cócteles y cocina ligera',
  },
  headline: {
    en: 'Signature cocktails, sapphire tones, and a rooftop atmosphere made for staying a little longer.',
    es: 'Cócteles de autor, tonos zafiro y una atmósfera rooftop hecha para quedarse un rato más.',
  },
  description: {
    en: 'ZAFIRO Bar Lounge brings together cocktails, light bites, music, and polished nightlife energy for couples, groups, and celebrations in Florencia.',
    es: 'ZAFIRO Bar Lounge reúne cócteles, cocina ligera, música y una energía nocturna bien cuidada para parejas, grupos y celebraciones en Florencia.',
  },
  story: {
    en: 'Designed for nights that feel elevated yet warm, with signature cocktails, subtle lighting, and an easy social rhythm.',
    es: 'Pensado para noches que se sienten elevadas y cercanas, con cócteles de autor, iluminación sutil y un ritmo social fácil de disfrutar.',
  },
  ambiance: {
    en: 'Intimate lighting, refined textures, and standout cocktails turn a casual plan into a better night.',
    es: 'Iluminación íntima, texturas refinadas y cócteles bien servidos convierten un plan casual en una mejor noche.',
  },
  signatureMoodLabel: {
    en: 'Signature mood',
    es: 'Esencia ZAFIRO',
  },
  signatureMoodText: {
    en: 'Amber warmth, sapphire accents, and an atmosphere made to linger.',
    es: 'Calidez ámbar, acentos zafiro y un ambiente hecho para quedarse.',
  },
  reserveLabel: {
    en: 'Reserve',
    es: 'Reservar',
  },
  reservationMessage: whatsappMessage,
  primaryCta: {
    label: {
      en: 'Reserve on WhatsApp',
      es: 'Reserva por WhatsApp',
    },
    href: `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(whatsappMessage.es)}`,
    value: {
      en: whatsappDisplay,
      es: whatsappDisplay,
    },
    helper: {
      en: 'Reservations, availability, and table plans in one message.',
      es: 'Reservas, disponibilidad y planes de mesa en un solo mensaje.',
    },
  },
  secondaryCta: {
    label: {
      en: 'View featured menu',
      es: 'Ver menú destacado',
    },
    href: '#menu',
  },
  heroMedia: {
    src: heroRooftopNight,
    alt: {
      en: 'Night view of ZAFIRO Bar Lounge rooftop atmosphere',
      es: 'Vista nocturna de la atmósfera rooftop de ZAFIRO Bar Lounge',
    },
    eyebrow: {
      en: 'Rooftop nights',
      es: 'Noches rooftop',
    },
    title: {
      en: 'ZAFIRO after dark',
      es: 'ZAFIRO al caer la noche',
    },
    description: {
      en: 'A first look at the rooftop mood, polished lighting, and the atmosphere that defines the night.',
      es: 'Una primera mirada al mood del rooftop, la iluminación cuidada y la atmósfera que define la noche.',
    },
  },
  hours: [
    {
      day: {
        en: 'Thursday to Sunday',
        es: 'Jueves a domingo',
      },
      time: {
        en: 'From 6:00 PM until 1:00–2:00 AM',
        es: 'Desde las 6:00 PM hasta la 1:00–2:00 AM',
      },
    },
    {
      day: {
        en: 'Holidays',
        es: 'Festivos',
      },
      time: {
        en: 'From 6:00 PM with late closing',
        es: 'Desde las 6:00 PM con cierre en la madrugada',
      },
    },
  ],
  contactMethods: [
    {
      title: { en: 'Reservations by WhatsApp', es: 'Reservas por WhatsApp' },
      detail: {
        en: `${whatsappDisplay} for reservations, availability, and group plans.`,
        es: `${whatsappDisplay} para reservas, disponibilidad y planes en grupo.`,
      },
    },
    {
      title: { en: 'Instagram messages', es: 'Mensajes por Instagram' },
      detail: {
        en: '@zafirobarlounge for direct messages and updates.',
        es: '@zafirobarlounge para mensajes directos y novedades.',
      },
    },
    {
      title: { en: 'TikTok', es: 'TikTok' },
      detail: {
        en: '@zafiro.bar.lounge for short-form nightlife content.',
        es: '@zafiro.bar.lounge para contenido corto del ambiente y las noches.',
      },
    },
  ],
  socialProfiles: [
    {
      label: { en: 'Instagram', es: 'Instagram' },
      href: 'https://www.instagram.com/zafirobarlounge/',
      value: {
        en: '@zafirobarlounge',
        es: '@zafirobarlounge',
      },
      helper: {
        en: 'Atmosphere, cocktails, and nights at ZAFIRO.',
        es: 'Ambiente, cócteles y noches en ZAFIRO.',
      },
    },
    {
      label: { en: 'Facebook', es: 'Facebook' },
      href: 'https://www.facebook.com/profile.php?id=61587611992763',
      value: {
        en: 'ZAFIRO Bar Lounge',
        es: 'ZAFIRO Bar Lounge',
      },
      helper: {
        en: 'Official page with brand presence and updates.',
        es: 'Página oficial con presencia de marca y novedades.',
      },
    },
    {
      label: { en: 'WhatsApp', es: 'WhatsApp' },
      href: `https://wa.me/${whatsappNumber}?text=${encodeURIComponent(whatsappMessage.es)}`,
      value: {
        en: whatsappDisplay,
        es: whatsappDisplay,
      },
      helper: {
        en: 'Direct reservations and availability.',
        es: 'Reservas y disponibilidad directas.',
      },
    },
    {
      label: { en: 'TikTok', es: 'TikTok' },
      href: 'https://www.tiktok.com/@zafiro.bar.lounge',
      value: {
        en: '@zafiro.bar.lounge',
        es: '@zafiro.bar.lounge',
      },
      helper: {
        en: 'Moments, music, and nightlife in motion.',
        es: 'Momentos, música y vida nocturna en movimiento.',
      },
    },
  ],
  footerDescription: {
    en: 'A rooftop lounge bar for drinks, conversation, and nights that deserve a better setting.',
    es: 'Un rooftop lounge bar para brindar, conversar y alargar la noche.',
  },
  closingPhrase: {
    en: 'See you where Florencia slows down and the night starts well.',
    es: 'Nos vemos donde Florencia baja el ritmo y la noche empieza bien.',
  },
  footerNote: {
    en: 'Reservations, social updates, and the next good plan in Florencia.',
    es: 'Reservas, novedades en redes y el próximo buen plan en Florencia.',
  },
};
