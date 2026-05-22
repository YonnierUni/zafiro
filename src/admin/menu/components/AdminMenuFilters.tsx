import type { AdminMenuStatusFilter } from '../adminMenu.types';

interface AdminMenuFiltersProps {
  category: string;
  categoryOptions: Array<{ label: string; value: string }>;
  onCategoryChange: (value: string) => void;
  onSearchChange: (value: string) => void;
  onStatusChange: (value: AdminMenuStatusFilter) => void;
  onSubgroupChange: (value: string) => void;
  search: string;
  status: AdminMenuStatusFilter;
  subgroup: string;
  subgroupOptions: Array<{ label: string; value: string }>;
}

const statusOptions: Array<{ label: string; value: AdminMenuStatusFilter }> = [
  { value: 'all', label: 'Todos' },
  { value: 'visible', label: 'Visibles' },
  { value: 'hidden', label: 'Ocultos' },
  { value: 'available', label: 'Disponibles' },
  { value: 'unavailable', label: 'Agotados' },
  { value: 'featured', label: 'Destacados' },
  { value: 'edited', label: 'Editados' },
];

export function AdminMenuFilters({
  category,
  categoryOptions,
  onCategoryChange,
  onSearchChange,
  onStatusChange,
  onSubgroupChange,
  search,
  status,
  subgroup,
  subgroupOptions,
}: AdminMenuFiltersProps) {
  return (
    <section className="rounded-[1.75rem] border border-white/10 bg-white/[0.03] p-4 sm:p-5">
      <div className="grid gap-4 xl:grid-cols-[minmax(0,1.5fr)_repeat(3,minmax(0,0.8fr))]">
        <label className="space-y-2">
          <span className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">Búsqueda</span>
          <input
            type="search"
            value={search}
            onChange={(event) => onSearchChange(event.target.value)}
            placeholder="Buscar por nombre, slug o tipo"
            className="w-full rounded-2xl border border-white/10 bg-obsidian/55 px-4 py-3 text-sm text-ivory outline-none transition placeholder:text-mist/55 focus:border-cyanGlow/35"
          />
        </label>

        <SelectField
          label="Estado"
          value={status}
          onChange={onStatusChange}
          options={statusOptions}
        />

        <SelectField
          label="Categoría"
          value={category}
          onChange={onCategoryChange}
          options={[{ value: 'all', label: 'Todas' }, ...categoryOptions]}
        />

        <SelectField
          label="Subgrupo"
          value={subgroup}
          onChange={onSubgroupChange}
          options={[{ value: 'all', label: 'Todos' }, ...subgroupOptions]}
        />
      </div>
    </section>
  );
}

interface SelectFieldProps<T extends string> {
  label: string;
  onChange: (value: T) => void;
  options: Array<{ label: string; value: T }>;
  value: T;
}

function SelectField<T extends string>({ label, onChange, options, value }: SelectFieldProps<T>) {
  return (
    <label className="space-y-2">
      <span className="text-[0.68rem] uppercase tracking-[0.24em] text-cyanGlow/80">{label}</span>
      <select
        value={value}
        onChange={(event) => onChange(event.target.value as T)}
        className="w-full rounded-2xl border border-white/10 bg-obsidian/55 px-4 py-3 text-sm text-ivory outline-none transition focus:border-cyanGlow/35"
      >
        {options.map((option) => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
    </label>
  );
}
