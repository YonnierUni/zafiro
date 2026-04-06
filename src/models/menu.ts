import type { LocalizedText } from './business';

export interface MenuItem {
  name: string;
  price: string;
  category: LocalizedText;
  description: LocalizedText;
  accent: string;
}

export const featuredMenuItems: MenuItem[] = [
  {
    name: 'Mains Zafiro',
    price: '$28.000',
    category: { en: 'Signature House', es: 'Firma de la casa' },
    description: {
      en: 'The cocktail that defines the house: sapphire color, fresh citrus lift, and a polished finish.',
      es: 'El coctel que define la casa: color zafiro, frescura citrica y un final elegante.',
    },
    accent: 'from-sapphire/30 to-cyanGlow/5',
  },
  {
    name: 'Passion Fresh',
    price: '$24.000',
    category: { en: 'Tropical Fresh', es: 'Fresco tropical' },
    description: {
      en: 'Passion fruit, soft sparkle, and an easy tropical profile made for warm nights in Florencia.',
      es: 'Maracuya, un toque chispeante y un perfil tropical ligero hecho para las noches calidas de Florencia.',
    },
    accent: 'from-amberGlow/30 to-transparent',
  },
  {
    name: 'Hawaiian Blue',
    price: '$26.000',
    category: { en: 'Classic with a Twist', es: 'Clasico con giro' },
    description: {
      en: 'Island-inspired notes with deep blue presentation and a crisp, refreshing close.',
      es: 'Notas inspiradas en la isla, una presentacion azul profunda y un cierre fresco y limpio.',
    },
    accent: 'from-cyanGlow/25 to-transparent',
  },
  {
    name: 'Cherry Champagne',
    price: '$30.000',
    category: { en: 'Celebration Pour', es: 'Para celebrar' },
    description: {
      en: 'Elegant bubbles and cherry notes designed for birthdays, toasts, and nights that deserve a little more.',
      es: 'Burbujas elegantes y notas de cereza pensadas para cumpleanos, brindis y noches que merecen algo mas.',
    },
    accent: 'from-rose-200/15 to-transparent',
  },
  {
    name: 'Mojito Fresh',
    price: '$22.000',
    category: { en: 'All-Night Favorite', es: 'Favorito de la noche' },
    description: {
      en: 'Mint, citrus, and a refreshing balance that fits long conversations and easy-going plans.',
      es: 'Menta, citricos y un balance refrescante que acompana conversaciones largas y planes sin afan.',
    },
    accent: 'from-emerald-300/20 to-transparent',
  },
  {
    name: 'Blue Lagoon Drop',
    price: '$25.000',
    category: { en: 'Visual Standout', es: 'Impacto visual' },
    description: {
      en: 'Vivid sapphire color, bright energy, and a presentation designed to stand out before the first sip.',
      es: 'Color zafiro vibrante, energia fresca y una presentacion hecha para destacar antes del primer sorbo.',
    },
    accent: 'from-blue-400/25 to-transparent',
  },
];
