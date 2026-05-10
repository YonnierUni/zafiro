import { useEffect, useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { loadMenuData } from '../controllers/menuController';
import { formatMenuPrice, sanitizeMenuText } from '../models/menuData';
import type { MenuDataItem } from '../shared/menu/menu.types';
import { AdminLayout } from './AdminLayout';

type AdminMenuFilter = 'all' | 'visible' | 'unavailable' | 'featured';

const filters: Array<{ id: AdminMenuFilter; label: string }> = [
  { id: 'all', label: 'Todos' },
  { id: 'visible', label: 'Visibles' },
  { id: 'unavailable', label: 'No disponibles' },
  { id: 'featured', label: 'Destacados' },
];

export function AdminMenuView() {
  const [items, setItems] = useState<MenuDataItem[]>([]);
  const [filter, setFilter] = useState<AdminMenuFilter>('all');
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let isMounted = true;

    loadMenuData()
      .then((data) => {
        if (!isMounted) {
          return;
        }

        setItems(data.items);
        setError(null);
      })
      .catch((loadError) => {
        if (!isMounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'No fue posible cargar el menú.');
        setItems([]);
      })
      .finally(() => {
        if (isMounted) {
          setIsLoading(false);
        }
      });

    return () => {
      isMounted = false;
    };
  }, []);

  const filteredItems = useMemo(() => {
    switch (filter) {
      case 'visible':
        return items.filter((item) => item.visible);
      case 'unavailable':
        return items.filter((item) => item.disponible === false);
      case 'featured':
        return items.filter((item) => item.destacado);
      default:
        return items;
    }
  }, [filter, items]);

  return (
    <AdminLayout>
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div className="max-w-3xl">
          <p className="text-[0.72rem] uppercase tracking-[0.28em] text-cyanGlow/80">Módulo interno</p>
          <h1 className="mt-4 font-display text-[2.5rem] leading-none text-ivory sm:text-[3.3rem]">Menú</h1>
          <p className="mt-4 text-base leading-8 text-mist sm:text-lg">
            Vista de lectura del menú actual para revisar productos, disponibilidad, destacados y orden.
          </p>
        </div>

        <Link
          to="/admin"
          className="interactive-button w-fit rounded-full border border-white/10 bg-white/[0.04] px-4 py-2 text-xs font-semibold uppercase tracking-[0.24em] text-ivory transition hover:border-cyanGlow/35 hover:bg-white/[0.08]"
        >
          Volver a admin
        </Link>
      </section>

      <section className="mt-8 rounded-[1.75rem] border border-white/10 bg-white/[0.03] p-4 sm:p-5">
        <p className="text-[0.68rem] uppercase tracking-[0.28em] text-cyanGlow/80">Filtros</p>
        <div className="mt-4 flex flex-wrap gap-2">
          {filters.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => setFilter(item.id)}
              className={`interactive-button rounded-full border px-3 py-2 text-[0.68rem] font-semibold uppercase tracking-[0.22em] transition sm:px-4 ${
                filter === item.id
                  ? 'border-cyanGlow/45 bg-cyanGlow/12 text-ivory'
                  : 'border-white/10 bg-white/[0.03] text-mist hover:border-cyanGlow/30 hover:text-ivory'
              }`}
            >
              {item.label}
            </button>
          ))}
        </div>
      </section>

      {isLoading ? (
        <section className="mt-8 rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6 text-mist">
          Cargando productos del menú...
        </section>
      ) : null}

      {!isLoading && error ? (
        <section className="mt-8 rounded-[1.9rem] border border-rose-200/15 bg-rose-200/10 p-6 text-rose-100">
          Error al cargar el menú: {error}
        </section>
      ) : null}

      {!isLoading && !error && filteredItems.length === 0 ? (
        <section className="mt-8 rounded-[1.9rem] border border-white/10 bg-white/[0.03] p-6 text-mist">
          No hay productos para mostrar con el filtro actual.
        </section>
      ) : null}

      {!isLoading && !error && filteredItems.length > 0 ? (
        <>
          <section className="mt-8 hidden overflow-hidden rounded-[1.9rem] border border-white/10 bg-white/[0.03] lg:block">
            <div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-white/10">
                <thead className="bg-white/[0.03]">
                  <tr className="text-left text-[0.68rem] uppercase tracking-[0.22em] text-cyanGlow/80">
                    <th className="px-4 py-4 font-semibold">Nombre</th>
                    <th className="px-4 py-4 font-semibold">Tipo</th>
                    <th className="px-4 py-4 font-semibold">Subgrupo</th>
                    <th className="px-4 py-4 font-semibold">Precio</th>
                    <th className="px-4 py-4 font-semibold">Visible</th>
                    <th className="px-4 py-4 font-semibold">Disponible</th>
                    <th className="px-4 py-4 font-semibold">Destacado</th>
                    <th className="px-4 py-4 font-semibold">Orden</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-white/10">
                  {filteredItems.map((item) => (
                    <tr key={`${item.id}-${item.slug}`} className="text-sm text-mist">
                      <td className="px-4 py-4 align-top">
                        <div className="font-semibold text-ivory">{sanitizeMenuText(item.name)}</div>
                        <div className="mt-1 text-xs text-mist/70">{item.slug}</div>
                      </td>
                      <td className="px-4 py-4 align-top">{sanitizeMenuText(item.tipo)}</td>
                      <td className="px-4 py-4 align-top">{sanitizeMenuText(item.subgrupo ?? '') || '—'}</td>
                      <td className="px-4 py-4 align-top">{formatMenuPrice(item.precioVenta)}</td>
                      <td className="px-4 py-4 align-top">
                        <StatusPill active={item.visible} activeLabel="Sí" inactiveLabel="No" />
                      </td>
                      <td className="px-4 py-4 align-top">
                        <StatusPill active={item.disponible} activeLabel="Sí" inactiveLabel="No" />
                      </td>
                      <td className="px-4 py-4 align-top">
                        <StatusPill active={item.destacado} activeLabel="Sí" inactiveLabel="No" />
                      </td>
                      <td className="px-4 py-4 align-top">{item.orden}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </section>

          <section className="mt-8 grid gap-4 lg:hidden">
            {filteredItems.map((item) => (
              <article
                key={`${item.id}-${item.slug}`}
                className="rounded-[1.7rem] border border-white/10 bg-white/[0.03] p-5"
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <h2 className="font-display text-[1.8rem] leading-none text-ivory">
                      {sanitizeMenuText(item.name)}
                    </h2>
                    <p className="mt-2 text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">
                      {sanitizeMenuText(item.tipo)}
                    </p>
                  </div>
                  <span className="rounded-full border border-white/10 bg-white/[0.04] px-3 py-1.5 text-xs font-semibold text-amberGlow">
                    {formatMenuPrice(item.precioVenta)}
                  </span>
                </div>

                <div className="mt-5 grid grid-cols-2 gap-3 text-sm text-mist">
                  <InfoRow label="Subgrupo" value={sanitizeMenuText(item.subgrupo ?? '') || '—'} />
                  <InfoRow label="Orden" value={String(item.orden)} />
                  <InfoRow label="Visible" value={item.visible ? 'Sí' : 'No'} />
                  <InfoRow label="Disponible" value={item.disponible ? 'Sí' : 'No'} />
                  <InfoRow label="Destacado" value={item.destacado ? 'Sí' : 'No'} />
                  <InfoRow label="Slug" value={item.slug} />
                </div>
              </article>
            ))}
          </section>
        </>
      ) : null}
    </AdminLayout>
  );
}

interface StatusPillProps {
  active: boolean;
  activeLabel: string;
  inactiveLabel: string;
}

function StatusPill({ active, activeLabel, inactiveLabel }: StatusPillProps) {
  return (
    <span
      className={`inline-flex rounded-full border px-3 py-1.5 text-[0.64rem] font-semibold uppercase tracking-[0.18em] ${
        active
          ? 'border-emerald-300/20 bg-emerald-300/10 text-emerald-200'
          : 'border-white/10 bg-white/[0.04] text-mist'
      }`}
    >
      {active ? activeLabel : inactiveLabel}
    </span>
  );
}

interface InfoRowProps {
  label: string;
  value: string;
}

function InfoRow({ label, value }: InfoRowProps) {
  return (
    <div className="rounded-2xl border border-white/10 bg-obsidian/40 px-3 py-3">
      <p className="text-[0.62rem] uppercase tracking-[0.22em] text-cyanGlow/75">{label}</p>
      <p className="mt-2 break-words text-sm text-ivory">{value}</p>
    </div>
  );
}
