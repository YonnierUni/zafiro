import * as XLSX from 'xlsx';
import type { MenuDataCollection, MenuDataItem } from '../../shared/menu/menu.types';
import {
  buildAdminMenuDrafts,
  buildAdminMenuReadableChanges,
  getAdminMenuCategory,
  getAdminMenuFieldLabel,
  getAdminMenuSubgroup,
  hasAdminMenuDraftChanges,
  parseDraftPrice,
  serializeAdminMenuDraft,
  validateAdminMenuDraft,
} from './adminMenu.mapper';
import type {
  AdminMenuDraftItem,
  AdminMenuEditableFieldKey,
  AdminMenuExcelImportPreview,
  AdminMenuExcelSyncFieldDiff,
  AdminMenuExcelSyncItemDiff,
  AdminMenuExcelSyncReport,
  AdminMenuExcelSyncSheetSummary,
} from './adminMenu.types';

interface ParsedWorkbookRow {
  mappedItem: MenuDataItem | null;
  rawRow: Record<string, unknown>;
}

interface ParsedWorkbookSheet {
  headerRow: string[];
  rows: ParsedWorkbookRow[];
  sheetName: string;
}

interface ParsedWorkbookContext {
  collection: MenuDataCollection;
  sheets: ParsedWorkbookSheet[];
  workbook: XLSX.WorkBook;
}

interface ParsedWorkbookFile {
  context: ParsedWorkbookContext;
  fileName: string;
  modifiedAt: string;
}

interface ExcelSyncReportOptions {
  appCatalogUpdatedAt: string;
  baseExcelModifiedAt: string;
  baseExcelPath: string;
  currentLabel: string;
  fileName: string;
  mode: 'base_compare' | 'import_review';
  referenceLabel: string;
}

export interface AdminMenuExcelSyncResult {
  blob: Blob;
  derivedFileName: string;
  generatedFiles: string[];
  report: AdminMenuExcelSyncReport;
}

const excelEditableFields: AdminMenuEditableFieldKey[] = [
  'name',
  'description',
  'precioVenta',
  'tipo',
  'subgrupo',
  'visible',
  'disponible',
  'destacado',
  'orden',
  'imagen',
];

export async function compareCurrentDraftsWithExcelFile(
  drafts: AdminMenuDraftItem[],
  excelFile: File,
): Promise<AdminMenuExcelSyncReport> {
  const parsedFile = await parseWorkbookFile(excelFile);
  const currentCollection = buildCollectionFromDrafts(drafts);

  return buildExcelSyncReportFromCollections(currentCollection, parsedFile.context.collection, {
    appCatalogUpdatedAt: currentCollection.updatedAt,
    baseExcelModifiedAt: parsedFile.modifiedAt,
    baseExcelPath: parsedFile.fileName === 'ZafiroMenu.xlsx' ? 'data/ZafiroMenu.xlsx' : parsedFile.fileName,
    currentLabel: 'App actual',
    fileName: parsedFile.fileName,
    mode: 'base_compare',
    referenceLabel: 'Excel base',
  });
}

export async function generateDerivedExcelFromCurrentDrafts(
  drafts: AdminMenuDraftItem[],
  excelFile: File,
): Promise<AdminMenuExcelSyncResult> {
  const parsedFile = await parseWorkbookFile(excelFile);
  const currentCollection = buildCollectionFromDrafts(drafts);
  const report = buildExcelSyncReportFromCollections(currentCollection, parsedFile.context.collection, {
    appCatalogUpdatedAt: currentCollection.updatedAt,
    baseExcelModifiedAt: parsedFile.modifiedAt,
    baseExcelPath: parsedFile.fileName === 'ZafiroMenu.xlsx' ? 'data/ZafiroMenu.xlsx' : parsedFile.fileName,
    currentLabel: 'App actual',
    fileName: parsedFile.fileName,
    mode: 'base_compare',
    referenceLabel: 'Excel base',
  });
  const derivedWorkbook = buildDerivedWorkbook(parsedFile.context, drafts);
  const workbookBuffer = XLSX.write(derivedWorkbook, {
    bookType: 'xlsx',
    type: 'array',
  }) as ArrayBuffer;
  const timeTag = buildSafeTimestamp(new Date().toISOString());
  const derivedFileName = `ZafiroMenu-derived-${timeTag}.xlsx`;

  return {
    blob: new Blob([workbookBuffer], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    }),
    derivedFileName,
    generatedFiles: [derivedFileName, `excel-sync-report-${timeTag}.json`],
    report,
  };
}

export async function prepareExcelImportAgainstCurrentDrafts(
  currentDrafts: AdminMenuDraftItem[],
  excelFile: File,
): Promise<AdminMenuExcelImportPreview> {
  const parsedFile = await parseWorkbookFile(excelFile);
  const currentCollection = buildCollectionFromDrafts(currentDrafts);
  const report = buildExcelSyncReportFromCollections(parsedFile.context.collection, currentCollection, {
    appCatalogUpdatedAt: currentCollection.updatedAt,
    baseExcelModifiedAt: parsedFile.modifiedAt,
    baseExcelPath: parsedFile.fileName,
    currentLabel: 'Excel importado',
    fileName: parsedFile.fileName,
    mode: 'import_review',
    referenceLabel: 'Supabase actual',
  });
  const changedDrafts = buildPreparedImportDrafts(currentDrafts, parsedFile.context.collection.items);
  const changedReadableChanges = buildAdminMenuReadableChanges(changedDrafts);
  const invalidDrafts = changedDrafts.filter((draft) => !validateAdminMenuDraft(draft).isValid).length;
  const applicable = changedDrafts.length > 0 && invalidDrafts === 0 && report.status !== 'desynced';

  return {
    applicable,
    blockedItems: invalidDrafts + (report.status === 'desynced' ? report.summary.missingInReference + report.summary.missingInSource : 0),
    changedDrafts,
    changedReadableChanges,
    fileName: parsedFile.fileName,
    report,
    totalChangedItems: changedDrafts.length,
  };
}

export function buildExcelSyncReportFromCollections(
  currentCollection: MenuDataCollection,
  referenceCollection: MenuDataCollection,
  options: ExcelSyncReportOptions,
): AdminMenuExcelSyncReport {
  const currentDrafts = buildAdminMenuDrafts(currentCollection.items);
  const referenceDrafts = buildAdminMenuDrafts(referenceCollection.items);
  const currentDraftMap = new Map(currentDrafts.map((draft) => [buildMatchKeyFromDraft(draft), draft]));
  const referenceDraftMap = new Map(referenceDrafts.map((draft) => [buildMatchKeyFromDraft(draft), draft]));
  const allMatchKeys = Array.from(new Set([...currentDraftMap.keys(), ...referenceDraftMap.keys()])).sort((left, right) =>
    left.localeCompare(right, 'es-CO'),
  );

  const itemDiffs: AdminMenuExcelSyncItemDiff[] = [];
  let missingInCurrent = 0;
  let missingInReference = 0;

  allMatchKeys.forEach((matchKey) => {
    const currentDraft = currentDraftMap.get(matchKey);
    const referenceDraft = referenceDraftMap.get(matchKey);

    if (!currentDraft || !referenceDraft) {
      const source = currentDraft ?? referenceDraft;

      if (!source) {
        return;
      }

      if (!currentDraft) {
        missingInCurrent += 1;
      }

      if (!referenceDraft) {
        missingInReference += 1;
      }

      itemDiffs.push({
        draftKey: currentDraft?.draftKey ?? referenceDraft?.draftKey ?? matchKey,
        id: source.id,
        itemName: source.name,
        itemSlug: source.slug,
        hojaOrigen: source.hojaOrigen,
        tipo: getAdminMenuCategory(source),
        subgrupo: getAdminMenuSubgroup(source),
        status: 'desynced',
        differences: [],
      });
      return;
    }

    const fieldDiffs = buildFieldDiffs(currentDraft, referenceDraft);

    if (!fieldDiffs.length) {
      return;
    }

    itemDiffs.push({
      draftKey: currentDraft.draftKey,
      id: currentDraft.id,
      itemName: currentDraft.name,
      itemSlug: currentDraft.slug,
      hojaOrigen: currentDraft.hojaOrigen,
      tipo: getAdminMenuCategory(currentDraft),
      subgrupo: getAdminMenuSubgroup(currentDraft),
      status: 'pending',
      differences: fieldDiffs,
    });
  });

  const sheetSummaryMap = new Map<string, AdminMenuExcelSyncSheetSummary>();

  itemDiffs.forEach((diff) => {
    const current = sheetSummaryMap.get(diff.hojaOrigen) ?? {
      sheetName: diff.hojaOrigen,
      itemDifferences: 0,
      fieldDifferences: 0,
    };

    current.itemDifferences += 1;
    current.fieldDifferences += diff.differences.length;
    sheetSummaryMap.set(diff.hojaOrigen, current);
  });

  const currentSheetNames = Array.from(new Set(currentDrafts.map((draft) => draft.hojaOrigen))).sort((left, right) =>
    left.localeCompare(right, 'es-CO'),
  );
  const referenceSheetNames = Array.from(new Set(referenceDrafts.map((draft) => draft.hojaOrigen))).sort((left, right) =>
    left.localeCompare(right, 'es-CO'),
  );

  const sheetNamesOnlyInCurrent = currentSheetNames.filter((sheet) => !referenceSheetNames.includes(sheet));
  const sheetNamesOnlyInReference = referenceSheetNames.filter((sheet) => !currentSheetNames.includes(sheet));
  const invalidDrafts = currentDrafts.filter((draft) => !validateAdminMenuDraft(draft).isValid).length;
  const fieldDifferences = itemDiffs.reduce((total, diff) => total + diff.differences.length, 0);
  const status =
    sheetNamesOnlyInCurrent.length || sheetNamesOnlyInReference.length || missingInCurrent || missingInReference
      ? 'desynced'
      : itemDiffs.length
        ? 'pending'
        : 'synced';

  return {
    appCatalogUpdatedAt: options.appCatalogUpdatedAt,
    baseExcelModifiedAt: options.baseExcelModifiedAt,
    baseExcelPath: options.baseExcelPath,
    currentLabel: options.currentLabel,
    fileName: options.fileName,
    generatedAt: new Date().toISOString(),
    items: itemDiffs,
    kind: 'zafiro-admin-menu-excel-sync-report',
    mode: options.mode,
    referenceLabel: options.referenceLabel,
    sheetNamesOnlyInReference,
    sheetNamesOnlyInSource: sheetNamesOnlyInCurrent,
    sheets: Array.from(sheetSummaryMap.values()).sort((left, right) => left.sheetName.localeCompare(right.sheetName, 'es-CO')),
    status,
    summary: {
      fieldDifferences,
      invalidDrafts,
      itemDifferences: itemDiffs.length,
      missingInReference,
      missingInSource: missingInCurrent,
      sheetDifferences: sheetSummaryMap.size + sheetNamesOnlyInCurrent.length + sheetNamesOnlyInReference.length,
    },
    version: 2,
  };
}

function buildPreparedImportDrafts(currentDrafts: AdminMenuDraftItem[], importedItems: MenuDataItem[]) {
  const importedDraftMap = new Map(
    buildAdminMenuDrafts(importedItems).map((draft) => [buildMatchKeyFromDraft(draft), draft]),
  );

  return currentDrafts
    .map((draft) => {
      const importedDraft = importedDraftMap.get(buildMatchKeyFromDraft(draft));

      if (!importedDraft) {
        return null;
      }

      const nextDraft: AdminMenuDraftItem = {
        ...draft,
        name: importedDraft.name,
        description: importedDraft.description,
        precioVenta: importedDraft.precioVenta,
        tipo: importedDraft.tipo,
        subgrupo: importedDraft.subgrupo,
        visible: importedDraft.visible,
        disponible: importedDraft.disponible,
        destacado: importedDraft.destacado,
        orden: importedDraft.orden,
        imagen: importedDraft.imagen,
      };

      return hasAdminMenuDraftChanges(nextDraft) ? nextDraft : null;
    })
    .filter((draft): draft is AdminMenuDraftItem => draft !== null);
}

function buildCollectionFromDrafts(drafts: AdminMenuDraftItem[]): MenuDataCollection {
  const items = drafts.map((draft) => {
    const serialized = serializeAdminMenuDraft(draft);

    return {
      ...draft.original,
      name: serialized.name,
      description: serialized.description,
      tipo: serialized.tipo,
      subgrupo: serialized.subgrupo,
      precioVenta: serialized.precioVenta,
      imagen: serialized.imagen,
      visible: serialized.visible,
      disponible: serialized.disponible,
      destacado: serialized.destacado,
      orden: serialized.orden,
    } satisfies MenuDataItem;
  });

  return {
    count: items.length,
    items,
    updatedAt: new Date().toISOString(),
  };
}

function buildDerivedWorkbook(context: ParsedWorkbookContext, drafts: AdminMenuDraftItem[]) {
  const workbook = XLSX.read(XLSX.write(context.workbook, { bookType: 'xlsx', type: 'array' }), { type: 'array' });
  const currentDraftMap = new Map(drafts.map((draft) => [buildMatchKeyFromDraft(draft), draft]));

  context.sheets.forEach((sheetContext) => {
    const headerKeyMap = buildHeaderKeyMap(sheetContext.headerRow);
    const nextRows = sheetContext.rows.map((row) => {
      if (!row.mappedItem) {
        return row.rawRow;
      }

      const currentDraft = currentDraftMap.get(buildMatchKeyFromMenuItem(row.mappedItem));

      if (!currentDraft) {
        return row.rawRow;
      }

      return applyDraftToRawRow(row.rawRow, currentDraft, headerKeyMap);
    });

    const nextSheet = XLSX.utils.json_to_sheet(nextRows, {
      header: sheetContext.headerRow,
      skipHeader: false,
    });

    workbook.Sheets[sheetContext.sheetName] = nextSheet;
  });

  return workbook;
}

async function parseWorkbookFile(file: File): Promise<ParsedWorkbookFile> {
  const buffer = await file.arrayBuffer();
  const workbook = XLSX.read(buffer, { type: 'array' });

  return {
    context: parseWorkbookContext(workbook),
    fileName: file.name,
    modifiedAt: new Date(file.lastModified).toISOString(),
  };
}

function parseWorkbookContext(workbook: XLSX.WorkBook): ParsedWorkbookContext {
  const items: MenuDataItem[] = [];
  let runningIndex = 0;
  const sheets = workbook.SheetNames.map((sheetName) => {
    const sheet = workbook.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json<Record<string, unknown>>(sheet, {
      defval: '',
      raw: true,
    });
    const headerRows = XLSX.utils.sheet_to_json<(string | number)[]>(sheet, {
      header: 1,
      raw: true,
      defval: '',
    });
    const headerRow = (headerRows[0] ?? []).map((value) => String(value ?? ''));

    const parsedRows = rows.map((rawRow, index) => {
      const mappedItem = mapWorkbookRow(rawRow, runningIndex + index, sheetName);

      if (mappedItem) {
        items.push(mappedItem);
      }

      return {
        rawRow: { ...rawRow },
        mappedItem,
      };
    });

    runningIndex += parsedRows.filter((row) => row.mappedItem).length;

    return {
      sheetName,
      headerRow,
      rows: parsedRows,
    };
  });

  return {
    workbook,
    sheets,
    collection: {
      updatedAt: new Date().toISOString(),
      count: items.length,
      items,
    },
  };
}

function applyDraftToRawRow(
  rawRow: Record<string, unknown>,
  draft: AdminMenuDraftItem,
  headerKeyMap: Map<string, string>,
) {
  const nextRow = { ...rawRow };
  const serialized = serializeAdminMenuDraft(draft);

  setHeaderValue(nextRow, headerKeyMap, 'name', serialized.name);
  setHeaderValue(nextRow, headerKeyMap, 'description', serialized.description);
  setHeaderValue(nextRow, headerKeyMap, 'tipo', serialized.tipo);
  setHeaderValue(nextRow, headerKeyMap, 'subgrupo', serialized.subgrupo);
  setHeaderValue(nextRow, headerKeyMap, 'precioventa', serialized.precioVenta === null ? '' : String(serialized.precioVenta));
  setHeaderValue(nextRow, headerKeyMap, 'orden', String(serialized.orden));
  setHeaderValue(nextRow, headerKeyMap, 'imagen', serialized.imagen);
  setHeaderValue(nextRow, headerKeyMap, 'visible', serialized.visible ? 'Si' : 'No');
  setHeaderValue(nextRow, headerKeyMap, 'disponible', serialized.disponible ? 'Si' : 'No');
  setHeaderValue(nextRow, headerKeyMap, 'destacado', serialized.destacado ? 'Si' : 'No');

  return nextRow;
}

function buildFieldDiffs(currentDraft: AdminMenuDraftItem, referenceDraft: AdminMenuDraftItem) {
  const currentSerialized = serializeAdminMenuDraft(currentDraft);
  const referenceSerialized = serializeAdminMenuDraft(referenceDraft);

  return excelEditableFields.flatMap<AdminMenuExcelSyncFieldDiff>((field) => {
    const before = formatFieldValue(field, referenceSerialized[field]);
    const after = formatFieldValue(field, currentSerialized[field]);

    if (before === after) {
      return [];
    }

    return [
      {
        field,
        fieldLabel: getAdminMenuFieldLabel(field),
        before,
        after,
      },
    ];
  });
}

function buildHeaderKeyMap(headerRow: string[]) {
  const map = new Map<string, string>();

  headerRow.forEach((header) => {
    map.set(normalizeHeader(header), header);
  });

  return map;
}

function setHeaderValue(
  row: Record<string, unknown>,
  headerKeyMap: Map<string, string>,
  normalizedHeader: string,
  value: string,
) {
  const actualHeader = headerKeyMap.get(normalizedHeader);

  if (actualHeader) {
    row[actualHeader] = value;
  }
}

function formatFieldValue(field: AdminMenuEditableFieldKey, value: string | number | boolean | null) {
  if (field === 'visible' || field === 'disponible' || field === 'destacado') {
    return value === true ? 'Si' : value === false ? 'No' : '';
  }

  if (value === null || value === undefined) {
    return '';
  }

  return String(value);
}

function buildSafeTimestamp(value: string) {
  return value.replace(/[:.]/g, '-');
}

function buildMatchKeyFromDraft(draft: AdminMenuDraftItem) {
  return `${normalizeText(draft.hojaOrigen).toLowerCase()}::${String(draft.id).trim()}`;
}

function buildMatchKeyFromMenuItem(item: MenuDataItem) {
  return `${normalizeText(item.hojaOrigen).toLowerCase()}::${String(item.id).trim()}`;
}

function normalizeHeader(header = '') {
  return String(header)
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/\s+/g, ' ')
    .replace(/[^\w\s]/g, '');
}

function normalizeText(value: unknown = '') {
  return String(value ?? '').trim();
}

function toSlug(value: unknown = '') {
  return String(value)
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function normalizeImagePath(value: unknown = '') {
  const image = normalizeText(value);
  if (!image) {
    return '';
  }

  return image.replace(/^\/+/, '').replace(/^public\/+/i, '').replace(/\\/g, '/');
}

function toBoolean(value: unknown, defaultValue = true) {
  const normalized = normalizeText(value).toLowerCase();

  if (!normalized) {
    return defaultValue;
  }

  if (['si', 'sí', 'true', '1', 'yes', 'y'].includes(normalized)) {
    return true;
  }

  if (['no', 'false', '0', 'n'].includes(normalized)) {
    return false;
  }

  return defaultValue;
}

function toInteger(value: unknown, fallback = 0) {
  if (value === null || value === undefined || value === '') {
    return fallback;
  }

  const parsed = Number(String(value).trim());
  return Number.isFinite(parsed) ? parsed : fallback;
}

function normalizeSheetType(sheetName: unknown = '') {
  const safeSheetName = String(sheetName ?? '');
  const normalized = safeSheetName
    .trim()
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');

  if (normalized.includes('coctel')) {
    return 'cocteles';
  }

  if (normalized.includes('bebida')) {
    return 'bebidas';
  }

  if (normalized.includes('comida')) {
    return 'comida';
  }

  return toSlug(safeSheetName) || 'otros';
}

function isEmptyRow(row: Record<string, unknown>) {
  return Object.values(row).every((value) => normalizeText(value) === '');
}

function mapWorkbookRow(rawRow: Record<string, unknown>, index: number, sheetName: string): MenuDataItem | null {
  const row: Record<string, unknown> = {};

  Object.entries(rawRow).forEach(([key, value]) => {
    row[normalizeHeader(key)] = value;
  });

  if (isEmptyRow(row)) {
    return null;
  }

  const name = normalizeText(row['name']);
  if (!name) {
    return null;
  }

  const explicitType = normalizeText(row['tipo']);
  const tipo = explicitType || normalizeSheetType(sheetName);
  const subgrupo = normalizeText(row['subgrupo']);
  const rawId = normalizeText(row['no']);
  const numericId = toInteger(rawId, index + 1);
  const orden = toInteger(row['orden'], numericId);

  return {
    id: numericId,
    orden,
    slug: toSlug(name),
    name,
    description: normalizeText(row['description']),
    tipo,
    subgrupo,
    ingredientes: normalizeText(row['ingredientes']),
    preparacion: normalizeText(row['preparacion']),
    emplatado: normalizeText(row['emplatado']),
    precioVenta: parseDraftPrice(String(row['precioventa'] ?? '')),
    imagen: normalizeImagePath(row['imagen']),
    hojaOrigen: sheetName,
    visible: toBoolean(row['visible'], true),
    disponible: toBoolean(row['disponible'], true),
    destacado: toBoolean(row['destacado'], false),
  };
}
