import { buildAdminMenuApplyPayload } from '../../admin/menu/adminMenu.mapper';
import type { AdminMenuDraftItem } from '../../admin/menu/adminMenu.types';
import type { MenuDataCollection, MenuDataItem } from '../../shared/menu/menu.types';
import { buildMenuSourceKey } from '../../shared/menu/menuSourceKey';
import { getSupabaseClient } from './client';
import type { Database } from './database.types';

type MenuItemRow = Database['public']['Tables']['menu_items']['Row'];
type MenuItemInsert = Database['public']['Tables']['menu_items']['Insert'];

export interface SaveMenuCatalogResult {
  appliedCount: number;
  collection: MenuDataCollection;
  logCount: number;
}

export interface SaveMenuCatalogOptions {
  actorLabel?: string;
  changeSource?: string;
  snapshotKind?: string;
  snapshotPayload?: Record<string, unknown>;
  snapshotSummary?: Record<string, unknown>;
}

export async function loadPublicMenuCollectionFromSupabase() {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from('menu_items_public')
    .select('*')
    .order('orden', { ascending: true })
    .order('name', { ascending: true });

  if (error) {
    throw new Error(`No fue posible leer el catalogo publico desde Supabase: ${error.message}`);
  }

  return mapRowsToCollection(data ?? []);
}

export async function loadAdminMenuCollectionFromSupabase() {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from('menu_items')
    .select('*')
    .order('orden', { ascending: true })
    .order('name', { ascending: true });

  if (error) {
    throw new Error(`No fue posible leer el catalogo admin desde Supabase: ${error.message}`);
  }

  return mapRowsToCollection(data ?? []);
}

export async function saveAdminMenuDraftsToSupabase(
  drafts: AdminMenuDraftItem[],
  options: SaveMenuCatalogOptions = {},
) {
  const supabase = getSupabaseClient();
  const applyPayload = buildAdminMenuApplyPayload(drafts);
  const readyDrafts = drafts.filter((draft) =>
    applyPayload.items.some((item) => item.draftKey === draft.draftKey && item.status === 'ready'),
  );

  if (!readyDrafts.length) {
    throw new Error('No hay cambios validos listos para guardar en Supabase.');
  }

  const rowsToUpsert = readyDrafts.map(mapDraftToMenuItemInsert);
  const logsToInsert = readyDrafts.map((draft) => ({
    menu_item_source_key: resolveDraftSourceKey(draft),
    item_slug: draft.slug,
    change_source: options.changeSource ?? 'admin_menu',
    actor_label: options.actorLabel ?? 'anonymous-admin',
    changed_fields: buildChangedFieldsRecord(draft),
    before_data: mapMenuItemToLogPayload(draft.original),
    after_data: mapMenuItemToLogPayload({
      ...draft.original,
      ...mapDraftBackToMenuDataItem(draft),
    }),
  }));

  const { error: upsertError } = await supabase
    .from('menu_items')
    .upsert(rowsToUpsert as never, { onConflict: 'source_key' });

  if (upsertError) {
    throw new Error(`No fue posible guardar el catalogo en Supabase: ${upsertError.message}`);
  }

  const { error: logError } = await supabase.from('menu_change_logs').insert(logsToInsert as never);

  if (logError) {
    throw new Error(`El catalogo se guardo, pero no fue posible registrar la trazabilidad: ${logError.message}`);
  }

  const { error: snapshotError } = await supabase.from('menu_snapshots').insert({
    snapshot_kind: options.snapshotKind ?? 'catalog_apply',
    summary: (options.snapshotSummary ?? (applyPayload.summary as unknown as Record<string, unknown>)) as never,
    payload: (options.snapshotPayload ?? (applyPayload as unknown as Record<string, unknown>)) as never,
  } as never);

  if (snapshotError) {
    throw new Error(`El catalogo se guardo, pero no fue posible registrar el snapshot en Supabase: ${snapshotError.message}`);
  }

  const collection = await loadAdminMenuCollectionFromSupabase();

  return {
    appliedCount: readyDrafts.length,
    logCount: logsToInsert.length,
    collection,
  } satisfies SaveMenuCatalogResult;
}

function mapRowsToCollection(rows: MenuItemRow[]): MenuDataCollection {
  const updatedAt =
    rows.reduce((latest, row) => (row.updated_at > latest ? row.updated_at : latest), rows[0]?.updated_at ?? new Date().toISOString());

  return {
    updatedAt,
    count: rows.length,
    items: rows.map(mapRowToMenuItem),
  };
}

function mapRowToMenuItem(row: MenuItemRow): MenuDataItem {
  return {
    id: row.legacy_id,
    sourceKey: row.source_key,
    orden: row.orden,
    slug: row.slug,
    name: row.name,
    description: row.description ?? '',
    tipo: row.tipo,
    subgrupo: row.subgrupo ?? '',
    ingredientes: row.ingredientes ?? '',
    preparacion: row.preparacion ?? '',
    emplatado: row.emplatado ?? '',
    precioVenta: row.precio_venta,
    imagen: row.imagen ?? '',
    hojaOrigen: row.hoja_origen,
    visible: row.visible,
    disponible: row.disponible,
    destacado: row.destacado,
    createdAt: row.created_at,
    updatedAt: row.updated_at,
  };
}

function mapDraftToMenuItemInsert(draft: AdminMenuDraftItem): MenuItemInsert {
  return {
    source_key: resolveDraftSourceKey(draft),
    legacy_id: draft.id,
    slug: draft.slug,
    hoja_origen: draft.hojaOrigen,
    tipo: draft.tipo.trim(),
    subgrupo: draft.subgrupo.trim() || null,
    name: draft.name.trim(),
    description: draft.description.trim(),
    ingredientes: draft.original.ingredientes ?? '',
    preparacion: draft.original.preparacion ?? '',
    emplatado: draft.original.emplatado ?? '',
    precio_venta: parsePrice(draft.precioVenta),
    imagen: draft.imagen.trim(),
    visible: draft.visible,
    disponible: draft.disponible,
    destacado: draft.destacado,
    orden: parseOrder(draft.orden, draft.original.orden),
  };
}

function resolveDraftSourceKey(draft: AdminMenuDraftItem) {
  return draft.original.sourceKey ??
    buildMenuSourceKey({
      hojaOrigen: draft.hojaOrigen,
      slug: draft.slug,
      id: draft.id,
    });
}

function mapDraftBackToMenuDataItem(draft: AdminMenuDraftItem): MenuDataItem {
  return {
    ...draft.original,
    name: draft.name.trim(),
    description: draft.description.trim(),
    tipo: draft.tipo.trim(),
    subgrupo: draft.subgrupo.trim(),
    precioVenta: parsePrice(draft.precioVenta),
    imagen: draft.imagen.trim(),
    visible: draft.visible,
    disponible: draft.disponible,
    destacado: draft.destacado,
    orden: parseOrder(draft.orden, draft.original.orden),
  };
}

function buildChangedFieldsRecord(draft: AdminMenuDraftItem) {
  return {
    name: draft.name.trim() !== draft.original.name,
    description: draft.description.trim() !== (draft.original.description ?? ''),
    precioVenta: parsePrice(draft.precioVenta) !== draft.original.precioVenta,
    tipo: draft.tipo.trim() !== draft.original.tipo,
    subgrupo: draft.subgrupo.trim() !== (draft.original.subgrupo ?? ''),
    visible: draft.visible !== draft.original.visible,
    disponible: draft.disponible !== draft.original.disponible,
    destacado: draft.destacado !== draft.original.destacado,
    orden: parseOrder(draft.orden, draft.original.orden) !== draft.original.orden,
    imagen: draft.imagen.trim() !== draft.original.imagen,
  };
}

function mapMenuItemToLogPayload(item: MenuDataItem) {
  return {
    sourceKey: item.sourceKey ?? buildMenuSourceKey(item),
    id: item.id,
    slug: item.slug,
    hojaOrigen: item.hojaOrigen,
    tipo: item.tipo,
    subgrupo: item.subgrupo ?? '',
    name: item.name,
    description: item.description ?? '',
    precioVenta: item.precioVenta,
    imagen: item.imagen,
    visible: item.visible,
    disponible: item.disponible,
    destacado: item.destacado,
    orden: item.orden,
  };
}

function parsePrice(value: string) {
  const normalized = value.replace(/[^\d]/g, '');

  if (!normalized) {
    return null;
  }

  const parsed = Number(normalized);
  return Number.isFinite(parsed) ? parsed : null;
}

function parseOrder(value: string, fallback: number) {
  const trimmed = value.trim();

  if (!trimmed) {
    return fallback;
  }

  const parsed = Number(trimmed);
  return Number.isFinite(parsed) ? parsed : fallback;
}
