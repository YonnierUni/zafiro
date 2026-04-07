import type { MenuDataCollection } from '../models/menuData';

export async function loadMenuData() {
  const response = await fetch(`${import.meta.env.BASE_URL}data/menu.json`);

  if (!response.ok) {
    throw new Error(`Failed to load menu.json (${response.status})`);
  }

  return (await response.json()) as MenuDataCollection;
}
