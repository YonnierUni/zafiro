import { businessInfo, type Locale } from '../models/business';
import { experienceHighlights, galleryMoments } from '../models/experience';

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
  fullMenu: {
    eyebrow: string;
    title: string;
    description: string;
    categoryEyebrow: string;
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
      note: 'Discover more house cocktails, classics, and non-alcoholic options in the full menu below.',
    },
    fullMenu: {
      eyebrow: 'Full Menu',
      title: 'The full menu, grouped for an easy read between cocktails, drinks, and light food.',
      description: 'Browse the full selection served at ZAFIRO.',
      categoryEyebrow: 'Category',
    },
    gallery: {
      eyebrow: 'Gallery',
      title: 'A room, a signature, and nights worth repeating.',
      description: 'ZAFIRO in its own light.',
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
      description: 'Reserve on WhatsApp and keep Instagram close for updates, atmosphere, and direct messages.',
      button: 'Reserve on WhatsApp',
    },
    location: {
      eyebrow: 'Location & Hours',
      title: 'Find ZAFIRO and arrive where the night begins well.',
      description: 'In Barrio La Libertad, across from Gran Plaza.',
      where: 'Location',
      cityLabel: 'City',
      districtLabel: 'Area',
      addressLabel: 'Address',
      arrivalLabel: 'Reference',
      whereDescription: 'An easy point to spot, meet up, and start the plan without detours.',
      hours: 'Hours',
      hoursNote: 'Open Thursday to Sunday and holidays from 6:00 PM.',
    },
    footer: {
      eyebrow: 'ZAFIRO Bar Lounge',
      contactLabel: 'Direct line',
      contactDescription: 'WhatsApp is the fastest way to reserve and confirm the plan.',
      socialLabel: 'Follow ZAFIRO',
      availabilityLabel: 'Florencia, Caquetá',
      availabilityDescription: 'A meeting point for good drinks and better plans in Florencia.',
      closingNote: 'A better place to meet, toast, and stay a little longer.',
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
      note: 'Descubre más opciones de la casa, clásicos y bebidas sin alcohol en la carta completa de abajo.',
    },
    fullMenu: {
      eyebrow: 'Carta completa',
      title: 'La carta completa, organizada para recorrer cócteles, bebidas y cocina ligera con facilidad.',
      description: 'Explora la selección completa que se sirve en ZAFIRO.',
      categoryEyebrow: 'Categoría',
    },
    gallery: {
      eyebrow: 'Galería',
      title: 'Un lugar, una firma y noches para repetir.',
      description: 'ZAFIRO en su propia luz.',
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
      description: 'Reserva por WhatsApp y mantén Instagram cerca para novedades, ambiente y mensajes directos.',
      button: 'Reserva por WhatsApp',
    },
    location: {
      eyebrow: 'Ubicación y horarios',
      title: 'Encuentra ZAFIRO y llega donde la noche empieza bien.',
      description: 'En Barrio La Libertad, frente al Gran Plaza.',
      where: 'Ubicación',
      cityLabel: 'Ciudad',
      districtLabel: 'Zona',
      addressLabel: 'Dirección',
      arrivalLabel: 'Referencia',
      whereDescription: 'Un punto fácil de ubicar para encontrarse, llegar sin vueltas y dejar que la noche arranque sola.',
      hours: 'Horarios',
      hoursNote: 'Abierto de jueves a domingo y festivos desde las 6:00 PM.',
    },
    footer: {
      eyebrow: 'ZAFIRO Bar Lounge',
      contactLabel: 'Contacto directo',
      contactDescription: 'WhatsApp es la vía más rápida para reservar y dejar el plan confirmado.',
      socialLabel: 'Sigue a ZAFIRO',
      availabilityLabel: 'Florencia, Caquetá',
      availabilityDescription: 'Un punto de encuentro para buenos tragos y mejores planes en Florencia.',
      closingNote: 'Un mejor lugar para verse, brindar y quedarse un rato más.',
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

export function getHomePageData(locale: Locale) {
  return {
    locale,
    dictionary: dictionaries[locale],
    business: businessInfo,
    gallery: galleryMoments,
    highlights: experienceHighlights,
  };
}
