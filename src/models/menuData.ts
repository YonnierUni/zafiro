import type { Locale } from './business';
import type { MenuCategory, MenuDataCollection, MenuDataItem } from '../shared/menu/menu.types';

export type { MenuCategory, MenuDataCollection, MenuDataItem } from '../shared/menu/menu.types';

const defaultCategoryLabels: Record<string, Record<Locale, string>> = {
  bebidas: { en: 'Drinks', es: 'Bebidas' },
  cocteles: { en: 'Cocktails', es: 'Cócteles' },
  comida: { en: 'Food', es: 'Comida' },
  'jugos-y-limonadas': { en: 'Juices & Lemonades', es: 'Jugos y Limonadas' },
  micheladas: { en: 'Micheladas', es: 'Micheladas' },
  otros: { en: 'More', es: 'Más' },
};

export function normalizeMenuCategory(tipo: string): MenuCategory {
  const normalized = sanitizeMenuText(tipo)
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-+|-+$/g, '');

  return normalized || 'otros';
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
    return 'Consultar valor';
  }

  return new Intl.NumberFormat('es-CO', {
    style: 'currency',
    currency: 'COP',
    minimumFractionDigits: 0,
    maximumFractionDigits: 0,
  }).format(price);
}

export function getMenuAvailabilityLabel(locale: Locale) {
  return locale === 'es' ? 'Agotado' : 'Sold out';
}

export function sanitizeMenuText(value: string) {
  let text = value.trim();

  if (!text) {
    return '';
  }

  for (let attempt = 0; attempt < 2; attempt += 1) {
    if (!/[ÃƒÃ‚Ã¢]/.test(text)) {
      break;
    }

    try {
      const decoded = decodeURIComponent(escape(text));

      if (!decoded || decoded === text) {
        break;
      }

      text = decoded;
    } catch {
      break;
    }
  }

  return text;
}

export function getMenuItemDisplayDescription(item: MenuDataItem) {
  return sanitizeMenuText(item.description ?? '');
}

export function getLocalizedCategoryLabel(category: MenuCategory, locale: Locale) {
  const normalizedCategory = normalizeMenuCategory(category);

  if (defaultCategoryLabels[normalizedCategory]) {
    return defaultCategoryLabels[normalizedCategory][locale];
  }

  return humanizeMenuLabel(normalizedCategory);
}

export function getVisibleMenuItems(items: MenuDataItem[]) {
  return items.filter((item) => item.visible === true);
}

export function isMenuItemAvailable(item: MenuDataItem) {
  return item.disponible !== false;
}

export function getOrderedMenuCategories(items: MenuDataItem[]) {
  const categories: MenuCategory[] = [];
  const seenCategories = new Set<MenuCategory>();

  for (const item of items) {
    const category = getMenuSectionCategory(item);

    if (!seenCategories.has(category)) {
      seenCategories.add(category);
      categories.push(category);
    }
  }

  return categories;
}

export function getMenuSectionCategory(item: MenuDataItem): MenuCategory {
  const sheetName = sanitizeMenuText(item.hojaOrigen ?? '');

  if (sheetName) {
    return normalizeMenuCategory(sheetName);
  }

  return normalizeMenuCategory(item.tipo);
}

export function getMenuSubgroupLabel(item: MenuDataItem) {
  const subgroup = sanitizeMenuText(item.subgrupo ?? '');

  if (subgroup) {
    return subgroup;
  }

  return 'General';
}

export function groupMenuItemsByTypeAndSubgroup(items: MenuDataItem[]) {
  const grouped = new Map<MenuCategory, Map<string, { firstIndex: number; items: MenuDataItem[] }>>();

  for (const [index, item] of items.entries()) {
    const category = getMenuSectionCategory(item);
    const subgroup = getMenuSubgroupLabel(item);
    const categoryGroups = grouped.get(category) ?? new Map<string, { firstIndex: number; items: MenuDataItem[] }>();
    const subgroupGroup = categoryGroups.get(subgroup) ?? { firstIndex: index, items: [] };

    subgroupGroup.items.push(item);
    categoryGroups.set(subgroup, subgroupGroup);
    grouped.set(category, categoryGroups);
  }

  const result: Record<MenuCategory, { subgroup: string; items: MenuDataItem[] }[]> = {};

  for (const [category, subgroupMap] of grouped.entries()) {
    result[category] = Array.from(subgroupMap.entries())
      .map(([subgroup, subgroupGroup]) => ({
        subgroup,
        firstIndex: subgroupGroup.firstIndex,
        items: sortMenuItemsByOrder(subgroupGroup.items),
      }))
      .sort((left, right) => {
        const leftOrder = getMenuItemOrder(left.items[0]);
        const rightOrder = getMenuItemOrder(right.items[0]);

        if (leftOrder !== rightOrder) {
          return leftOrder - rightOrder;
        }

        return left.firstIndex - right.firstIndex;
      })
      .map(({ subgroup, items }) => ({ subgroup, items }));
  }

  return result;
}

export function sortMenuItemsByOrder(items: MenuDataItem[]) {
  return [...items].sort((left, right) => {
    const leftOrder = getMenuItemOrder(left);
    const rightOrder = getMenuItemOrder(right);

    if (leftOrder !== rightOrder) {
      return leftOrder - rightOrder;
    }

    return sanitizeMenuText(left.name).localeCompare(sanitizeMenuText(right.name), 'es-CO');
  });
}

function getMenuItemOrder(item: MenuDataItem) {
  return Number.isFinite(item.orden) ? item.orden : Number.MAX_SAFE_INTEGER;
}

function humanizeMenuLabel(value: string) {
  const cleanValue = sanitizeMenuText(value)
    .replace(/[-_]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();

  if (!cleanValue) {
    return 'Otros';
  }

  return cleanValue.replace(/\b\w/g, (match) => match.toUpperCase());
}
