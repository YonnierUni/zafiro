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
    contactMethods: string;
    contactNote: string;
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
    hero: { tonightLabel: 'Tonight at Zafiro', cityLabel: 'Florencia' },
    about: {
      eyebrow: 'About Zafiro',
      title: 'A polished address for cocktails, good music, and nights that unfold at the right pace.',
      whyPeopleCome: 'Why guests choose it',
      atmosphereLabel: 'Atmosphere',
      bullets: [
        'Signature cocktails served with visual care and balance.',
        'Music, match nights, and celebrations with a more polished atmosphere.',
        'A stylish setting that still feels warm, social, and easy to enjoy.',
      ],
    },
    menu: {
      eyebrow: 'Featured Menu',
      title: 'A concise menu preview with signature drinks and polished presentation.',
      description:
        "A curated selection of house signatures, fresh tropical mixes, and celebration-ready pours that communicate the bar's premium identity at a glance.",
    },
    gallery: {
      eyebrow: 'Gallery Preview',
      title: 'Intentional placeholders for drinks, ambiance, and real moments inside the venue.',
      description:
        'The gallery is structured to receive future photography without feeling empty today, giving each visual block a clear role in the story of the place.',
    },
    experience: {
      eyebrow: 'Experience',
      title: 'More than a night out: a social experience with music, celebration, and atmosphere.',
      description:
        'From match nights to birthdays and group plans, this section highlights the moments that give Zafiro its rhythm and make people want to come back.',
    },
    contact: {
      eyebrow: 'Reservations',
      title: 'Set the plan early and arrive with the night already in motion.',
      description:
        'Reserve by WhatsApp, ask about availability, and line up birthdays, gatherings, or a polished night out before you arrive.',
      button: 'Contact on WhatsApp',
    },
    location: {
      eyebrow: 'Location & Hours',
      title: 'Practical details for finding the venue, planning the visit, and arriving with confidence.',
      description:
        'The page closes with the details guests need most: address, neighborhood, hours, arrival reference, and direct contact channels.',
      where: 'Location',
      cityLabel: 'City',
      districtLabel: 'Area',
      addressLabel: 'Address',
      arrivalLabel: 'Arrival notes',
      whereDescription:
        'Structured to support a future embedded map while already making the venue feel easy to find.',
      hours: 'Hours',
      hoursNote: 'Open Thursday through Sunday and on holidays, starting at 6:00 PM with late closing depending on the night.',
      contactMethods: 'Contact Methods',
      contactNote: 'Built to make reservations, direct questions, and social contact feel immediate and clear.',
    },
    footer: {
      eyebrow: 'Zafiro Bar Lounge',
      contactLabel: 'Contact',
      contactDescription: 'Direct channels for reservations, availability, social discovery, and future customer attention.',
      socialLabel: 'Social',
      availabilityLabel: 'Open for plans',
      availabilityDescription: 'Florencia, Caquetá with a rooftop lounge concept built for cocktails, light bites, and polished nightlife.',
      closingNote: 'Built as the digital base for ZAFIRO’s next stage of visibility, reservations, and brand growth.',
      rights: 'All rights reserved.',
    },
    metrics: [
      { label: 'Signature and featured cocktails', value: '18+' },
      { label: 'Lounge atmosphere with premium focus', value: '100%' },
      { label: 'Best nights for reservations', value: 'Thu-Sun' },
    ],
    languageToggle: { en: 'EN', es: 'ES' },
  },
  es: {
    nav: { about: 'Nosotros', menu: 'Menu', gallery: 'Galeria', experience: 'Experiencia', contact: 'Contacto' },
    hero: { tonightLabel: 'Esta noche en Zafiro', cityLabel: 'Florencia' },
    about: {
      eyebrow: 'Sobre Zafiro',
      title: 'Un lugar cuidado para cocteles, buena musica y noches que fluyen con el ritmo correcto.',
      whyPeopleCome: 'Por que lo eligen',
      atmosphereLabel: 'Ambiente',
      bullets: [
        'Cocteles de autor servidos con presentacion cuidada y personalidad.',
        'Musica, noches de partido y celebraciones con una atmosfera mas pulida.',
        'Un lugar elegante que sigue sintiendose cercano, social y facil de disfrutar.',
      ],
    },
    menu: {
      eyebrow: 'Menu Destacado',
      title: 'Una vista breve del menu, con tragos de firma y presentacion cuidada.',
      description:
        'Una seleccion de la casa con cocteles de firma, mezclas frescas y opciones pensadas para celebraciones, mostrando de inmediato la identidad premium del bar.',
    },
    gallery: {
      eyebrow: 'Preview Visual',
      title: 'Placeholders intencionales para bebidas, ambiente y momentos reales dentro del lugar.',
      description:
        'La galeria queda lista para recibir fotos reales sin sentirse vacia hoy, porque cada bloque visual ya cumple un papel dentro de la historia del lugar.',
    },
    experience: {
      eyebrow: 'Experiencia',
      title: 'Mas que una salida: una experiencia social con musica, celebracion y atmosfera.',
      description:
        'Desde las noches de partido hasta los cumpleanos y los planes en grupo, esta seccion muestra los momentos que le dan ritmo a Zafiro y hacen que la gente quiera volver.',
    },
    contact: {
      eyebrow: 'Reservas',
      title: 'Define el plan con tiempo y llega con la noche ya encaminada.',
      description:
        'Reserva por WhatsApp, consulta disponibilidad y deja listo el plan para cumpleaños, reuniones o una buena salida antes de llegar.',
      button: 'Contactar por WhatsApp',
    },
    location: {
      eyebrow: 'Ubicacion y Horarios',
      title: 'Detalles practicos para ubicar el lugar, planear la visita y llegar con confianza.',
      description:
        'La pagina cierra con los datos que mas necesita el cliente: direccion, barrio, horarios, referencia de llegada y canales de contacto directo.',
      where: 'Ubicacion',
      cityLabel: 'Ciudad',
      districtLabel: 'Zona',
      addressLabel: 'Direccion',
      arrivalLabel: 'Referencias de llegada',
      whereDescription:
        'Queda lista para integrar un mapa despues, pero ya orienta mejor al cliente desde esta version.',
      hours: 'Horarios',
      hoursNote: 'Abierto de jueves a domingo y festivos, desde las 6:00 PM y con cierre en la madrugada segun la noche.',
      contactMethods: 'Canales de Contacto',
      contactNote: 'Pensado para que reservas, preguntas directas y contacto por redes se sientan claros e inmediatos.',
    },
    footer: {
      eyebrow: 'Zafiro Bar Lounge',
      contactLabel: 'Contacto',
      contactDescription: 'Canales directos para reservas, disponibilidad, descubrimiento social y futura atencion al cliente.',
      socialLabel: 'Social',
      availabilityLabel: 'Listo para tus planes',
      availabilityDescription: 'Florencia, Caquetá con un concepto rooftop lounge pensado para cócteles, cocina ligera y una noche mejor puesta.',
      closingNote: 'Construido como base digital para la siguiente etapa de visibilidad, reservas y crecimiento de ZAFIRO.',
      rights: 'Todos los derechos reservados.',
    },
    metrics: [
      { label: 'Cocteles de firma y destacados', value: '18+' },
      { label: 'Atmosfera lounge con enfoque premium', value: '100%' },
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
    featuredMenu: featuredMenuItems,
    gallery: galleryMoments,
    highlights: experienceHighlights,
  };
}
