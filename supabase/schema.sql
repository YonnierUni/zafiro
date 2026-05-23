create extension if not exists pgcrypto;

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc', now());
  return new;
end;
$$;

create table if not exists public.admin_users (
  email text primary key,
  created_at timestamptz not null default timezone('utc', now())
);

create or replace function public.is_catalog_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists(
    select 1
    from public.admin_users
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

create table if not exists public.menu_items (
  id uuid primary key default gen_random_uuid(),
  source_key text not null unique,
  legacy_id integer not null,
  slug text not null,
  hoja_origen text not null,
  tipo text not null,
  subgrupo text,
  name text not null,
  description text not null default '',
  ingredientes text not null default '',
  preparacion text not null default '',
  emplatado text not null default '',
  precio_venta numeric,
  imagen text not null default '',
  visible boolean not null default true,
  disponible boolean not null default true,
  destacado boolean not null default false,
  orden integer not null,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

create index if not exists menu_items_tipo_idx on public.menu_items (tipo);
create index if not exists menu_items_subgrupo_idx on public.menu_items (subgrupo);
create index if not exists menu_items_visible_idx on public.menu_items (visible);
create index if not exists menu_items_orden_idx on public.menu_items (orden);

drop trigger if exists trg_menu_items_set_updated_at on public.menu_items;
create trigger trg_menu_items_set_updated_at
before update on public.menu_items
for each row
execute function public.set_updated_at();

create table if not exists public.menu_change_logs (
  id uuid primary key default gen_random_uuid(),
  menu_item_source_key text not null references public.menu_items(source_key) on delete cascade,
  item_slug text not null,
  change_source text not null default 'admin_menu',
  actor_label text default 'anonymous-admin',
  changed_fields jsonb not null,
  before_data jsonb not null,
  after_data jsonb not null,
  applied_at timestamptz not null default timezone('utc', now())
);

create index if not exists menu_change_logs_item_idx on public.menu_change_logs (menu_item_source_key);
create index if not exists menu_change_logs_applied_at_idx on public.menu_change_logs (applied_at desc);

create table if not exists public.menu_snapshots (
  id uuid primary key default gen_random_uuid(),
  snapshot_kind text not null,
  summary jsonb not null,
  payload jsonb not null,
  created_at timestamptz not null default timezone('utc', now())
);

create index if not exists menu_snapshots_created_at_idx on public.menu_snapshots (created_at desc);

create or replace view public.menu_items_public as
select
  id,
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
  orden,
  created_at,
  updated_at
from public.menu_items
where visible = true;

alter table public.menu_items enable row level security;
alter table public.menu_change_logs enable row level security;
alter table public.menu_snapshots enable row level security;
alter table public.admin_users enable row level security;

drop policy if exists "admin_read_menu_items" on public.menu_items;
create policy "admin_read_menu_items"
on public.menu_items
for select
using (public.is_catalog_admin());

drop policy if exists "admin_write_menu_items" on public.menu_items;
create policy "admin_write_menu_items"
on public.menu_items
for all
using (public.is_catalog_admin())
with check (public.is_catalog_admin());

drop policy if exists "admin_read_menu_change_logs" on public.menu_change_logs;
create policy "admin_read_menu_change_logs"
on public.menu_change_logs
for select
using (public.is_catalog_admin());

drop policy if exists "admin_insert_menu_change_logs" on public.menu_change_logs;
create policy "admin_insert_menu_change_logs"
on public.menu_change_logs
for insert
with check (public.is_catalog_admin());

drop policy if exists "admin_read_menu_snapshots" on public.menu_snapshots;
create policy "admin_read_menu_snapshots"
on public.menu_snapshots
for select
using (public.is_catalog_admin());

drop policy if exists "admin_insert_menu_snapshots" on public.menu_snapshots;
create policy "admin_insert_menu_snapshots"
on public.menu_snapshots
for insert
with check (public.is_catalog_admin());

drop policy if exists "admin_read_own_admin_user_row" on public.admin_users;
create policy "admin_read_own_admin_user_row"
on public.admin_users
for select
using (lower(email) = lower(coalesce(auth.jwt() ->> 'email', '')));

grant usage on schema public to anon, authenticated;
grant select on public.admin_users to authenticated;
grant select on public.menu_items to authenticated;
grant select on public.menu_items_public to anon, authenticated;
grant insert, update on public.menu_items to authenticated;
grant select, insert on public.menu_change_logs to authenticated;
grant select, insert on public.menu_snapshots to authenticated;
