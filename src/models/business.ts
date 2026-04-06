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
    en: 'Sapphire accents, amber warmth, and a mood built for cocktails, good photos, and plans worth repeating.',
    es: 'Acentos zafiro, calidez ámbar y un mood pensado para cócteles, buenas fotos y planes que se repiten.',
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
      en: 'Primary channel for reservations, availability, and celebrations.',
      es: 'Canal principal para reservas, disponibilidad y celebraciones.',
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
        en: '@zafirobarlounge for event questions, content discovery, and direct contact.',
        es: '@zafirobarlounge para consultas sobre eventos, contenido y contacto directo.',
      },
    },
    {
      title: { en: 'Facebook presence', es: 'Presencia en Facebook' },
      detail: {
        en: 'Official page available for brand presence and future updates.',
        es: 'Página oficial disponible para presencia de marca y futuras novedades.',
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
        en: 'Official Instagram profile for venue atmosphere, cocktails, and event content.',
        es: 'Perfil oficial para mostrar el ambiente del lugar, cócteles y contenido de eventos.',
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
        en: 'Official Facebook profile for brand presence and future updates.',
        es: 'Perfil oficial de Facebook para presencia de marca y futuras novedades.',
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
        en: 'Direct reservations and availability by click-to-chat.',
        es: 'Reservas y disponibilidad por acceso directo al chat.',
      },
    },
    {
      label: { en: 'TikTok', es: 'TikTok' },
      href: '#contact',
      value: {
        en: '[Pending official TikTok handle]',
        es: '[Pendiente usuario oficial de TikTok]',
      },
      helper: {
        en: 'Add only if the brand will actively publish short-form nightlife content here.',
        es: 'Agregar solo si la marca va a publicar contenido corto de vida nocturna aquí.',
      },
    },
  ],
  footerDescription: {
    en: 'A rooftop lounge bar built around signature cocktails, light bites, atmosphere, and nights that deserve a better setting.',
    es: 'Un rooftop lounge bar construido alrededor de cócteles de autor, cocina ligera, atmósfera y noches que merecen un mejor escenario.',
  },
  closingPhrase: {
    en: 'Cocktails, light bites, and rooftop atmosphere for nights worth staying out for.',
    es: 'Cócteles, cocina ligera y atmósfera rooftop para noches que sí valen la pena.',
  },
  footerNote: {
    en: 'A premium digital front door for reservations, social discovery, and the next stage of the brand in Florencia.',
    es: 'Una entrada digital premium para reservas, descubrimiento en redes y la siguiente etapa de la marca en Florencia.',
  },
};
