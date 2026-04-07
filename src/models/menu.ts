import type { LocalizedText } from './business';
import {
  formatMenuPrice,
  getLocalizedCategoryLabel,
  getMenuItemDisplayDescription,
  normalizeMenuCategory,
  resolveMenuImageSrc,
  sanitizeMenuText,
  type MenuDataItem,
} from './menuData';

export interface MenuItem {
  slug: string;
  name: string;
  price: LocalizedText;
  category: LocalizedText;
  description: LocalizedText;
  accent: string;
  imageSrc: string;
  imageAlt: LocalizedText;
  variants?: LocalizedText;
}

interface FeaturedMenuEditorialItem {
  accent: string;
  category: LocalizedText;
  description: LocalizedText;
  variants?: LocalizedText;
}

const featuredMenuEditorialBySlug: Record<string, FeaturedMenuEditorialItem> = {
  'mains-zafiro': {
    accent: 'from-sapphire/30 to-cyanGlow/5',
    category: { en: 'House Signature', es: 'Cóctel de la casa' },
    description: {
      en: 'The house cocktail that anchors the menu: sapphire color, fresh citrus lift, and a polished finish.',
      es: 'El cóctel insignia de la casa: color zafiro, frescura cítrica y un final elegante.',
    },
  },
  margaritas: {
    accent: 'from-amberGlow/30 to-transparent',
    category: { en: 'Shared Image Group', es: 'Selección de margaritas' },
    description: {
      en: 'One signature image represents the full margarita lineup, with a brighter, more playful profile for group plans and warm nights.',
      es: 'Una sola imagen representa toda la línea de margaritas, con un perfil más fresco y llamativo para planes en grupo y noches cálidas.',
    },
    variants: {
      en: 'Variants: Traditional, Apple, Sandia Red, Blue',
      es: 'Variantes: Tradicional, Manzana, Sandía Red, Blue',
    },
  },
  'passion-fresh': {
    accent: 'from-amberGlow/30 to-transparent',
    category: { en: 'Tropical Fresh', es: 'Fresco tropical' },
    description: {
      en: 'Passion fruit, a soft sparkle, and an easy tropical profile made for warm nights in Florencia.',
      es: 'Maracuyá, un toque chispeante y un perfil tropical ligero hecho para las noches cálidas de Florencia.',
    },
  },
  'coctel-tequila-sunrise': {
    accent: 'from-orange-300/25 to-transparent',
    category: { en: 'Sunset Classic', es: 'Clásico al atardecer' },
    description: {
      en: 'Citrus, warmth, and a bold color profile that fits the first round of the night beautifully.',
      es: 'Cítricos, calidez y un perfil de color intenso que acompaña perfecto la primera ronda de la noche.',
    },
  },
  'hawaiian-blue': {
    accent: 'from-cyanGlow/25 to-transparent',
    category: { en: 'Classic with a Twist', es: 'Clásico con giro' },
    description: {
      en: 'Island-inspired notes with a deep blue presentation and a crisp, refreshing close.',
      es: 'Notas inspiradas en la isla, una presentación azul profunda y un cierre fresco y limpio.',
    },
  },
  'cherry-champagne': {
    accent: 'from-rose-200/15 to-transparent',
    category: { en: 'Celebration Pour', es: 'Para celebrar' },
    description: {
      en: 'Elegant bubbles and cherry notes designed for birthdays, toasts, and nights that deserve a little more.',
      es: 'Burbujas elegantes y notas de cereza pensadas para cumpleaños, brindis y noches que merecen algo más.',
    },
  },
  'micheldas-frutos-rojos-verdes-amarillos': {
    accent: 'from-amberGlow/20 to-sapphire/10',
    category: { en: 'Shared Image Group', es: 'Micheladas de la casa' },
    description: {
      en: 'One main image represents the michelada lineup, keeping the group feel visual while the variants stay clear in text.',
      es: 'Una imagen principal representa la línea de micheladas, manteniendo lo visual del grupo mientras las variantes quedan claras en texto.',
    },
    variants: {
      en: 'Variants: Red Fruits, Green, Yellow, Traditional, Bretana, National Beer, Imported Beer',
      es: 'Variantes: Frutos Rojos, Verdes, Amarillos, Tradicional, Bretaña, Cerveza Nacional, Cerveza Importada',
    },
  },
  'mojito-fresd': {
    accent: 'from-emerald-300/20 to-transparent',
    category: { en: 'All-Night Favorite', es: 'Favorito de la noche' },
    description: {
      en: 'Mint, citrus, and a refreshing balance that fits long conversations and easy-going plans.',
      es: 'Menta, cítricos y un balance refrescante que acompaña conversaciones largas y planes sin afán.',
    },
  },
  'blue-lagoon-drop': {
    accent: 'from-blue-400/25 to-transparent',
    category: { en: 'Visual Standout', es: 'Impacto visual' },
    description: {
      en: 'Vivid sapphire color, bright energy, and a presentation designed to stand out before the first sip.',
      es: 'Color zafiro vibrante, energía fresca y una presentación hecha para destacar antes del primer sorbo.',
    },
  },
};

export const featuredMenuSlugs = [
  'mains-zafiro',
  'margaritas',
  'passion-fresh',
  'coctel-tequila-sunrise',
  'hawaiian-blue',
  'cherry-champagne',
  'micheldas-frutos-rojos-verdes-amarillos',
  'mojito-fresd',
  'blue-lagoon-drop',
] as const;

export function buildFeaturedMenuItems(items: MenuDataItem[]): MenuItem[] {
  const featuredItems: MenuItem[] = [];

  for (const slug of featuredMenuSlugs) {
    const item = items.find((menuItem) => menuItem.slug === slug);
    const editorial = featuredMenuEditorialBySlug[slug];

    if (!item || !editorial) {
      continue;
    }

    const displayName =
      slug === 'micheldas-frutos-rojos-verdes-amarillos' ? 'Micheladas' : sanitizeMenuText(item.name);

    featuredItems.push({
      slug,
      name: displayName,
      price: {
        en: formatMenuPrice(item.precioVenta),
        es: formatMenuPrice(item.precioVenta),
      },
      category: editorial.category,
      description: editorial.description,
      accent: editorial.accent,
      imageSrc: resolveMenuImageSrc(item.imagen),
      imageAlt: {
        en: `${displayName} menu item`,
        es: `${displayName} del menú`,
      },
      variants: editorial.variants,
    });
  }

  return featuredItems;
}

export function buildFallbackFeaturedMenuItem(item: MenuDataItem): MenuItem {
  const displayName = sanitizeMenuText(item.name);
  const normalizedCategory = normalizeMenuCategory(item.tipo);

  return {
    slug: item.slug,
    name: displayName,
    price: {
      en: formatMenuPrice(item.precioVenta),
      es: formatMenuPrice(item.precioVenta),
    },
    category: {
      en: getLocalizedCategoryLabel(normalizedCategory, 'en'),
      es: getLocalizedCategoryLabel(normalizedCategory, 'es'),
    },
    description: {
      en: getMenuItemDisplayDescription(item) || displayName,
      es: getMenuItemDisplayDescription(item) || displayName,
    },
    accent: 'from-sapphire/20 to-transparent',
    imageSrc: resolveMenuImageSrc(item.imagen),
    imageAlt: {
      en: `${displayName} menu item`,
      es: `${displayName} del menú`,
    },
  };
}
