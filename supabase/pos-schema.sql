create extension if not exists pgcrypto;

create table if not exists public.staff_profiles (
  email text primary key,
  full_name text not null,
  is_active boolean not null default true,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

drop trigger if exists trg_staff_profiles_set_updated_at on public.staff_profiles;
create trigger trg_staff_profiles_set_updated_at
before update on public.staff_profiles
for each row
execute function public.set_updated_at();

create table if not exists public.staff_role_assignments (
  email text not null references public.staff_profiles(email) on delete cascade,
  role text not null check (role in ('superadmin', 'waiter', 'kitchen', 'bar', 'cashier')),
  created_at timestamptz not null default timezone('utc', now()),
  primary key (email, role)
);

create or replace function public.has_staff_role(requested_role text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists(
    select 1
    from public.staff_role_assignments
    where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
      and role = requested_role
  );
$$;

create or replace function public.is_pos_staff()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select public.is_catalog_admin()
    or exists(
      select 1
      from public.staff_role_assignments
      where lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
    );
$$;

create table if not exists public.pos_tables (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name text not null,
  type text not null check (type in ('fixed', 'temporary')),
  zone text not null check (zone in ('salon', 'bar', 'terrace', 'vip', 'other')),
  capacity integer,
  status text not null check (status in ('available', 'occupied', 'reserved', 'inactive')) default 'available',
  assigned_staff_email text,
  active_order_id uuid,
  notes text not null default '',
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

drop trigger if exists trg_pos_tables_set_updated_at on public.pos_tables;
create trigger trg_pos_tables_set_updated_at
before update on public.pos_tables
for each row
execute function public.set_updated_at();

create table if not exists public.pos_orders (
  id uuid primary key default gen_random_uuid(),
  table_id uuid not null references public.pos_tables(id) on delete cascade,
  financial_status text not null check (financial_status in ('pending_payment', 'partially_paid', 'paid_total', 'cancelled')) default 'pending_payment',
  opened_at timestamptz not null default timezone('utc', now()),
  closed_at timestamptz,
  opened_by_email text not null,
  assigned_staff_email text,
  cashier_email text,
  notes text not null default '',
  cancellation_reason text,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

drop trigger if exists trg_pos_orders_set_updated_at on public.pos_orders;
create trigger trg_pos_orders_set_updated_at
before update on public.pos_orders
for each row
execute function public.set_updated_at();

create table if not exists public.pos_order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.pos_orders(id) on delete cascade,
  menu_item_source_key text references public.menu_items(source_key),
  product_name text not null,
  product_slug text not null,
  prep_area text not null check (prep_area in ('kitchen', 'bar')),
  quantity integer not null check (quantity > 0),
  unit_price numeric not null check (unit_price >= 0),
  total_price numeric not null check (total_price >= 0),
  service_round integer not null default 1,
  operational_status text not null check (operational_status in ('draft', 'sent', 'pending_preparation', 'in_process', 'ready', 'picking_up', 'delivered', 'cancelled')) default 'draft',
  financial_status text not null check (financial_status in ('pending_payment', 'partially_paid', 'paid_total', 'cancelled')) default 'pending_payment',
  notes text not null default '',
  replacement_for_item_id uuid references public.pos_order_items(id),
  created_at timestamptz not null default timezone('utc', now()),
  created_by_email text not null,
  updated_at timestamptz not null default timezone('utc', now()),
  updated_by_email text,
  sent_at timestamptz,
  preparation_started_at timestamptz,
  ready_at timestamptz,
  picking_up_at timestamptz,
  picking_up_by_email text,
  delivered_at timestamptz,
  delivered_by_email text,
  cancelled_at timestamptz,
  cancelled_by_email text,
  cancellation_reason text
);

drop trigger if exists trg_pos_order_items_set_updated_at on public.pos_order_items;
create trigger trg_pos_order_items_set_updated_at
before update on public.pos_order_items
for each row
execute function public.set_updated_at();

create index if not exists pos_order_items_order_idx on public.pos_order_items(order_id);
create index if not exists pos_order_items_status_idx on public.pos_order_items(operational_status);
create index if not exists pos_order_items_prep_area_idx on public.pos_order_items(prep_area);

create table if not exists public.pos_payments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.pos_orders(id) on delete cascade,
  method text not null check (method in ('cash', 'nequi', 'bank_transfer', 'card', 'other')),
  status text not null check (status in ('pending', 'confirmed', 'rejected')) default 'pending',
  allocation_mode text not null check (allocation_mode in ('total', 'amount', 'percentage', 'items')),
  amount_applied numeric not null check (amount_applied >= 0),
  amount_received numeric,
  change_due numeric,
  percentage_applied numeric,
  target_item_ids jsonb not null default '[]'::jsonb,
  reference text,
  notes text,
  created_at timestamptz not null default timezone('utc', now()),
  created_by_email text not null,
  confirmed_at timestamptz,
  confirmed_by_email text,
  rejected_at timestamptz,
  rejected_by_email text,
  rejection_reason text
);

create index if not exists pos_payments_order_idx on public.pos_payments(order_id);
create index if not exists pos_payments_status_idx on public.pos_payments(status);

create table if not exists public.pos_order_status_logs (
  id uuid primary key default gen_random_uuid(),
  table_id uuid references public.pos_tables(id) on delete cascade,
  order_id uuid references public.pos_orders(id) on delete cascade,
  order_item_id uuid references public.pos_order_items(id) on delete cascade,
  event_type text not null,
  actor_email text not null,
  actor_role text,
  created_at timestamptz not null default timezone('utc', now()),
  before_data jsonb,
  after_data jsonb,
  notes text
);

create index if not exists pos_order_status_logs_order_idx on public.pos_order_status_logs(order_id);
create index if not exists pos_order_status_logs_item_idx on public.pos_order_status_logs(order_item_id);
create index if not exists pos_order_status_logs_created_idx on public.pos_order_status_logs(created_at desc);

alter table public.staff_profiles enable row level security;
alter table public.staff_role_assignments enable row level security;
alter table public.pos_tables enable row level security;
alter table public.pos_orders enable row level security;
alter table public.pos_order_items enable row level security;
alter table public.pos_payments enable row level security;
alter table public.pos_order_status_logs enable row level security;

drop policy if exists "staff_profiles_read_self_or_admin" on public.staff_profiles;
create policy "staff_profiles_read_self_or_admin"
on public.staff_profiles
for select
using (
  public.is_catalog_admin()
  or lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
);

drop policy if exists "staff_profiles_manage_admin" on public.staff_profiles;
create policy "staff_profiles_manage_admin"
on public.staff_profiles
for all
using (public.is_catalog_admin())
with check (public.is_catalog_admin());

drop policy if exists "staff_roles_read_self_or_admin" on public.staff_role_assignments;
create policy "staff_roles_read_self_or_admin"
on public.staff_role_assignments
for select
using (
  public.is_catalog_admin()
  or lower(email) = lower(coalesce(auth.jwt() ->> 'email', ''))
);

drop policy if exists "staff_roles_manage_admin" on public.staff_role_assignments;
create policy "staff_roles_manage_admin"
on public.staff_role_assignments
for all
using (public.is_catalog_admin())
with check (public.is_catalog_admin());

drop policy if exists "pos_tables_staff_access" on public.pos_tables;
create policy "pos_tables_staff_access"
on public.pos_tables
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_orders_staff_access" on public.pos_orders;
create policy "pos_orders_staff_access"
on public.pos_orders
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_order_items_staff_access" on public.pos_order_items;
create policy "pos_order_items_staff_access"
on public.pos_order_items
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_payments_staff_access" on public.pos_payments;
create policy "pos_payments_staff_access"
on public.pos_payments
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_logs_staff_access" on public.pos_order_status_logs;
create policy "pos_logs_staff_access"
on public.pos_order_status_logs
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

grant select, insert, update on public.staff_profiles to authenticated;
grant select, insert, update on public.staff_role_assignments to authenticated;
grant select, insert, update, delete on public.pos_tables to authenticated;
grant select, insert, update on public.pos_orders to authenticated;
grant select, insert, update on public.pos_order_items to authenticated;
grant select, insert, update on public.pos_payments to authenticated;
grant select, insert, update on public.pos_order_status_logs to authenticated;
