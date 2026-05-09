import type { Locale } from './business';
import type {
  MenuCategory,
  MenuDataCollection,
  MenuDataItem,
} from '../shared/menu/menu.types';

export type { MenuCategory, MenuDataCollection, MenuDataItem } from '../shared/menu/menu.types';

const preferredCategoryOrder = ['cocteles', 'bebidas', 'comida'] as const;

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

  const labels: Record<string, Record<Locale, string>> = {
    cocteles: { en: 'Cocktails', es: 'Cócteles' },
    bebidas: { en: 'Drinks', es: 'Bebidas' },
    comida: { en: 'Food', es: 'Comida' },
    otros: { en: 'More', es: 'Más' },
  };

  if (labels[normalizedCategory]) {
    return labels[normalizedCategory][locale];
  }

  return humanizeMenuCategoryLabel(normalizedCategory);
}

export function getVisibleMenuItems(items: MenuDataItem[]) {
  return sortMenuItemsByOrder(items.filter((item) => item.visible === true));
}

export function isMenuItemAvailable(item: MenuDataItem) {
  return item.disponible !== false;
}

export function groupMenuItemsByCategory(items: MenuDataItem[]) {
  const grouped: Record<MenuCategory, MenuDataItem[]> = {};

  for (const item of items) {
    const category = normalizeMenuCategory(item.tipo);

    if (!grouped[category]) {
      grouped[category] = [];
    }

    grouped[category].push(item);
  }

  return grouped;
}

export function getOrderedMenuCategories(items: MenuDataItem[]) {
  const categories = Array.from(new Set(items.map((item) => normalizeMenuCategory(item.tipo))));
  const primaryCategories = preferredCategoryOrder.filter((category) => categories.includes(category));
  const additionalCategories = categories
    .filter((category) => !preferredCategoryOrder.includes(category as (typeof preferredCategoryOrder)[number]))
    .sort((left, right) =>
      humanizeMenuCategoryLabel(left).localeCompare(humanizeMenuCategoryLabel(right), 'es-CO'),
    );

  return [...primaryCategories, ...additionalCategories];
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
  const groupedByType: Record<MenuCategory, ReturnType<typeof groupItemsBySubgroup>> = {};

  for (const category of Object.keys(byType)) {
    groupedByType[category] = groupItemsBySubgroup(byType[category]);
  }

  return groupedByType;
}

function groupItemsBySubgroup(items: MenuDataItem[]) {
  const grouped = new Map<string, MenuDataItem[]>();

  for (const item of sortMenuItemsByOrder(items)) {
    const subgroup = getMenuSubgroupLabel(item);
    const existing = grouped.get(subgroup) ?? [];
    existing.push(item);
    grouped.set(subgroup, existing);
  }

  return Array.from(grouped.entries())
    .map(([subgroup, subgroupItems]) => ({
      subgroup,
      items: sortMenuItemsByOrder(subgroupItems),
    }))
    .sort((left, right) => {
      const leftOrder = getMenuItemOrder(left.items[0]);
      const rightOrder = getMenuItemOrder(right.items[0]);

      if (leftOrder !== rightOrder) {
        return leftOrder - rightOrder;
      }

      return left.subgroup.localeCompare(right.subgroup, 'es-CO');
    });
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

function humanizeMenuCategoryLabel(category: string) {
  return sanitizeMenuText(category)
    .split(/[-_\s]+/)
    .filter(Boolean)
    .map((segment) => segment.charAt(0).toUpperCase() + segment.slice(1))
    .join(' ');
}
