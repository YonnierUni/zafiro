import type { Locale } from './business';

export type MenuCategory = 'cocteles' | 'bebidas' | 'comida' | 'otros';

export interface MenuDataItem {
  id: number;
  slug: string;
  name: string;
  description: string;
  tipo: string;
  subgrupo?: string;
  ingredientes: string;
  preparacion: string;
  emplatado: string;
  precioVenta: number | null;
  imagen: string;
  hojaOrigen: string;
  visible: boolean;
}

export interface MenuDataCollection {
  updatedAt: string;
  count: number;
  items: MenuDataItem[];
}

export function normalizeMenuCategory(tipo: string): MenuCategory {
  switch (tipo.trim().toLowerCase()) {
    case 'cocteles':
      return 'cocteles';
    case 'bebidas':
      return 'bebidas';
    case 'comida':
      return 'comida';
    default:
      return 'otros';
  }
}

export function resolveMenuImageSrc(imagePath: string): string {
  const normalizedPath = imagePath.trim().replace(/^\/+/, '');

  if (!normalizedPath) {
    return '';
  }

  return `${import.meta.env.BASE_URL}${normalizedPath}`;
}

export function formatMenuPrice(price: number | null) {
  if (price === null) {
    return 'Consultar';
  }

  return new Intl.NumberFormat('es-CO', {
    style: 'currency',
    currency: 'COP',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(price);
}

export function sanitizeMenuText(value: string) {
  const text = value.trim();

  if (!text) {
    return '';
  }

  if (!/[ÂÃâ]/.test(text)) {
    return text;
  }

  try {
    return decodeURIComponent(escape(text));
  } catch {
    return text;
  }
}

export function getMenuItemDisplayDescription(item: MenuDataItem) {
  return sanitizeMenuText(item.description ?? '');
}

export function getLocalizedCategoryLabel(category: MenuCategory, locale: Locale) {
  const labels: Record<MenuCategory, Record<Locale, string>> = {
    cocteles: { en: 'Cocktails', es: 'Cócteles' },
    bebidas: { en: 'Drinks', es: 'Bebidas' },
    comida: { en: 'Food', es: 'Comida' },
    otros: { en: 'More', es: 'Más' },
  };

  return labels[category][locale];
}

export function getVisibleMenuItems(items: MenuDataItem[]) {
  return items.filter((item) => item.visible);
}

export function groupMenuItemsByCategory(items: MenuDataItem[]) {
  const grouped: Record<MenuCategory, MenuDataItem[]> = {
    cocteles: [],
    bebidas: [],
    comida: [],
    otros: [],
  };

  for (const item of items) {
    grouped[normalizeMenuCategory(item.tipo)].push(item);
  }

  return grouped;
}

export function getMenuSubgroupLabel(item: MenuDataItem) {
  const subgroup = sanitizeMenuText(item.subgrupo ?? '');

  if (subgroup) {
    return subgroup;
  }

  const source = sanitizeMenuText(item.hojaOrigen);

  if (source) {
    return source;
  }

  return 'General';
}

export function groupMenuItemsByTypeAndSubgroup(items: MenuDataItem[]) {
  const byType = groupMenuItemsByCategory(items);

  return {
    cocteles: groupItemsBySubgroup(byType.cocteles),
    bebidas: groupItemsBySubgroup(byType.bebidas),
    comida: groupItemsBySubgroup(byType.comida),
    otros: groupItemsBySubgroup(byType.otros),
  };
}

function groupItemsBySubgroup(items: MenuDataItem[]) {
  const grouped = new Map<string, MenuDataItem[]>();

  for (const item of items) {
    const subgroup = getMenuSubgroupLabel(item);
    const existing = grouped.get(subgroup) ?? [];
    existing.push(item);
    grouped.set(subgroup, existing);
  }

  return Array.from(grouped.entries()).map(([subgroup, subgroupItems]) => ({
    subgroup,
    items: subgroupItems,
  }));
}
