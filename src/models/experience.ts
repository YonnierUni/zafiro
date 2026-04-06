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
    title: { en: 'Signature cocktails under low light', es: 'Cócteles de autor bajo luz tenue' },
    tag: { en: 'Cocktails', es: 'Cócteles' },
    description: {
      en: 'A close-up look at ZAFIRO’s visual signature: polished pours, glassware, and the color of the bar after dark.',
      es: 'Una mirada cercana a la firma visual de ZAFIRO: cócteles bien servidos, cristalería cuidada y color al caer la noche.',
    },
    focus: {
      en: 'Cocktail craftsmanship and brand signature',
      es: 'Coctelería de autor y firma visual',
    },
    placeholderLabel: {
      en: 'Reserved for featured cocktail imagery',
      es: 'Reservado para imágenes destacadas de cócteles',
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
        en: 'A visual lead for the menu, glassware, garnish, and color of the house style.',
        es: 'Una imagen protagonista para el menú, la cristalería, los garnish y el color de la casa.',
      },
    },
  },
  {
    title: { en: 'Tables, textures, and the venue mood', es: 'Mesas, texturas y el mood del lugar' },
    tag: { en: 'Venue', es: 'Lugar' },
    description: {
      en: 'The venue atmosphere comes through in the details: seating, textures, lighting, and the first impression of the night.',
      es: 'La atmósfera del lugar se siente en los detalles: mobiliario, texturas, iluminación y la primera impresión de la noche.',
    },
    focus: {
      en: 'Interior identity, seating, and lounge details',
      es: 'Identidad interior, mobiliario y detalles lounge',
    },
    placeholderLabel: {
      en: 'Reserved for venue and interior photography',
      es: 'Reservado para fotos del interior y del espacio',
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
        en: 'A polished look at seating, lighting design, and the rooftop atmosphere before the room fills up.',
        es: 'Una mirada cuidada al mobiliario, la iluminación y la atmósfera rooftop antes de que se llene el lugar.',
      },
    },
  },
  {
    title: { en: 'Service moments made for celebrations', es: 'Momentos de servicio hechos para celebrar' },
    tag: { en: 'Events', es: 'Eventos' },
    description: {
      en: 'A social glimpse of birthdays, shared toasts, and the kind of nights that gather people around the table.',
      es: 'Una mirada social a cumpleaños, brindis y noches hechas para reunirse alrededor de la mesa.',
    },
    focus: {
      en: 'Celebrations, social energy, and shared nights',
      es: 'Celebraciones, energía social y noches compartidas',
    },
    placeholderLabel: {
      en: 'Reserved for event and celebration coverage',
      es: 'Reservado para fotos de eventos y celebraciones',
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
        en: 'A real glimpse of celebrations, shared energy, and the nightlife rhythm that makes the place memorable.',
        es: 'Una vista real de celebraciones, energía compartida y el ritmo nocturno que hace memorable el lugar.',
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
      en: 'Reserved for real ambiance and guest photography',
      es: 'Reservado para fotos reales de ambiente y clientes',
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
