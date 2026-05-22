import type { ReactNode } from 'react';
import { resolveMenuImageSrc, sanitizeMenuText } from '../../../models/menuData';
import {
  getAdminMenuDraftPriceLabel,
  parseDraftPrice,
  serializeAdminMenuDraft,
} from '../adminMenu.mapper';
import type {
  AdminMenuDraftItem,
  AdminMenuDraftValidation,
  AdminMenuEditableFieldKey,
} from '../adminMenu.types';

interface AdminMenuEditorPanelProps {
  changedFields: AdminMenuEditableFieldKey[];
  item: AdminMenuDraftItem | null;
  onChange: <K extends keyof AdminMenuDraftItem>(field: K, value: AdminMenuDraftItem[K]) => void;
  onResetItem: () => void;
  onResetAll: () => void;
  validation: AdminMenuDraftValidation | null;
}

export function AdminMenuEditorPanel({
  changedFields,
  item,
  onChange,
  onResetAll,
  onResetItem,
  validation,
}: AdminMenuEditorPanelProps) {
  if (!item) {
    return (
      <section className="rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6 text-mist">
        Selecciona un producto para editar su ficha localmente.
      </section>
    );
  }

  const previewImage = item.imagen ? resolveMenuImageSrc(item.imagen) : '';
  const parsedPrice = parseDraftPrice(item.precioVenta);
  const payloadPreview = serializeAdminMenuDraft(item);
  const fieldChanged = (field: AdminMenuEditableFieldKey) => changedFields.includes(field);
  const fieldError = (field: AdminMenuEditableFieldKey) => validation?.errors[field];

  return (
    <section className="rounded-[1.9rem] border border-white/10 bg-white/[0.03]">
      <div className="border-b border-white/10 px-5 py-5">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Ficha editable</p>
            <h2 className="mt-3 font-display text-[2.1rem] leading-none text-ivory">{item.name || item.slug}</h2>
            <p className="mt-3 text-sm leading-7 text-mist">
              Hoja origen: <span className="text-ivory">{item.hojaOrigen}</span> · Slug:{' '}
              <span className="text-ivory">{item.slug}</span>
            </p>
          </div>

          <div className="flex flex-wrap gap-2">
            <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-xs font-semibold text-amberGlow">
              {getAdminMenuDraftPriceLabel(item)}
            </span>
            <span
              className={`rounded-full px-3 py-1.5 text-[0.64rem] font-semibold uppercase tracking-[0.18em] ${
                changedFields.length
                  ? 'border border-amberGlow/20 bg-amberGlow/10 text-amberGlow'
                  : 'border border-white/10 bg-white/[0.04] text-mist'
              }`}
            >
              {changedFields.length ? 'Editado localmente' : 'Sin cambios'}
            </span>
            {!validation?.isValid ? (
              <span className="rounded-full border border-rose-200/20 bg-rose-200/10 px-3 py-1.5 text-[0.64rem] font-semibold uppercase tracking-[0.18em] text-rose-100">
                Validacion pendiente
              </span>
            ) : null}
          </div>
        </div>
      </div>

      <div className="grid gap-6 px-5 py-5 xl:grid-cols-[minmax(0,0.88fr)_minmax(0,1.12fr)]">
        <div className="space-y-5">
          <div className="overflow-hidden rounded-[1.6rem] border border-white/10 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.16),_transparent_40%),rgba(255,255,255,0.03)]">
            {previewImage ? (
              <div className="relative aspect-[4/3] overflow-hidden px-4 pt-4">
                <img
                  src={previewImage}
                  alt={item.name || item.slug}
                  className="h-full w-full object-contain object-center"
                />
                <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_top,_rgba(36,107,255,0.12),_transparent_34%),linear-gradient(180deg,transparent,rgba(7,10,18,0.6))]" />
              </div>
            ) : (
              <div className="flex aspect-[4/3] items-center justify-center px-6 text-center text-sm leading-7 text-mist">
                Sin imagen asignada para este item.
              </div>
            )}
            <div className="border-t border-white/10 px-4 py-4 text-sm text-mist">
              Vista previa del asset actual que usa la carta publica.
            </div>
          </div>

          <div className="rounded-[1.6rem] border border-white/10 bg-obsidian/35 p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Resumen local</p>
            <dl className="mt-4 grid gap-3 text-sm text-mist">
              <SummaryRow label="Precio parseado" value={parsedPrice === null ? 'Sin precio' : getAdminMenuDraftPriceLabel(item)} />
              <SummaryRow label="Visible publicamente" value={item.visible ? 'Si' : 'No'} />
              <SummaryRow label="Disponible" value={item.disponible ? 'Si' : 'No'} />
              <SummaryRow label="Destacado en landing" value={item.destacado ? 'Si' : 'No'} />
              <SummaryRow
                label="Campos modificados"
                value={changedFields.length ? changedFields.join(', ') : 'Ninguno'}
              />
            </dl>
          </div>

          <div className="rounded-[1.6rem] border border-white/10 bg-obsidian/35 p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Comparar cambios</p>
            <div className="mt-4 space-y-3 text-sm">
              {changedFields.length ? (
                changedFields.map((field) => (
                  <div key={field} className="rounded-2xl border border-white/10 bg-white/[0.03] p-3">
                    <p className="text-[0.62rem] uppercase tracking-[0.2em] text-cyanGlow/75">{field}</p>
                    <p className="mt-2 text-mist">Original: {formatFieldValue(field, item.original[field as keyof typeof item.original])}</p>
                    <p className="mt-1 text-ivory">Actual: {formatFieldValue(field, item[field])}</p>
                  </div>
                ))
              ) : (
                <p className="text-mist">Aun no hay diferencias frente al item original.</p>
              )}
            </div>
          </div>
        </div>

        <div className="space-y-5">
          <div className="grid gap-4 sm:grid-cols-2">
            <FormField error={fieldError('name')} label="Nombre" changed={fieldChanged('name')}>
              <input
                value={item.name}
                onChange={(event) => onChange('name', event.target.value)}
                className={getInputClassName(fieldChanged('name'), Boolean(fieldError('name')))}
              />
            </FormField>
            <FormField error={fieldError('precioVenta')} label="Precio venta" changed={fieldChanged('precioVenta')}>
              <input
                value={item.precioVenta}
                onChange={(event) => onChange('precioVenta', event.target.value)}
                inputMode="numeric"
                placeholder="21000"
                className={getInputClassName(fieldChanged('precioVenta'), Boolean(fieldError('precioVenta')))}
              />
            </FormField>
            <FormField error={fieldError('tipo')} label="Tipo" changed={fieldChanged('tipo')}>
              <input
                value={item.tipo}
                onChange={(event) => onChange('tipo', event.target.value)}
                className={getInputClassName(fieldChanged('tipo'), Boolean(fieldError('tipo')))}
              />
            </FormField>
            <FormField error={fieldError('subgrupo')} label="Subgrupo" changed={fieldChanged('subgrupo')}>
              <input
                value={item.subgrupo}
                onChange={(event) => onChange('subgrupo', event.target.value)}
                className={getInputClassName(fieldChanged('subgrupo'), Boolean(fieldError('subgrupo')))}
              />
            </FormField>
            <FormField error={fieldError('orden')} label="Orden" changed={fieldChanged('orden')}>
              <input
                value={item.orden}
                onChange={(event) => onChange('orden', event.target.value)}
                inputMode="numeric"
                className={getInputClassName(fieldChanged('orden'), Boolean(fieldError('orden')))}
              />
            </FormField>
            <FormField error={fieldError('imagen')} label="Imagen" changed={fieldChanged('imagen')}>
              <input
                value={item.imagen}
                onChange={(event) => onChange('imagen', event.target.value)}
                className={getInputClassName(fieldChanged('imagen'), Boolean(fieldError('imagen')))}
              />
            </FormField>
          </div>

          <FormField error={fieldError('description')} label="Descripcion" changed={fieldChanged('description')}>
            <textarea
              value={item.description}
              onChange={(event) => onChange('description', event.target.value)}
              rows={5}
              className={`${getInputClassName(fieldChanged('description'), Boolean(fieldError('description')))} resize-y`}
            />
          </FormField>

          <div className="grid gap-3 sm:grid-cols-2 2xl:grid-cols-3">
            <ToggleCard
              checked={item.visible}
              changed={fieldChanged('visible')}
              description="Controla si el producto entra a la web publica."
              label="Visible"
              onChange={(checked) => onChange('visible', checked)}
            />
            <ToggleCard
              checked={item.disponible}
              changed={fieldChanged('disponible')}
              description="Marca disponibilidad publica sin borrar el producto."
              label="Disponible"
              onChange={(checked) => onChange('disponible', checked)}
            />
            <ToggleCard
              checked={item.destacado}
              changed={fieldChanged('destacado')}
              description="Participa en la seleccion curada de la landing."
              label="Destacado"
              onChange={(checked) => onChange('destacado', checked)}
            />
          </div>

          <div className="rounded-[1.6rem] border border-white/10 bg-obsidian/35 p-4">
            <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Payload serializado del item</p>
            <pre className="mt-4 max-h-[18rem] overflow-auto rounded-[1.2rem] border border-white/10 bg-obsidian/55 p-4 text-xs leading-6 text-mist">
              {JSON.stringify(payloadPreview, null, 2)}
            </pre>
          </div>

          <div className="flex flex-wrap items-center gap-3 border-t border-white/10 pt-5">
            <button
              type="button"
              onClick={onResetItem}
              className="interactive-button rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.2em] text-ivory"
            >
              Reiniciar item
            </button>
            <button
              type="button"
              onClick={onResetAll}
              className="interactive-button rounded-full border border-white/10 bg-transparent px-4 py-2 text-xs font-semibold uppercase tracking-[0.2em] text-mist hover:text-ivory"
            >
              Reiniciar todos los cambios
            </button>
            <p className="text-xs leading-6 text-mist">
              Esta edicion es solo local. Aun no modifica Excel, JSON ni backend.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}

interface FormFieldProps {
  changed: boolean;
  children: ReactNode;
  error?: string;
  label: string;
}

function FormField({ changed, children, error, label }: FormFieldProps) {
  return (
    <label className="space-y-2">
      <div className="flex items-center justify-between gap-3">
        <span className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">{label}</span>
        {changed ? (
          <span className="rounded-full border border-amberGlow/20 bg-amberGlow/10 px-2 py-1 text-[0.58rem] font-semibold uppercase tracking-[0.18em] text-amberGlow">
            Modificado
          </span>
        ) : null}
      </div>
      {children}
      {error ? <p className="text-xs leading-6 text-rose-100">{error}</p> : null}
    </label>
  );
}

interface ToggleCardProps {
  changed: boolean;
  checked: boolean;
  description: string;
  label: string;
  onChange: (checked: boolean) => void;
}

function ToggleCard({ changed, checked, description, label, onChange }: ToggleCardProps) {
  return (
    <button
      type="button"
      onClick={() => onChange(!checked)}
      className={`h-full min-w-0 rounded-[1.4rem] border p-4 text-left transition ${
        checked
          ? 'border-cyanGlow/30 bg-cyanGlow/10'
          : 'border-white/10 bg-white/[0.03] hover:border-cyanGlow/20'
      }`}
    >
      <div className="flex min-w-0 flex-col items-start gap-3">
        <div className="flex min-w-0 w-full flex-wrap items-start justify-between gap-x-3 gap-y-2">
          <p className="min-w-0 flex-1 text-balance pr-2 font-semibold leading-6 text-ivory">{label}</p>
          <div className="flex max-w-full shrink-0 flex-wrap items-center justify-end gap-2 self-start">
            {changed ? (
              <span className="rounded-full border border-amberGlow/20 bg-amberGlow/10 px-2 py-1 text-[0.58rem] font-semibold uppercase tracking-[0.18em] text-amberGlow">
                Mod.
              </span>
            ) : null}
            <span
              className={`inline-flex min-w-[3.25rem] items-center justify-center rounded-full px-2.5 py-1 text-[0.58rem] font-semibold uppercase tracking-[0.16em] ${
                checked ? 'bg-emerald-300/15 text-emerald-200' : 'bg-white/[0.05] text-mist'
              }`}
            >
              {checked ? 'Si' : 'No'}
            </span>
          </div>
        </div>
        
        
      </div>
      <p className="text-sm leading-6 text-mist">{description}</p>
    </button>
  );
}

function SummaryRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex items-center justify-between gap-3">
      <dt>{label}</dt>
      <dd className="text-right text-ivory">{value}</dd>
    </div>
  );
}

function formatFieldValue(field: AdminMenuEditableFieldKey, value: unknown) {
  if (typeof value === 'boolean') {
    return value ? 'Si' : 'No';
  }

  if (field === 'precioVenta') {
    return value === null || value === '' ? 'Sin precio' : String(value);
  }

  const text = typeof value === 'string' ? sanitizeMenuText(value) : String(value ?? '');
  return text || 'Vacio';
}

function getInputClassName(changed: boolean, hasError: boolean) {
  if (hasError) {
    return 'w-full rounded-2xl border border-rose-200/25 bg-obsidian/55 px-4 py-3 text-sm text-ivory outline-none transition placeholder:text-mist/55 focus:border-rose-200/50';
  }

  if (changed) {
    return 'w-full rounded-2xl border border-amberGlow/25 bg-obsidian/55 px-4 py-3 text-sm text-ivory outline-none transition placeholder:text-mist/55 focus:border-amberGlow/40';
  }

  return 'w-full rounded-2xl border border-white/10 bg-obsidian/55 px-4 py-3 text-sm text-ivory outline-none transition placeholder:text-mist/55 focus:border-cyanGlow/35';
}
