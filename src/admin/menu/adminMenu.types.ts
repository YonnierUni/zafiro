import type { MenuDataCollection, MenuDataItem } from '../../shared/menu/menu.types';

export type AdminMenuStatusFilter =
  | 'all'
  | 'visible'
  | 'hidden'
  | 'available'
  | 'unavailable'
  | 'featured'
  | 'edited';

export interface AdminMenuEditableFields {
  name: string;
  description: string;
  precioVenta: string;
  tipo: string;
  subgrupo: string;
  visible: boolean;
  disponible: boolean;
  destacado: boolean;
  orden: string;
  imagen: string;
}

export type AdminMenuEditableFieldKey = keyof AdminMenuEditableFields;

export interface AdminMenuDraftItem extends AdminMenuEditableFields {
  draftKey: string;
  id: number;
  slug: string;
  hojaOrigen: string;
  original: MenuDataItem;
}

export interface AdminMenuFilterState {
  search: string;
  status: AdminMenuStatusFilter;
  category: string;
  subgroup: string;
}

export interface AdminMenuDraftValidation {
  errors: Partial<Record<AdminMenuEditableFieldKey, string>>;
  isValid: boolean;
}

export interface AdminMenuSerializedItem {
  description: string;
  disponible: boolean;
  destacado: boolean;
  hojaOrigen: string;
  id: number;
  imagen: string;
  name: string;
  orden: number;
  precioVenta: number | null;
  slug: string;
  subgrupo: string;
  tipo: string;
  visible: boolean;
}

export interface AdminMenuSnapshotSummary {
  editedItems: number;
  invalidItems: number;
  payloadReady: boolean;
  totalItems: number;
}

export interface AdminMenuSnapshotDraftEntry {
  draftKey: string;
  item: AdminMenuSerializedItem;
}

export interface AdminMenuSnapshot {
  changedItems: AdminMenuSerializedItem[];
  changedDrafts?: AdminMenuSnapshotDraftEntry[];
  filters: AdminMenuFilterState;
  generatedAt: string;
  kind: 'zafiro-admin-menu-snapshot';
  selectedDraftKey: string | null;
  summary: AdminMenuSnapshotSummary;
  version: 1 | 2;
}

export interface AdminMenuSnapshotImportResult {
  drafts: AdminMenuDraftItem[];
  filters: AdminMenuFilterState;
  missingCount: number;
  restoredCount: number;
  selectedDraftKey: string | null;
  snapshot: AdminMenuSnapshot;
}

export interface AdminMenuReadableChange {
  after: string;
  before: string;
  draftKey: string;
  field: AdminMenuEditableFieldKey;
  fieldLabel: string;
  itemName: string;
  itemSlug: string;
}

export interface AdminMenuSnapshotHistoryEntry {
  changes: AdminMenuReadableChange[];
  createdAt: string;
  fileName: string | null;
  id: string;
  missingCount?: number;
  restoredCount?: number;
  snapshot: AdminMenuSnapshot;
  source: 'saved' | 'imported';
}

export interface AdminMenuApplyFieldChange {
  after: string;
  before: string;
  field: AdminMenuEditableFieldKey;
  fieldLabel: string;
}

export interface AdminMenuApplyItem {
  changedFields: AdminMenuApplyFieldChange[];
  draftKey: string;
  id: number;
  itemName: string;
  itemSlug: string;
  serializedItem: AdminMenuSerializedItem;
  status: 'ready' | 'blocked';
  validationErrors: Partial<Record<AdminMenuEditableFieldKey, string>>;
}

export interface AdminMenuApplyPayloadSummary {
  applicable: boolean;
  blockedItems: number;
  readyItems: number;
  totalChangedItems: number;
}

export interface AdminMenuApplyPayload {
  generatedAt: string;
  items: AdminMenuApplyItem[];
  kind: 'zafiro-admin-menu-apply-payload';
  summary: AdminMenuApplyPayloadSummary;
  version: 1;
}

export interface AdminMenuExcelChangeRow {
  after: string;
  before: string;
  draftKey: string;
  field: AdminMenuEditableFieldKey;
  fieldLabel: string;
  hojaOrigen: string;
  id: number;
  itemName: string;
  itemSlug: string;
  status: 'ready' | 'blocked';
  subgrupo: string;
  tipo: string;
}

export interface AdminMenuCatalogApplyArtifactSummary {
  applicable: boolean;
  appliedItems: number;
  blockedItems: number;
  changedFields: number;
  totalChangedItems: number;
}

export interface AdminMenuCatalogApplyArtifact {
  afterCatalog: MenuDataCollection;
  applyPayload: AdminMenuApplyPayload;
  beforeCatalog: MenuDataCollection;
  excelRows: AdminMenuExcelChangeRow[];
  generatedAt: string;
  kind: 'zafiro-admin-menu-catalog-apply-artifact';
  summary: AdminMenuCatalogApplyArtifactSummary;
  version: 1;
}

export interface AdminMenuApplyHistoryEntry {
  artifact: AdminMenuCatalogApplyArtifact;
  createdAt: string;
  fileTargets: string[];
  id: string;
  source: 'applied';
}

export interface AdminMenuExcelSyncFieldDiff {
  after: string;
  before: string;
  field: AdminMenuEditableFieldKey;
  fieldLabel: string;
}

export interface AdminMenuExcelSyncItemDiff {
  differences: AdminMenuExcelSyncFieldDiff[];
  draftKey: string;
  hojaOrigen: string;
  id: number;
  itemName: string;
  itemSlug: string;
  status: 'pending' | 'desynced';
  subgrupo: string;
  tipo: string;
}

export interface AdminMenuExcelSyncSheetSummary {
  fieldDifferences: number;
  itemDifferences: number;
  sheetName: string;
}

export interface AdminMenuExcelSyncSummary {
  fieldDifferences: number;
  invalidDrafts: number;
  itemDifferences: number;
  missingInReference: number;
  missingInSource: number;
  sheetDifferences: number;
}

export interface AdminMenuExcelSyncReport {
  appCatalogUpdatedAt: string;
  baseExcelModifiedAt: string;
  baseExcelPath: string;
  currentLabel: string;
  fileName: string;
  generatedAt: string;
  items: AdminMenuExcelSyncItemDiff[];
  kind: 'zafiro-admin-menu-excel-sync-report';
  mode: 'base_compare' | 'import_review';
  referenceLabel: string;
  sheetNamesOnlyInReference: string[];
  sheetNamesOnlyInSource: string[];
  sheets: AdminMenuExcelSyncSheetSummary[];
  status: 'synced' | 'pending' | 'desynced';
  summary: AdminMenuExcelSyncSummary;
  version: 2;
}

export interface AdminMenuExcelImportPreview {
  applicable: boolean;
  blockedItems: number;
  changedDrafts: AdminMenuDraftItem[];
  changedReadableChanges: AdminMenuReadableChange[];
  fileName: string;
  report: AdminMenuExcelSyncReport;
  totalChangedItems: number;
}

export interface AdminMenuExcelOperationHistoryEntry {
  createdAt: string;
  fileName: string | null;
  generatedFiles: string[];
  id: string;
  itemCount: number;
  fieldCount: number;
  source: 'excel_compare' | 'excel_export' | 'excel_import';
  status: 'synced' | 'pending' | 'desynced' | 'applied';
  summary: string;
}
