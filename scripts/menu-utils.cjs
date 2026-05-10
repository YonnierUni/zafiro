const fs = require("fs");
const path = require("path");
const XLSX = require("xlsx");

const OUTPUT_PATH = path.resolve(__dirname, "../public/data/menu.json");

function normalizeHeader(header = "") {
  return String(header)
    .trim()
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/\s+/g, " ")
    .replace(/[^\w\s]/g, "");
}

function normalizeText(value = "") {
  return String(value ?? "").trim();
}

function toSlug(value = "") {
  return String(value)
    .trim()
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^\w\s-]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function toPrice(value) {
  if (value === null || value === undefined || value === "") return null;

  if (typeof value === "number") {
    return Number.isFinite(value) ? value : null;
  }

  const raw = String(value).trim();
  if (!raw) return null;

  const sanitized = raw
    .replace(/\u00a0/g, " ")
    .replace(/\s+/g, "")
    .replace(/[$€£¥]/g, "")
    .replace(/^cop/i, "")
    .replace(/^col\$/i, "");

  if (!sanitized) return null;

  if (/^\d+$/.test(sanitized)) {
    const parsed = Number(sanitized);
    return Number.isFinite(parsed) ? parsed : null;
  }

  if (/^\d{1,3}(\.\d{3})+$/.test(sanitized)) {
    const parsed = Number(sanitized.replace(/\./g, ""));
    return Number.isFinite(parsed) ? parsed : null;
  }

  if (/^\d{1,3}(,\d{3})+$/.test(sanitized)) {
    const parsed = Number(sanitized.replace(/,/g, ""));
    return Number.isFinite(parsed) ? parsed : null;
  }

  const normalized = sanitized.replace(",", ".");
  const parsed = Number(normalized);

  return Number.isFinite(parsed) ? parsed : null;
}

function toBoolean(value, defaultValue = true) {
  const normalized = normalizeText(value).toLowerCase();

  if (!normalized) return defaultValue;
  if (["si", "sí", "true", "1", "yes", "y"].includes(normalized)) return true;
  if (["no", "false", "0", "n"].includes(normalized)) return false;

  return defaultValue;
}

function toInteger(value, fallback = null) {
  if (value === null || value === undefined || value === "") return fallback;

  const parsed = Number(String(value).trim());
  return Number.isFinite(parsed) ? parsed : fallback;
}

function normalizeSheetType(sheetName = "") {
  const normalized = sheetName
    .trim()
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "");

  if (normalized.includes("coctel")) return "cocteles";
  if (normalized.includes("bebida")) return "bebidas";
  if (normalized.includes("comida")) return "comida";

  return toSlug(sheetName) || "otros";
}

function isEmptyRow(row) {
  return Object.values(row).every((value) => normalizeText(value) === "");
}

function normalizeImagePath(value = "") {
  const image = normalizeText(value);
  if (!image) return "";

  return image.replace(/^\/+/, "").replace(/^public\/+/i, "").replace(/\\/g, "/");
}

function mapRow(rawRow, index, sheetName) {
  const row = {};
  for (const [key, value] of Object.entries(rawRow)) {
    row[normalizeHeader(key)] = value;
  }

  if (isEmptyRow(row)) return null;

  const name = normalizeText(row["name"]);
  if (!name) return null;

  const explicitType = normalizeText(row["tipo"]);
  const tipo = explicitType || normalizeSheetType(sheetName);
  const subgrupo = normalizeText(row["subgrupo"]);

  const rawId = normalizeText(row["no"]);
  const numericId = toInteger(rawId, index + 1);

  const orden = toInteger(row["orden"], numericId);

  return {
    id: numericId,
    orden,
    slug: toSlug(name),
    name,
    description: normalizeText(row["description"]),
    tipo,
    subgrupo,
    ingredientes: normalizeText(row["ingredientes"]),
    preparacion: normalizeText(row["preparacion"]),
    emplatado: normalizeText(row["emplatado"]),
    precioVenta: toPrice(row["precioventa"]),
    imagen: normalizeImagePath(row["imagen"]),
    hojaOrigen: sheetName,
    visible: toBoolean(row["visible"], true),
    disponible: toBoolean(row["disponible"], true),
    destacado: toBoolean(row["destacado"], false),
  };
}

function workbookToMenuJson(workbook) {
  if (!workbook.SheetNames || !workbook.SheetNames.length) {
    throw new Error("El Excel no tiene hojas.");
  }

  const items = [];
  let runningIndex = 0;

  for (const sheetName of workbook.SheetNames) {
    const sheet = workbook.Sheets[sheetName];
    const rows = XLSX.utils.sheet_to_json(sheet, {
      defval: "",
      raw: true,
    });

    const mappedRows = rows
      .map((row, idx) => mapRow(row, runningIndex + idx, sheetName))
      .filter(Boolean);

    runningIndex += mappedRows.length;
    items.push(...mappedRows);
  }

  if (!items.length) {
    throw new Error("No se encontraron filas válidas en ninguna hoja del Excel.");
  }

  return {
    updatedAt: new Date().toISOString(),
    count: items.length,
    items,
  };
}

function saveMenuJson(data) {
  fs.mkdirSync(path.dirname(OUTPUT_PATH), { recursive: true });
  fs.writeFileSync(OUTPUT_PATH, JSON.stringify(data, null, 2), "utf8");
  console.log(`✅ menu.json generado en: ${OUTPUT_PATH}`);
  console.log(`📦 Items: ${data.count}`);
}

module.exports = {
  XLSX,
  workbookToMenuJson,
  saveMenuJson,
};
