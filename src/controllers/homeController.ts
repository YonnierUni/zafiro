import { businessInfo, type Locale } from '../models/business';
import { experienceHighlights, galleryMoments } from '../models/experience';
import { featuredMenuItems } from '../models/menu';

export interface HomeDictionary {
  nav: {
    about: string;
    menu: string;
    gallery: string;
    experience: string;
    contact: string;
  };
  hero: {
    tonightLabel: string;
    cityLabel: string;
  };
  about: {
    eyebrow: string;
    title: string;
    whyPeopleCome: string;
    bullets: string[];
    atmosphereLabel: string;
  };
  menu: {
    eyebrow: string;
    title: string;
    description: string;
    note: string;
  };
  gallery: {
    eyebrow: string;
    title: string;
    description: string;
  };
  experience: {
    eyebrow: string;
    title: string;
    description: string;
  };
  contact: {
    eyebrow: string;
    title: string;
    description: string;
    button: string;
  };
  location: {
    eyebrow: string;
    title: string;
    description: string;
    where: string;
    cityLabel: string;
    districtLabel: string;
    addressLabel: string;
    arrivalLabel: string;
    whereDescription: string;
    hours: string;
    hoursNote: string;
  };
  footer: {
    eyebrow: string;
    contactLabel: string;
    contactDescription: string;
    socialLabel: string;
    availabilityLabel: string;
    availabilityDescription: string;
    closingNote: string;
    rights: string;
  };
  metrics: Array<{ label: string; value: string }>;
  languageToggle: {
    en: string;
    es: string;
  };
}

const dictionaries: Record<Locale, HomeDictionary> = {
  en: {
    nav: { about: 'About', menu: 'Menu', gallery: 'Gallery', experience: 'Experience', contact: 'Contact' },
    hero: { tonightLabel: 'Tonight at ZAFIRO', cityLabel: 'Florencia' },
    about: {
      eyebrow: 'About ZAFIRO',
      title: 'A polished address for cocktails, good music, and nights that move at the right pace.',
      whyPeopleCome: 'Why guests choose it',
      atmosphereLabel: 'Atmosphere',
      bullets: [
        'Signature cocktails with visual care and personality.',
        'Music, match nights, and celebrations in a more polished setting.',
        'A stylish space that still feels warm and easy to enjoy.',
      ],
    },
    menu: {
      eyebrow: 'Featured Menu',
      title: 'A focused menu preview with signature drinks, fresh mixes, and celebration-ready pours.',
      description:
        "A curated selection of house favorites, tropical freshness, and visual standouts that communicate the bar's premium identity at a glance.",
      note: 'Discover more house cocktails, classics, and non-alcoholic options in the full menu at the venue.',
    },
    gallery: {
      eyebrow: 'Gallery Preview',
      title: 'A first look at the cocktails, atmosphere, and nights that shape ZAFIRO.',
      description:
        'A reserved visual preview for the images that will soon bring the venue, the drinks, and the mood of the place to life.',
    },
    experience: {
      eyebrow: 'Experience',
      title: 'Music, celebration, and atmosphere in a social rhythm that makes the night feel easy.',
      description:
        'From match nights to birthdays and group plans, ZAFIRO is built for moments people actually want to repeat.',
    },
    contact: {
      eyebrow: 'Reservations',
      title: 'Set the plan early and arrive with the night already in motion.',
      description:
        'Reach out on WhatsApp for reservations, availability, birthdays, and table plans.',
      button: 'Reserve on WhatsApp',
    },
    location: {
      eyebrow: 'Location & Hours',
      title: 'Find ZAFIRO easily and arrive with the night already clear.',
      description:
        'Address, neighborhood, arrival reference, and hours in one clean place.',
      where: 'Location',
      cityLabel: 'City',
      districtLabel: 'Area',
      addressLabel: 'Address',
      arrivalLabel: 'Arrival notes',
      whereDescription: 'Just across from Gran Plaza, with a location that is easy to identify from the moment you arrive.',
      hours: 'Hours',
      hoursNote: 'Open Thursday through Sunday and on holidays from 6:00 PM, with late closing depending on the night.',
    },
    footer: {
      eyebrow: 'ZAFIRO Bar Lounge',
      contactLabel: 'Reservations',
      contactDescription: 'WhatsApp remains the fastest way to reserve, ask about availability, and plan a night out.',
      socialLabel: 'Follow ZAFIRO',
      availabilityLabel: 'Florencia, Caquetá',
      availabilityDescription: 'A rooftop lounge concept built around cocktails, light bites, and polished nightlife.',
      closingNote: 'Cocktails, music, and a better setting for nights that deserve more than the ordinary.',
      rights: 'All rights reserved.',
    },
    metrics: [
      { label: 'Signature and featured cocktails', value: '18+' },
      { label: 'Cocktails, light bites, and stylish nights', value: 'Rooftop' },
      { label: 'Best nights for reservations', value: 'Thu-Sun' },
    ],
    languageToggle: { en: 'EN', es: 'ES' },
  },
  es: {
    nav: { about: 'Nosotros', menu: 'Menú', gallery: 'Galería', experience: 'Experiencia', contact: 'Contacto' },
    hero: { tonightLabel: 'Esta noche en ZAFIRO', cityLabel: 'Florencia' },
    about: {
      eyebrow: 'Sobre ZAFIRO',
      title: 'Un lugar bien puesto para cócteles, buena música y noches con el ritmo correcto.',
      whyPeopleCome: 'Por qué lo eligen',
      atmosphereLabel: 'Ambiente',
      bullets: [
        'Cócteles de autor con presentación cuidada y personalidad.',
        'Música, noches de partido y celebraciones en un ambiente más pulido.',
        'Un espacio elegante que igual se siente cercano y fácil de disfrutar.',
      ],
    },
    menu: {
      eyebrow: 'Menú destacado',
      title: 'Una selección breve del menú, con tragos de firma, mezclas frescas y opciones para celebrar.',
      description:
        'Una curaduría de la casa con cócteles de autor, perfiles tropicales y presentaciones que dejan ver de inmediato la identidad premium del bar.',
      note: 'Descubre más opciones de la casa, clásicos y bebidas sin alcohol en el menú completo del lugar.',
    },
    gallery: {
      eyebrow: 'Galería',
      title: 'Una primera mirada a los cócteles, el ambiente y las noches que definen a ZAFIRO.',
      description:
        'Un preview visual reservado para las imágenes que pronto mostrarán el lugar, las bebidas y el mood real de la experiencia.',
    },
    experience: {
      eyebrow: 'Experiencia',
      title: 'Música, celebración y atmósfera en un ritmo social que hace fácil quedarse un rato más.',
      description:
        'Desde noches de partido hasta cumpleaños y planes en grupo, ZAFIRO está pensado para momentos que sí provocan volver.',
    },
    contact: {
      eyebrow: 'Reservas',
      title: 'Define el plan con tiempo y llega con la noche ya encaminada.',
      description:
        'Escríbenos por WhatsApp para reservas, disponibilidad, cumpleaños y planes de mesa.',
      button: 'Reserva por WhatsApp',
    },
    location: {
      eyebrow: 'Ubicación y horarios',
      title: 'Encuentra ZAFIRO fácil y llega con la noche ya clara.',
      description:
        'Dirección, barrio, referencia de llegada y horarios en un solo punto.',
      where: 'Ubicación',
      cityLabel: 'Ciudad',
      districtLabel: 'Zona',
      addressLabel: 'Dirección',
      arrivalLabel: 'Referencia de llegada',
      whereDescription: 'Frente al Gran Plaza, en un punto fácil de ubicar desde la llegada.',
      hours: 'Horarios',
      hoursNote: 'Abierto de jueves a domingo y festivos desde las 6:00 PM, con cierre en la madrugada según la noche.',
    },
    footer: {
      eyebrow: 'ZAFIRO Bar Lounge',
      contactLabel: 'Reservas',
      contactDescription: 'WhatsApp sigue siendo la vía más rápida para reservar, consultar disponibilidad y cuadrar la noche.',
      socialLabel: 'Sigue a ZAFIRO',
      availabilityLabel: 'Florencia, Caquetá',
      availabilityDescription: 'Un rooftop lounge pensado para cócteles, cocina ligera y noches mejor puestas.',
      closingNote: 'Cócteles, música y un mejor escenario para noches que merecen salir de lo común.',
      rights: 'Todos los derechos reservados.',
    },
    metrics: [
      { label: 'Cócteles de autor y destacados', value: '18+' },
      { label: 'Cócteles, cocina ligera y noches con estilo', value: 'Rooftop' },
      { label: 'Mejores noches para reservar', value: 'Jue-Dom' },
    ],
    languageToggle: { en: 'EN', es: 'ES' },
  },
};

const landingMenuOrder = [
  'Mains Zafiro',
  'Margaritas',
  'Passion Fresh',
  'Hawaiian Blue',
  'Cherry Champagne',
  'Mojito Fresh',
  'Blue Lagoon Drop',
] as const;

const landingFeaturedMenuItems = landingMenuOrder
  .map((name) => featuredMenuItems.find((item) => item.name === name))
  .filter((item): item is (typeof featuredMenuItems)[number] => Boolean(item));

export function getHomePageData(locale: Locale) {
  return {
    locale,
    dictionary: dictionaries[locale],
    business: businessInfo,
    featuredMenu: landingFeaturedMenuItems,
    gallery: galleryMoments,
    highlights: experienceHighlights,
  };
}
