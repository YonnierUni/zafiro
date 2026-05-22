import type { MenuDataItem } from './menu.types';

export function buildMenuSourceKey(item: Pick<MenuDataItem, 'hojaOrigen' | 'slug' | 'id'>) {
  return buildMenuSourceKeyFromParts(item.hojaOrigen, item.slug, item.id);
}

export function buildMenuSourceKeyFromParts(hojaOrigen: string, slug: string, id: number) {
  return `${sanitizeKeyPart(hojaOrigen)}::${sanitizeKeyPart(slug)}::${String(id).trim()}`;
}

function sanitizeKeyPart(value: string) {
  return String(value ?? '')
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-+|-+$/g, '') || 'sin-valor';
}
