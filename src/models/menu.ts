import type { LocalizedText } from './business';
import { cocktailImageMap } from './menuMedia';

export interface MenuItem {
  name: string;
  price: LocalizedText;
  category: LocalizedText;
  description: LocalizedText;
  accent: string;
  imageSrc: string;
  imageAlt: LocalizedText;
  variants?: LocalizedText;
}

export const featuredMenuItems: MenuItem[] = [
  {
    name: 'Mains Zafiro',
    price: { en: '$28.000', es: '$28.000' },
    category: { en: 'House Signature', es: 'C\u00f3ctel de la casa' },
    description: {
      en: 'The house cocktail that anchors the menu: sapphire color, fresh citrus lift, and a polished finish.',
      es: 'El c\u00f3ctel insignia de la casa: color zafiro, frescura c\u00edtrica y un final elegante.',
    },
    accent: 'from-sapphire/30 to-cyanGlow/5',
    imageSrc: cocktailImageMap.mainsZafiro,
    imageAlt: {
      en: 'Mains Zafiro house cocktail',
      es: 'C\u00f3ctel de la casa Mains Zafiro',
    },
  },
  {
    name: 'Margaritas',
    price: { en: 'Ask in venue', es: 'Consultar en el lugar' },
    category: { en: 'Shared Image Group', es: 'Selecci\u00f3n de margaritas' },
    description: {
      en: 'One signature image represents the full margarita lineup, with a brighter, more playful profile for group plans and warm nights.',
      es: 'Una sola imagen representa toda la l\u00ednea de margaritas, con un perfil m\u00e1s fresco y llamativo para planes en grupo y noches c\u00e1lidas.',
    },
    accent: 'from-amberGlow/30 to-transparent',
    imageSrc: cocktailImageMap.margaritas,
    imageAlt: {
      en: 'Shared image for the margarita lineup',
      es: 'Imagen compartida para la l\u00ednea de margaritas',
    },
    variants: {
      en: 'Variants: Traditional, Apple, Sandia Red, Blue',
      es: 'Variantes: Tradicional, Manzana, Sand\u00eda Red, Blue',
    },
  },
  {
    name: 'Passion Fresh',
    price: { en: '$24.000', es: '$24.000' },
    category: { en: 'Tropical Fresh', es: 'Fresco tropical' },
    description: {
      en: 'Passion fruit, a soft sparkle, and an easy tropical profile made for warm nights in Florencia.',
      es: 'Maracuy\u00e1, un toque chispeante y un perfil tropical ligero hecho para las noches c\u00e1lidas de Florencia.',
    },
    accent: 'from-amberGlow/30 to-transparent',
    imageSrc: cocktailImageMap.passionFresh,
    imageAlt: {
      en: 'Passion Fresh cocktail',
      es: 'C\u00f3ctel Passion Fresh',
    },
  },
  {
    name: 'Hawaiian Blue',
    price: { en: '$26.000', es: '$26.000' },
    category: { en: 'Classic with a Twist', es: 'Cl\u00e1sico con giro' },
    description: {
      en: 'Island-inspired notes with a deep blue presentation and a crisp, refreshing close.',
      es: 'Notas inspiradas en la isla, una presentaci\u00f3n azul profunda y un cierre fresco y limpio.',
    },
    accent: 'from-cyanGlow/25 to-transparent',
    imageSrc: cocktailImageMap.hawaiianBlue,
    imageAlt: {
      en: 'Hawaiian Blue cocktail',
      es: 'C\u00f3ctel Hawaiian Blue',
    },
  },
  {
    name: 'Cherry Champagne',
    price: { en: '$30.000', es: '$30.000' },
    category: { en: 'Celebration Pour', es: 'Para celebrar' },
    description: {
      en: 'Elegant bubbles and cherry notes designed for birthdays, toasts, and nights that deserve a little more.',
      es: 'Burbujas elegantes y notas de cereza pensadas para cumplea\u00f1os, brindis y noches que merecen algo m\u00e1s.',
    },
    accent: 'from-rose-200/15 to-transparent',
    imageSrc: cocktailImageMap.cherryChampagne,
    imageAlt: {
      en: 'Cherry Champagne cocktail',
      es: 'C\u00f3ctel Cherry Champagne',
    },
  },
  {
    name: 'Micheladas',
    price: { en: 'Ask in venue', es: 'Consultar en el lugar' },
    category: { en: 'Shared Image Group', es: 'Micheladas de la casa' },
    description: {
      en: 'One main image represents the michelada lineup, keeping the group feel visual while the variants stay clear in text.',
      es: 'Una imagen principal representa la l\u00ednea de micheladas, manteniendo lo visual del grupo mientras las variantes quedan claras en texto.',
    },
    accent: 'from-amberGlow/20 to-sapphire/10',
    imageSrc: cocktailImageMap.micheladas,
    imageAlt: {
      en: 'Shared image for the michelada lineup',
      es: 'Imagen compartida para la l\u00ednea de micheladas',
    },
    variants: {
      en: 'Variants: Red Fruits, Green, Yellow, Traditional, Bretana, National Beer, Imported Beer',
      es: 'Variantes: Frutos Rojos, Verdes, Amarillos, Tradicional, Breta\u00f1a, Cerveza Nacional, Cerveza Importada',
    },
  },
  {
    name: 'Mojito Fresh',
    price: { en: '$22.000', es: '$22.000' },
    category: { en: 'All-Night Favorite', es: 'Favorito de la noche' },
    description: {
      en: 'Mint, citrus, and a refreshing balance that fits long conversations and easy-going plans.',
      es: 'Menta, c\u00edtricos y un balance refrescante que acompa\u00f1a conversaciones largas y planes sin af\u00e1n.',
    },
    accent: 'from-emerald-300/20 to-transparent',
    imageSrc: cocktailImageMap.mojitoFresh,
    imageAlt: {
      en: 'Mojito Fresh cocktail',
      es: 'C\u00f3ctel Mojito Fresh',
    },
  },
  {
    name: 'Blue Lagoon Drop',
    price: { en: '$25.000', es: '$25.000' },
    category: { en: 'Visual Standout', es: 'Impacto visual' },
    description: {
      en: 'Vivid sapphire color, bright energy, and a presentation designed to stand out before the first sip.',
      es: 'Color zafiro vibrante, energ\u00eda fresca y una presentaci\u00f3n hecha para destacar antes del primer sorbo.',
    },
    accent: 'from-blue-400/25 to-transparent',
    imageSrc: cocktailImageMap.blueLagoonDrop,
    imageAlt: {
      en: 'Blue Lagoon Drop cocktail',
      es: 'C\u00f3ctel Blue Lagoon Drop',
    },
  },
];
