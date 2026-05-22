import {
  loadAdminMenuCollectionFromSupabase,
  loadPublicMenuCollectionFromSupabase,
} from '../integrations/supabase/menuCatalogRepository';
import { getSupabaseConfigDiagnostics, isSupabaseConfigured } from '../integrations/supabase/client';
import type { MenuDataCollection } from '../shared/menu/menu.types';

interface LoadMenuDataOptions {
  audience?: 'admin' | 'public';
  fallbackToJson?: boolean;
}

export async function loadMenuData(options: LoadMenuDataOptions = {}) {
  const { audience = 'public', fallbackToJson = true } = options;
  const diagnostics = getSupabaseConfigDiagnostics();

  if (isSupabaseConfigured()) {
    try {
      return audience === 'admin'
        ? await loadAdminMenuCollectionFromSupabase()
        : await loadPublicMenuCollectionFromSupabase();
    } catch (supabaseError) {
      if (!fallbackToJson) {
        throw supabaseError;
      }

      console.warn('Falling back to local menu.json after Supabase load error.', supabaseError);
    }
  } else if (fallbackToJson) {
    console.info(
      `[menuController] Supabase no configurado para ${audience}. Usando fallback local menu.json.`,
      diagnostics,
    );
  }

  return loadMenuDataFromJson();
}

async function loadMenuDataFromJson() {
  const response = await fetch(`${import.meta.env.BASE_URL}data/menu.json`);

  if (!response.ok) {
    throw new Error(`Failed to load menu.json (${response.status})`);
  }

  return (await response.json()) as MenuDataCollection;
}
