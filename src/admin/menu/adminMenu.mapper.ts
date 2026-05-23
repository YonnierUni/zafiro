import {
  formatMenuPrice,
  getMenuSubgroupLabel,
  getOrderedMenuCategories,
  normalizeMenuCategory,
  resolveMenuImageSrc,
  sanitizeMenuText,
  sortMenuItemsByOrder,
} from '../../models/menuData';
import type { MenuDataItem } from '../../shared/menu/menu.types';
import type {
  AdminMenuApplyFieldChange,
  AdminMenuApplyItem,
  AdminMenuApplyPayload,
  AdminMenuApplyPayloadSummary,
  AdminMenuDraftItem,
  AdminMenuFilterState,
  AdminMenuReadableChange,
  AdminMenuSnapshotImportResult,
  AdminMenuSnapshot,
  AdminMenuSnapshotDraftEntry,
  AdminMenuSnapshotSummary,
  AdminMenuDraftValidation,
  AdminMenuEditableFieldKey,
  AdminMenuSerializedItem,
} from './adminMenu.types';

export function buildAdminMenuDrafts(items: MenuDataItem[]) {
  const seenKeys = new Map<string, number>();

  return sortMenuItemsByOrder(items).map((item) => {
    const baseKey = buildAdminMenuDraftKey(item);
    const nextOccurrence = (seenKeys.get(baseKey) ?? 0) + 1;
    seenKeys.set(baseKey, nextOccurrence);

    const draftKey = nextOccurrence === 1 ? baseKey : `${baseKey}::${nextOccurrence}`;
    return mapMenuItemToDraft(item, draftKey);
  });
}

export function mapMenuItemToDraft(item: MenuDataItem, draftKey = buildAdminMenuDraftKey(item)): AdminMenuDraftItem {
  return {
    draftKey,
    id: item.id,
    slug: item.slug,
    hojaOrigen: sanitizeMenuText(item.hojaOrigen ?? ''),
    name: sanitizeMenuText(item.name),
    description: sanitizeMenuText(item.description ?? ''),
    precioVenta: item.precioVenta === null ? '' : String(item.precioVenta),
    tipo: sanitizeMenuText(item.tipo),
    subgrupo: sanitizeMenuText(item.subgrupo ?? ''),
    visible: item.visible === true,
    disponible: item.disponible !== false,
    destacado: item.destacado === true,
    orden: String(item.orden ?? ''),
    imagen: sanitizeMenuText(item.imagen ?? ''),
    original: item,
  };
}

export function updateAdminMenuDraftField<K extends keyof AdminMenuDraftItem>(
  item: AdminMenuDraftItem,
  field: K,
  value: AdminMenuDraftItem[K],
) {
  return {
    ...item,
    [field]: value,
  };
}

export function getAdminMenuDraftImageSrc(item: AdminMenuDraftItem) {
  return resolveMenuImageSrc(item.imagen);
}

export function getAdminMenuDraftPriceLabel(item: AdminMenuDraftItem) {
  const numericPrice = parseDraftPrice(item.precioVenta);
  return formatMenuPrice(numericPrice);
}

export function parseDraftPrice(value: string) {
  const normalized = sanitizeMenuText(value).replace(/[^\d]/g, '');

  if (!normalized) {
    return null;
  }

  const parsed = Number(normalized);
  return Number.isFinite(parsed) ? parsed : null;
}

export function parseDraftOrder(value: string, fallback: number) {
  const normalized = sanitizeMenuText(value);

  if (!normalized) {
    return fallback;
  }

  const parsed = Number(normalized);
  return Number.isFinite(parsed) ? parsed : fallback;
}

export function serializeAdminMenuDraft(item: AdminMenuDraftItem): AdminMenuSerializedItem {
  return {
    id: item.id,
    slug: item.slug,
    hojaOrigen: sanitizeMenuText(item.hojaOrigen),
    name: sanitizeMenuText(item.name),
    description: sanitizeMenuText(item.description),
    tipo: sanitizeMenuText(item.tipo),
    subgrupo: sanitizeMenuText(item.subgrupo),
    orden: parseDraftOrder(item.orden, item.original.orden),
    precioVenta: parseDraftPrice(item.precioVenta),
    imagen: sanitizeMenuText(item.imagen),
    visible: item.visible,
    disponible: item.disponible,
    destacado: item.destacado,
  };
}

export function validateAdminMenuDraft(item: AdminMenuDraftItem): AdminMenuDraftValidation {
  const errors: Partial<Record<AdminMenuEditableFieldKey, string>> = {};
  const name = sanitizeMenuText(item.name);
  const tipo = sanitizeMenuText(item.tipo);
  const subgrupo = sanitizeMenuText(item.subgrupo);
  const orden = sanitizeMenuText(item.orden);
  const imagen = sanitizeMenuText(item.imagen);

  if (!name) {
    errors.name = 'El nombre no puede quedar vacío.';
  }

  if (!tipo) {
    errors.tipo = 'La categoría principal es obligatoria.';
  }

  if (!subgrupo && !sanitizeMenuText(item.hojaOrigen)) {
    errors.subgrupo = 'Define un subgrupo o deja una hoja de origen que actúe como respaldo.';
  }

  if (!orden || !/^\d+$/.test(orden)) {
    errors.orden = 'El orden debe ser numérico y válido.';
  }

  if (sanitizeMenuText(item.precioVenta) && parseDraftPrice(item.precioVenta) === null) {
    errors.precioVenta = 'El precio debe ser numérico o dejarse vacío.';
  }

  if (imagen && !isValidImageReference(imagen)) {
    errors.imagen = 'La ruta de imagen debe ser relativa o una URL válida con extensión de imagen.';
  }

  return {
    errors,
    isValid: Object.keys(errors).length === 0,
  };
}

export function getAdminMenuChangedFields(item: AdminMenuDraftItem): AdminMenuEditableFieldKey[] {
  const changedFields: AdminMenuEditableFieldKey[] = [];

  const originalValues: Record<AdminMenuEditableFieldKey, string | boolean> = {
    name: sanitizeMenuText(item.original.name),
    description: sanitizeMenuText(item.original.description ?? ''),
    precioVenta: item.original.precioVenta === null ? '' : String(item.original.precioVenta),
    tipo: sanitizeMenuText(item.original.tipo),
    subgrupo: sanitizeMenuText(item.original.subgrupo ?? ''),
    visible: item.original.visible === true,
    disponible: item.original.disponible !== false,
    destacado: item.original.destacado === true,
    orden: String(item.original.orden ?? ''),
    imagen: sanitizeMenuText(item.original.imagen ?? ''),
  };

  (Object.keys(originalValues) as AdminMenuEditableFieldKey[]).forEach((field) => {
    if (item[field] !== originalValues[field]) {
      changedFields.push(field);
    }
  });

  return changedFields;
}

export function hasAdminMenuDraftChanges(item: AdminMenuDraftItem) {
  return getAdminMenuChangedFields(item).length > 0;
}

export function buildAdminMenuReadableChanges(items: AdminMenuDraftItem[]): AdminMenuReadableChange[] {
  return items.flatMap((item) => {
    const originalValues: Record<AdminMenuEditableFieldKey, string | boolean> = {
      name: sanitizeMenuText(item.original.name),
      description: sanitizeMenuText(item.original.description ?? ''),
      precioVenta: item.original.precioVenta === null ? '' : String(item.original.precioVenta),
      tipo: sanitizeMenuText(item.original.tipo),
      subgrupo: sanitizeMenuText(item.original.subgrupo ?? ''),
      visible: item.original.visible === true,
      disponible: item.original.disponible !== false,
      destacado: item.original.destacado === true,
      orden: String(item.original.orden ?? ''),
      imagen: sanitizeMenuText(item.original.imagen ?? ''),
    };

    return getAdminMenuChangedFields(item).map((field) => ({
      draftKey: item.draftKey,
      field,
      fieldLabel: getAdminMenuFieldLabel(field),
      itemName: sanitizeMenuText(item.name || item.original.name),
      itemSlug: sanitizeMenuText(item.slug),
      before: formatAdminMenuFieldValue(field, originalValues[field]),
      after: formatAdminMenuFieldValue(field, item[field]),
    }));
  });
}

export function buildAdminMenuApplyPayload(items: AdminMenuDraftItem[]): AdminMenuApplyPayload {
  const changedItems = items.filter(hasAdminMenuDraftChanges);
  const applyItems = changedItems.map<AdminMenuApplyItem>((item) => {
    const validation = validateAdminMenuDraft(item);

    return {
      draftKey: item.draftKey,
      id: item.id,
      itemName: sanitizeMenuText(item.name || item.original.name),
      itemSlug: sanitizeMenuText(item.slug),
      status: validation.isValid ? 'ready' : 'blocked',
      validationErrors: validation.errors,
      serializedItem: serializeAdminMenuDraft(item),
      changedFields: buildApplyFieldChanges(item),
    };
  });

  const summary = buildAdminMenuApplyPayloadSummary(applyItems);

  return {
    kind: 'zafiro-admin-menu-apply-payload',
    version: 1,
    generatedAt: new Date().toISOString(),
    summary,
    items: applyItems,
  };
}

export function buildCategoryOptions(items: AdminMenuDraftItem[]) {
  const categories = Array.from(new Set(items.map((item) => normalizeMenuCategory(item.tipo))));
  const preferredOrder = getOrderedMenuCategories(
    items.map((item) => ({
      ...item.original,
      tipo: item.tipo,
    })),
  ).filter((category) => categories.includes(category));

  return preferredOrder.map((category) => ({
    value: category,
    label: humanizeAdminLabel(category),
  }));
}

export function buildSubgroupOptions(items: AdminMenuDraftItem[], selectedCategory: string) {
  const filteredItems =
    selectedCategory === 'all'
      ? items
      : items.filter((item) => normalizeMenuCategory(item.tipo) === normalizeMenuCategory(selectedCategory));

  return Array.from(new Set(filteredItems.map((item) => getAdminMenuSubgroup(item))))
    .sort((left, right) => left.localeCompare(right, 'es-CO'))
    .map((subgroup) => ({
      value: subgroup,
      label: subgroup,
    }));
}

export function getAdminMenuSubgroup(item: AdminMenuDraftItem) {
  const explicitSubgroup = sanitizeMenuText(item.subgrupo);

  if (explicitSubgroup) {
    return explicitSubgroup;
  }

  return getMenuSubgroupLabel(item.original);
}

export function getAdminMenuCategory(item: AdminMenuDraftItem) {
  return normalizeMenuCategory(item.tipo);
}

export function serializeChangedAdminMenuDrafts(items: AdminMenuDraftItem[]) {
  return items.filter(hasAdminMenuDraftChanges).map(serializeAdminMenuDraft);
}

export function serializeAllAdminMenuDrafts(items: AdminMenuDraftItem[]) {
  return items.map(serializeAdminMenuDraft);
}

export function buildAdminMenuSnapshot(
  items: AdminMenuDraftItem[],
  filters: AdminMenuFilterState,
  selectedDraftKey: string | null,
): AdminMenuSnapshot {
  const changedItems = serializeChangedAdminMenuDrafts(items);
  const changedDrafts = items
    .filter(hasAdminMenuDraftChanges)
    .map((item): AdminMenuSnapshotDraftEntry => ({
      draftKey: item.draftKey,
      item: serializeAdminMenuDraft(item),
    }));
  const summary = buildAdminMenuSnapshotSummary(items, changedItems.length);

  return {
    kind: 'zafiro-admin-menu-snapshot',
    version: 2,
    generatedAt: new Date().toISOString(),
    selectedDraftKey,
    filters: { ...filters },
    summary,
    changedItems,
    changedDrafts,
  };
}

export function buildAdminMenuSnapshotSummary(
  items: AdminMenuDraftItem[],
  changedItemsCount = serializeChangedAdminMenuDrafts(items).length,
): AdminMenuSnapshotSummary {
  const invalidItems = items.filter((item) => !validateAdminMenuDraft(item).isValid).length;

  return {
    totalItems: items.length,
    editedItems: changedItemsCount,
    invalidItems,
    payloadReady: changedItemsCount > 0 && invalidItems === 0,
  };
}

export function parseAdminMenuSnapshot(value: unknown): AdminMenuSnapshot {
  if (!isRecord(value)) {
    throw new Error('El archivo no contiene un objeto JSON vÃ¡lido.');
  }

  if (value.kind !== 'zafiro-admin-menu-snapshot') {
    throw new Error('El archivo no corresponde a un snapshot del editor admin de ZAFIRO.');
  }

  if (value.version !== 1 && value.version !== 2) {
    throw new Error('La versiÃ³n del snapshot no es compatible.');
  }

  if (typeof value.generatedAt !== 'string' || !value.generatedAt.trim()) {
    throw new Error('El snapshot no incluye una fecha de generaciÃ³n vÃ¡lida.');
  }

  if (!isSnapshotFilters(value.filters)) {
    throw new Error('El snapshot no incluye filtros con el formato esperado.');
  }

  if (!isSnapshotSummary(value.summary)) {
    throw new Error('El snapshot no incluye un resumen vÃ¡lido.');
  }

  if (!Array.isArray(value.changedItems) || !value.changedItems.every(isSerializedMenuItem)) {
    throw new Error('El snapshot no incluye cambios serializados con el formato esperado.');
  }

  if (
    value.changedDrafts !== undefined &&
    (!Array.isArray(value.changedDrafts) || !value.changedDrafts.every(isSnapshotDraftEntry))
  ) {
    throw new Error('El snapshot incluye drafts con un formato no compatible.');
  }

  if (value.selectedDraftKey !== null && typeof value.selectedDraftKey !== 'string') {
    throw new Error('La selecciÃ³n activa del snapshot no tiene un formato vÃ¡lido.');
  }

  return value as unknown as AdminMenuSnapshot;
}

export function importAdminMenuSnapshot(
  items: MenuDataItem[],
  value: unknown,
): AdminMenuSnapshotImportResult {
  const snapshot = parseAdminMenuSnapshot(value);
  const baseDrafts = buildAdminMenuDrafts(items);
  const nextDrafts = [...baseDrafts];
  const snapshotEntries = getSnapshotEntries(snapshot);
  let restoredCount = 0;
  let missingCount = 0;

  snapshotEntries.forEach((entry) => {
    const draftIndex = findDraftIndexForSnapshotEntry(nextDrafts, entry);

    if (draftIndex === -1) {
      missingCount += 1;
      return;
    }

    nextDrafts[draftIndex] = applySerializedItemToDraft(nextDrafts[draftIndex], entry.item);
    restoredCount += 1;
  });

  const selectedDraftKey =
    snapshot.selectedDraftKey && nextDrafts.some((item) => item.draftKey === snapshot.selectedDraftKey)
      ? snapshot.selectedDraftKey
      : nextDrafts[0]?.draftKey ?? null;

  return {
    snapshot,
    drafts: nextDrafts,
    filters: snapshot.filters,
    restoredCount,
    missingCount,
    selectedDraftKey,
  };
}

export function humanizeAdminLabel(value: string) {
  const cleanValue = sanitizeMenuText(value)
    .replace(/[-_]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim();

  if (!cleanValue) {
    return 'Otros';
  }

  return cleanValue.replace(/\b\w/g, (match) => match.toUpperCase());
}

export function getAdminMenuFieldLabel(field: AdminMenuEditableFieldKey) {
  const labels: Record<AdminMenuEditableFieldKey, string> = {
    name: 'Nombre',
    description: 'Descripcion',
    precioVenta: 'Precio de venta',
    tipo: 'Categoria principal',
    subgrupo: 'Subgrupo',
    visible: 'Visible',
    disponible: 'Disponible',
    destacado: 'Destacado',
    orden: 'Orden',
    imagen: 'Imagen',
  };

  return labels[field];
}

export function buildAdminMenuApplyPayloadSummary(items: AdminMenuApplyItem[]): AdminMenuApplyPayloadSummary {
  const readyItems = items.filter((item) => item.status === 'ready').length;
  const blockedItems = items.length - readyItems;

  return {
    totalChangedItems: items.length,
    readyItems,
    blockedItems,
    applicable: items.length > 0 && blockedItems === 0,
  };
}

function buildAdminMenuDraftKey(item: MenuDataItem) {
  const sheet = sanitizeMenuText(item.hojaOrigen ?? '').toLowerCase() || 'sin-hoja';
  const slug = sanitizeMenuText(item.slug).toLowerCase() || 'sin-slug';
  const category = sanitizeMenuText(item.tipo).toLowerCase() || 'sin-tipo';

  return `${sheet}::${category}::${slug}::${item.id}`;
}

function isValidImageReference(value: string) {
  if (/^https?:\/\/.+\.(png|jpe?g|webp|gif|svg)$/i.test(value)) {
    return true;
  }

  return /^(?!\/)(?!.*\s).+\.(png|jpe?g|webp|gif|svg)$/i.test(value);
}

function buildApplyFieldChanges(item: AdminMenuDraftItem): AdminMenuApplyFieldChange[] {
  const originalValues: Record<AdminMenuEditableFieldKey, string | boolean> = {
    name: sanitizeMenuText(item.original.name),
    description: sanitizeMenuText(item.original.description ?? ''),
    precioVenta: item.original.precioVenta === null ? '' : String(item.original.precioVenta),
    tipo: sanitizeMenuText(item.original.tipo),
    subgrupo: sanitizeMenuText(item.original.subgrupo ?? ''),
    visible: item.original.visible === true,
    disponible: item.original.disponible !== false,
    destacado: item.original.destacado === true,
    orden: String(item.original.orden ?? ''),
    imagen: sanitizeMenuText(item.original.imagen ?? ''),
  };

  return getAdminMenuChangedFields(item).map((field) => ({
    field,
    fieldLabel: getAdminMenuFieldLabel(field),
    before: formatAdminMenuFieldValue(field, originalValues[field]),
    after: formatAdminMenuFieldValue(field, item[field]),
  }));
}

function formatAdminMenuFieldValue(field: AdminMenuEditableFieldKey, value: string | boolean) {
  if (typeof value === 'boolean') {
    return value ? 'Si' : 'No';
  }

  if (field === 'precioVenta') {
    const parsed = parseDraftPrice(value);
    return parsed === null ? 'Sin precio' : formatMenuPrice(parsed);
  }

  const text = sanitizeMenuText(value);
  return text || 'Vacio';
}

function getSnapshotEntries(snapshot: AdminMenuSnapshot): AdminMenuSnapshotDraftEntry[] {
  if (snapshot.changedDrafts?.length) {
    return snapshot.changedDrafts;
  }

  return snapshot.changedItems.map((item) => ({
    draftKey: buildSnapshotEntryFallbackKey(item),
    item,
  }));
}

function applySerializedItemToDraft(item: AdminMenuDraftItem, serialized: AdminMenuSerializedItem): AdminMenuDraftItem {
  return {
    ...item,
    name: sanitizeMenuText(serialized.name),
    description: sanitizeMenuText(serialized.description ?? ''),
    precioVenta: serialized.precioVenta === null ? '' : String(serialized.precioVenta),
    tipo: sanitizeMenuText(serialized.tipo),
    subgrupo: sanitizeMenuText(serialized.subgrupo ?? ''),
    visible: serialized.visible === true,
    disponible: serialized.disponible !== false,
    destacado: serialized.destacado === true,
    orden: String(serialized.orden ?? ''),
    imagen: sanitizeMenuText(serialized.imagen ?? ''),
  };
}

function findDraftIndexForSnapshotEntry(
  drafts: AdminMenuDraftItem[],
  entry: AdminMenuSnapshotDraftEntry,
) {
  const directIndex = drafts.findIndex((item) => item.draftKey === entry.draftKey);

  if (directIndex !== -1) {
    return directIndex;
  }

  const fallbackKey = buildSnapshotEntryFallbackKey(entry.item);
  return drafts.findIndex((item) => buildSnapshotEntryFallbackKey(item.original) === fallbackKey);
}

function buildSnapshotEntryFallbackKey(
  item:
    | Pick<MenuDataItem, 'hojaOrigen' | 'id' | 'slug' | 'tipo'>
    | Pick<AdminMenuSerializedItem, 'hojaOrigen' | 'id' | 'slug' | 'tipo'>,
) {
  const sheet = sanitizeMenuText(item.hojaOrigen ?? '').toLowerCase() || 'sin-hoja';
  const slug = sanitizeMenuText(item.slug).toLowerCase() || 'sin-slug';
  const category = sanitizeMenuText(item.tipo).toLowerCase() || 'sin-tipo';

  return `${sheet}::${category}::${slug}::${item.id}`;
}

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null;
}

function isSnapshotFilters(value: unknown): value is AdminMenuFilterState {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.search === 'string' &&
    typeof value.status === 'string' &&
    typeof value.category === 'string' &&
    typeof value.subgroup === 'string'
  );
}

function isSnapshotSummary(value: unknown): value is AdminMenuSnapshotSummary {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.totalItems === 'number' &&
    typeof value.editedItems === 'number' &&
    typeof value.invalidItems === 'number' &&
    typeof value.payloadReady === 'boolean'
  );
}

function isSerializedMenuItem(value: unknown): value is AdminMenuSerializedItem {
  if (!isRecord(value)) {
    return false;
  }

  return (
    typeof value.id === 'number' &&
    typeof value.slug === 'string' &&
    typeof value.hojaOrigen === 'string' &&
    typeof value.name === 'string' &&
    typeof value.description === 'string' &&
    typeof value.tipo === 'string' &&
    typeof value.subgrupo === 'string' &&
    typeof value.orden === 'number' &&
    (typeof value.precioVenta === 'number' || value.precioVenta === null) &&
    typeof value.imagen === 'string' &&
    typeof value.visible === 'boolean' &&
    typeof value.disponible === 'boolean' &&
    typeof value.destacado === 'boolean'
  );
}

function isSnapshotDraftEntry(value: unknown): value is AdminMenuSnapshotDraftEntry {
  if (!isRecord(value)) {
    return false;
  }

  return typeof value.draftKey === 'string' && isSerializedMenuItem(value.item);
}
