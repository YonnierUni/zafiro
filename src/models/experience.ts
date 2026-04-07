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
    title: { en: 'The signature in every glass', es: 'La firma en cada copa' },
    tag: { en: 'Cocktails', es: 'Cócteles' },
    description: {
      en: 'Color, detail, and pours made to set the tone from the first round.',
      es: 'Color, detalle y tragos que marcan el tono desde la primera ronda.',
    },
    focus: {
      en: 'Brand mood',
      es: 'Mood de marca',
    },
    placeholderLabel: {
      en: 'Brand mood',
      es: 'Mood de marca',
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
        en: 'A house style with polish, character, and a clear point of view.',
        es: 'Una casa con estilo, carácter y una identidad muy clara.',
      },
    },
  },
  {
    title: { en: 'Tables, light, and rooftop texture', es: 'Mesas, luz y textura rooftop' },
    tag: { en: 'Venue', es: 'Lugar' },
    description: {
      en: 'A room with character, soft light, and details that elevate the plan.',
      es: 'Un lugar con carácter, luz cuidada y detalles que elevan el plan.',
    },
    focus: {
      en: 'Venue interior',
      es: 'Interior del lugar',
    },
    placeholderLabel: {
      en: 'Venue interior',
      es: 'Interior del lugar',
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
        en: 'The kind of room that makes the night feel better from the moment you sit down.',
        es: 'Ese tipo de lugar que hace que la noche se sienta mejor desde que te sientas.',
      },
    },
  },
  {
    title: { en: 'Shared plans, music, and celebration', es: 'Planes compartidos, música y celebración' },
    tag: { en: 'Events', es: 'Eventos' },
    description: {
      en: 'Birthdays, service, and a social energy built for staying a little longer.',
      es: 'Cumpleaños, servicio y una energía social hecha para quedarse un rato más.',
    },
    focus: {
      en: 'Social energy',
      es: 'Energía social',
    },
    placeholderLabel: {
      en: 'Social energy',
      es: 'Energía social',
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
        en: 'Music, service, and nights that move easily from the first toast to the last round.',
        es: 'Música, servicio y noches que fluyen desde el primer brindis hasta la última ronda.',
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
