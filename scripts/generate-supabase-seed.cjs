const fs = require('fs');
const path = require('path');

const inputPath = path.resolve(__dirname, '../public/data/menu.json');
const outputDir = path.resolve(__dirname, '../supabase');
const outputPath = path.resolve(outputDir, 'seed-menu-items.sql');

function sanitizeKeyPart(value = '') {
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

function buildSourceKey(item) {
  return `${sanitizeKeyPart(item.hojaOrigen)}::${sanitizeKeyPart(item.slug)}::${String(item.id).trim()}`;
}

function toSqlText(value) {
  if (value === null || value === undefined) {
    return 'null';
  }

  return `'${String(value).replace(/'/g, "''")}'`;
}

function toSqlNumber(value) {
  if (value === null || value === undefined || value === '') {
    return 'null';
  }

  return String(Number(value));
}

function toSqlBoolean(value) {
  return value ? 'true' : 'false';
}

function main() {
  const raw = JSON.parse(fs.readFileSync(inputPath, 'utf8'));
  const items = raw.items ?? [];

  const values = items
    .map(
      (item) => `(
  ${toSqlText(buildSourceKey(item))},
  ${toSqlNumber(item.id)},
  ${toSqlText(item.slug)},
  ${toSqlText(item.hojaOrigen)},
  ${toSqlText(item.tipo)},
  ${item.subgrupo ? toSqlText(item.subgrupo) : 'null'},
  ${toSqlText(item.name)},
  ${toSqlText(item.description ?? '')},
  ${toSqlText(item.ingredientes ?? '')},
  ${toSqlText(item.preparacion ?? '')},
  ${toSqlText(item.emplatado ?? '')},
  ${toSqlNumber(item.precioVenta)},
  ${toSqlText(item.imagen ?? '')},
  ${toSqlBoolean(item.visible === true)},
  ${toSqlBoolean(item.disponible !== false)},
  ${toSqlBoolean(item.destacado === true)},
  ${toSqlNumber(item.orden)}
)`,
    )
    .join(',\n');

  const sql = `-- Generated from public/data/menu.json
insert into public.menu_items (
  source_key,
  legacy_id,
  slug,
  hoja_origen,
  tipo,
  subgrupo,
  name,
  description,
  ingredientes,
  preparacion,
  emplatado,
  precio_venta,
  imagen,
  visible,
  disponible,
  destacado,
  orden
)
values
${values}
on conflict (source_key) do update
set
  legacy_id = excluded.legacy_id,
  slug = excluded.slug,
  hoja_origen = excluded.hoja_origen,
  tipo = excluded.tipo,
  subgrupo = excluded.subgrupo,
  name = excluded.name,
  description = excluded.description,
  ingredientes = excluded.ingredientes,
  preparacion = excluded.preparacion,
  emplatado = excluded.emplatado,
  precio_venta = excluded.precio_venta,
  imagen = excluded.imagen,
  visible = excluded.visible,
  disponible = excluded.disponible,
  destacado = excluded.destacado,
  orden = excluded.orden,
  updated_at = timezone('utc', now());
`;

  fs.mkdirSync(outputDir, { recursive: true });
  fs.writeFileSync(outputPath, sql, 'utf8');
  console.log(`Supabase seed generated at ${outputPath}`);
}

main();
