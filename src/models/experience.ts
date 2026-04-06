import type { LocalizedText } from './business';

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
}

export const experienceHighlights: ExperienceHighlight[] = [
  {
    title: { en: 'Music-led nights', es: 'Noches marcadas por la musica' },
    description: {
      en: 'A curated soundtrack, well-measured energy, and a lounge rhythm that feels modern without becoming cold.',
      es: 'Una seleccion musical cuidada, energia en su punto y un ritmo lounge moderno sin perder calidez.',
    },
  },
  {
    title: { en: 'Match nights and shared tables', es: 'Noches de partido y mesas compartidas' },
    description: {
      en: 'A polished setting for sports, cocktails, and group plans, balancing comfort, visibility, and excitement.',
      es: 'Un entorno cuidado para deporte, cocteles y planes en grupo, con el equilibrio justo entre comodidad, visibilidad y emocion.',
    },
  },
  {
    title: { en: 'Birthdays and celebrations', es: 'Cumpleanos y celebraciones' },
    description: {
      en: 'From the first toast to the last round, the setting is built for memorable moments and photo-ready details.',
      es: 'Desde el primer brindis hasta la ultima ronda, el ambiente esta hecho para momentos memorables y detalles dignos de foto.',
    },
  },
];

export const galleryMoments: GalleryMoment[] = [
  {
    title: { en: 'Signature cocktails under low light', es: 'Cocteles de autor bajo luz tenue' },
    tag: { en: 'Cocktails', es: 'Cocteles' },
    description: {
      en: 'Built for the future hero images of the house menu: close-up pours, polished glassware, and the sapphire tones that define the brand.',
      es: 'Pensado para las futuras imagenes protagonistas del menu: primeros planos, cristaleria cuidada y los tonos zafiro que definen la marca.',
    },
    focus: {
      en: 'Hero drink photography and premium menu presentation',
      es: 'Fotografia hero del menu y presentacion premium',
    },
    placeholderLabel: {
      en: 'Reserved for featured cocktail imagery',
      es: 'Reservado para imagenes destacadas de cocteles',
    },
    accent: 'from-sapphire/35 via-cyanGlow/10 to-transparent',
    panelTone: 'from-[#182747] via-[#10131c] to-[#09090b]',
    layout: 'hero',
  },
  {
    title: { en: 'Tables, textures, and the venue mood', es: 'Mesas, texturas y el mood del lugar' },
    tag: { en: 'Venue', es: 'Venue' },
    description: {
      en: 'A visual block for the interior identity of Zafiro: seating, material textures, table lighting, and the atmosphere guests feel the moment they arrive.',
      es: 'Un bloque visual para la identidad interior de Zafiro: mobiliario, texturas, iluminacion de mesas y la atmosfera que se siente apenas se llega.',
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
  },
  {
    title: { en: 'Service moments made for celebrations', es: 'Momentos de servicio hechos para celebrar' },
    tag: { en: 'Events', es: 'Eventos' },
    description: {
      en: 'Ready for birthdays, bottle service, shared toasts, and the type of group-night content that signals celebration without losing elegance.',
      es: 'Listo para mostrar cumpleanos, servicio de botellas, brindis y ese tipo de contenido grupal que comunica celebracion sin perder elegancia.',
    },
    focus: {
      en: 'Birthdays, bottle service, and social celebration scenes',
      es: 'Cumpleanos, botellas y escenas de celebracion',
    },
    placeholderLabel: {
      en: 'Reserved for event and celebration coverage',
      es: 'Reservado para fotos de eventos y celebraciones',
    },
    accent: 'from-rose-200/15 via-amberGlow/10 to-transparent',
    panelTone: 'from-[#28151b] via-[#14131a] to-[#09090b]',
    layout: 'wide',
  },
  {
    title: { en: 'Night energy for couples and groups', es: 'Energia nocturna para parejas y grupos' },
    tag: { en: 'Ambiance', es: 'Ambiente' },
    description: {
      en: 'A social gallery card for real guest moments, table energy, and the kind of crowd the brand wants to attract night after night.',
      es: 'Una tarjeta visual para momentos reales, energia en mesa y el tipo de publico que la marca quiere atraer noche tras noche.',
    },
    focus: {
      en: 'Real atmosphere, guest moments, and nightlife rhythm',
      es: 'Atmosfera real, momentos de clientes y ritmo nocturno',
    },
    placeholderLabel: {
      en: 'Reserved for real ambiance and guest photography',
      es: 'Reservado para fotos reales de ambiente y clientes',
    },
    accent: 'from-cyanGlow/20 via-sapphire/10 to-transparent',
    panelTone: 'from-[#10212b] via-[#11131b] to-[#09090b]',
    layout: 'standard',
  },
];
