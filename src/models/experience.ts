import galleryBrandSignature from '../assets/images/gallery/gallery-brand-signature.jpg';
import gallerySocialAmbience from '../assets/images/gallery/gallery-social-ambience.jpg';
import galleryVenueMain from '../assets/images/gallery/gallery-venue-main.jpg';
import type { LocalizedText, MediaAsset } from './business';

export interface ExperienceHighlight {
  title: LocalizedText;
  description: LocalizedText;
}

export interface GalleryMoment {
  title: LocalizedText;
  tag: LocalizedText;
  description: LocalizedText;
  focus: LocalizedText;
  placeholderLabel: LocalizedText;
  accent: string;
  panelTone: string;
  layout: 'hero' | 'tall' | 'wide' | 'standard';
  media: MediaAsset;
}

export const experienceHighlights: ExperienceHighlight[] = [
  {
    title: { en: 'Music-led nights', es: 'Noches marcadas por la música' },
    description: {
      en: 'Curated music, measured energy, and a lounge rhythm that feels current without losing warmth.',
      es: 'Música cuidada, energía en su punto y un ritmo lounge actual sin perder calidez.',
    },
  },
  {
    title: { en: 'Match nights and shared tables', es: 'Noches de partido y mesas compartidas' },
    description: {
      en: 'A polished setting for sports, cocktails, and group plans with the right mix of comfort and excitement.',
      es: 'Un entorno bien puesto para deporte, cócteles y planes en grupo, con el balance justo entre comodidad y emoción.',
    },
  },
  {
    title: { en: 'Birthdays and celebrations', es: 'Cumpleaños y celebraciones' },
    description: {
      en: 'A setting built for toasts, memorable moments, and details that look good on camera.',
      es: 'Un ambiente pensado para brindis, momentos memorables y detalles que lucen bien en foto.',
    },
  },
];

export const galleryMoments: GalleryMoment[] = [
  {
    title: { en: 'Signature cocktails with ZAFIRO’s seal', es: 'Cócteles con el sello de ZAFIRO' },
    tag: { en: 'Cocktails', es: 'Cócteles' },
    description: {
      en: 'Close-up pours, polished glassware, and the house style that sets the tone from the first round.',
      es: 'Cócteles bien servidos, cristalería cuidada y la firma de la casa que marca el tono desde la primera ronda.',
    },
    focus: {
      en: 'Signature cocktails',
      es: 'Cócteles de autor',
    },
    placeholderLabel: {
      en: 'Signature cocktails',
      es: 'Cócteles de autor',
    },
    accent: 'from-sapphire/35 via-cyanGlow/10 to-transparent',
    panelTone: 'from-[#182747] via-[#10131c] to-[#09090b]',
    layout: 'hero',
    media: {
      src: galleryBrandSignature,
      alt: {
        en: 'Signature cocktail presentation at ZAFIRO Bar Lounge',
        es: 'Presentación de cóctel de autor en ZAFIRO Bar Lounge',
      },
      eyebrow: {
        en: 'Signature drinks',
        es: 'Cócteles de autor',
      },
      title: {
        en: 'Signature cocktails, close-up and polished',
        es: 'Cócteles de firma, en primer plano y con acabado cuidado',
      },
      description: {
        en: 'Cocktails that open the night with color, detail, and a clear point of view.',
        es: 'Cócteles que abren la noche con color, detalle y una identidad clara.',
      },
    },
  },
  {
    title: { en: 'Tables, textures, and rooftop mood', es: 'Mesas, texturas y mood rooftop' },
    tag: { en: 'Venue', es: 'Lugar' },
    description: {
      en: 'Lighting, seating, and interior details shape the kind of place that invites you to stay longer.',
      es: 'La iluminación, las mesas y los detalles del lugar construyen ese ambiente que invita a quedarse un rato más.',
    },
    focus: {
      en: 'Venue atmosphere',
      es: 'Ambiente del lugar',
    },
    placeholderLabel: {
      en: 'Venue atmosphere',
      es: 'Ambiente del lugar',
    },
    accent: 'from-amberGlow/25 via-white/5 to-transparent',
    panelTone: 'from-[#231910] via-[#14151d] to-[#09090b]',
    layout: 'tall',
    media: {
      src: galleryVenueMain,
      alt: {
        en: 'Main venue atmosphere at ZAFIRO Bar Lounge',
        es: 'Ambiente principal del lugar en ZAFIRO Bar Lounge',
      },
      eyebrow: {
        en: 'Venue atmosphere',
        es: 'Ambiente del lugar',
      },
      title: {
        en: 'Tables, lighting, and lounge texture',
        es: 'Mesas, iluminación y textura lounge',
      },
      description: {
        en: 'A room with character, soft light, and the kind of setting that elevates the plan.',
        es: 'Un lugar con carácter, luz cuidada y ese escenario que hace subir el nivel del plan.',
      },
    },
  },
  {
    title: { en: 'Celebrations, music, and shared nights', es: 'Celebraciones, música y noches compartidas' },
    tag: { en: 'Events', es: 'Eventos' },
    description: {
      en: 'Birthdays, toasts, and social energy come together in nights made to be shared around the table.',
      es: 'Cumpleaños, brindis y energía social se encuentran en noches hechas para reunirse alrededor de la mesa.',
    },
    focus: {
      en: 'Celebrations and social energy',
      es: 'Celebraciones y energía social',
    },
    placeholderLabel: {
      en: 'Celebrations and social energy',
      es: 'Celebraciones y energía social',
    },
    accent: 'from-rose-200/15 via-amberGlow/10 to-transparent',
    panelTone: 'from-[#28151b] via-[#14131a] to-[#09090b]',
    layout: 'wide',
    media: {
      src: gallerySocialAmbience,
      alt: {
        en: 'Social atmosphere and celebration at ZAFIRO Bar Lounge',
        es: 'Ambiente social y celebración en ZAFIRO Bar Lounge',
      },
      eyebrow: {
        en: 'Social nights',
        es: 'Noches sociales',
      },
      title: {
        en: 'Bottle service, birthdays, and social celebration',
        es: 'Botellas, cumpleaños y celebración social',
      },
      description: {
        en: 'Music, service, and the kind of night that feels good from the first toast to the last round.',
        es: 'Música, servicio y ese tipo de noche que se disfruta desde el primer brindis hasta la última ronda.',
      },
    },
  },
  {
    title: { en: 'Night energy for couples and groups', es: 'Energía nocturna para parejas y grupos' },
    tag: { en: 'Ambiance', es: 'Ambiente' },
    description: {
      en: 'A social gallery card for guest moments, table energy, and the kind of crowd the brand wants to attract.',
      es: 'Una tarjeta visual para momentos reales, energía en mesa y el tipo de público que la marca quiere atraer.',
    },
    focus: {
      en: 'Real atmosphere, guest moments, and nightlife rhythm',
      es: 'Atmósfera real, momentos de clientes y ritmo nocturno',
    },
    placeholderLabel: {
      en: 'Real atmosphere',
      es: 'Atmósfera real',
    },
    accent: 'from-cyanGlow/20 via-sapphire/10 to-transparent',
    panelTone: 'from-[#10212b] via-[#11131b] to-[#09090b]',
    layout: 'standard',
    media: {
      alt: {
        en: 'Real guest atmosphere image placeholder',
        es: 'Espacio para imagen real de ambiente y clientes',
      },
      eyebrow: {
        en: 'Atmosphere slot',
        es: 'Espacio para atmósfera real',
      },
      title: {
        en: 'Guests, movement, and nightlife rhythm',
        es: 'Clientes, movimiento y ritmo nocturno',
      },
      description: {
        en: 'Recommended for authentic guest moments that show ZAFIRO with real energy and crowd appeal.',
        es: 'Recomendado para momentos reales de clientes que muestren a ZAFIRO con energía y atractivo de público.',
      },
    },
  },
];
