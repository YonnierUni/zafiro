import { sanitizeMenuText } from '../../../models/menuData';
import {
  getAdminMenuCategory,
  getAdminMenuDraftPriceLabel,
  getAdminMenuSubgroup,
  hasAdminMenuDraftChanges,
  humanizeAdminLabel,
  validateAdminMenuDraft,
} from '../adminMenu.mapper';
import type { AdminMenuDraftItem } from '../adminMenu.types';

interface AdminMenuItemListProps {
  items: AdminMenuDraftItem[];
  onSelect: (draftKey: string) => void;
  selectedDraftKey: string | null;
}

export function AdminMenuItemList({ items, onSelect, selectedDraftKey }: AdminMenuItemListProps) {
  return (
    <section className="relative isolate overflow-hidden rounded-[1.9rem] border border-white/10 bg-white/[0.03]">
      <div className="border-b border-white/10 px-4 py-4 sm:px-5">
        <p className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Productos</p>
        <p className="mt-2 text-sm leading-7 text-mist">
          Selecciona un item para editar sus campos en memoria y validar la experiencia del admin.
        </p>
      </div>

      <div className="relative z-10 max-h-[65vh] overflow-y-auto overscroll-contain">
        {items.length ? (
          <div className="divide-y divide-white/10">
            {items.map((item) => {
              const isSelected = item.draftKey === selectedDraftKey;
              const isEdited = hasAdminMenuDraftChanges(item);
              const validation = validateAdminMenuDraft(item);

              return (
                <button
                  key={item.draftKey}
                  type="button"
                  onClick={() => onSelect(item.draftKey)}
                  className={`relative block w-full cursor-pointer overflow-hidden px-4 py-4 text-left transition sm:px-5 ${
                    isSelected ? 'bg-cyanGlow/8' : 'hover:bg-white/[0.03]'
                  }`}
                  aria-pressed={isSelected}
                  data-draft-key={item.draftKey}
                >
                  <div className="flex items-start justify-between gap-4">
                    <div className="min-w-0">
                      <div className="flex flex-wrap items-center gap-2">
                        <h3 className="truncate font-semibold text-ivory">{sanitizeMenuText(item.name)}</h3>
                        {isEdited ? (
                          <span className="pointer-events-none rounded-full border border-amberGlow/20 bg-amberGlow/10 px-2 py-1 text-[0.62rem] font-semibold uppercase tracking-[0.18em] text-amberGlow">
                            Local
                          </span>
                        ) : null}
                        {!validation.isValid ? (
                          <span className="pointer-events-none rounded-full border border-rose-200/20 bg-rose-200/10 px-2 py-1 text-[0.62rem] font-semibold uppercase tracking-[0.18em] text-rose-100">
                            Revisar
                          </span>
                        ) : null}
                        {!item.visible ? (
                          <span className="pointer-events-none rounded-full border border-white/10 bg-white/[0.04] px-2 py-1 text-[0.62rem] font-semibold uppercase tracking-[0.18em] text-mist">
                            Oculto
                          </span>
                        ) : null}
                        {!item.disponible ? (
                          <span className="pointer-events-none rounded-full border border-rose-200/20 bg-rose-200/10 px-2 py-1 text-[0.62rem] font-semibold uppercase tracking-[0.18em] text-rose-100">
                            Agotado
                          </span>
                        ) : null}
                      </div>
                      <p className="mt-2 text-xs uppercase tracking-[0.18em] text-cyanGlow/75">
                        {humanizeAdminLabel(getAdminMenuCategory(item))} · {getAdminMenuSubgroup(item)}
                      </p>
                      <p className="mt-2 truncate text-sm text-mist">{item.slug}</p>
                    </div>

                    <div className="flex flex-col items-end gap-2 pointer-events-none">
                      <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-xs font-semibold text-amberGlow">
                        {getAdminMenuDraftPriceLabel(item)}
                      </span>
                      <span className="text-xs text-mist">Orden {item.orden || '—'}</span>
                    </div>
                  </div>
                </button>
              );
            })}
          </div>
        ) : (
          <div className="px-4 py-10 text-sm text-mist sm:px-5">
            No hay productos para mostrar con los filtros actuales.
          </div>
        )}
      </div>
    </section>
  );
}
