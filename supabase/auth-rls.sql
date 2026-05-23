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

alter table public.menu_items enable row level security;
alter table public.menu_change_logs enable row level security;
alter table public.menu_snapshots enable row level security;
alter table public.admin_users enable row level security;

drop policy if exists "public_read_menu_items" on public.menu_items;
drop policy if exists "public_write_menu_items_transitional" on public.menu_items;
drop policy if exists "public_insert_menu_change_logs_transitional" on public.menu_change_logs;
drop policy if exists "public_read_menu_change_logs_transitional" on public.menu_change_logs;
drop policy if exists "public_insert_menu_snapshots_transitional" on public.menu_snapshots;
drop policy if exists "public_read_menu_snapshots_transitional" on public.menu_snapshots;

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

revoke all on public.menu_items from anon;
revoke all on public.menu_change_logs from anon;
revoke all on public.menu_snapshots from anon;
revoke all on public.admin_users from anon;

revoke all on public.menu_items from authenticated;
revoke all on public.menu_change_logs from authenticated;
revoke all on public.menu_snapshots from authenticated;
revoke all on public.admin_users from authenticated;

grant usage on schema public to anon, authenticated;
grant select on public.menu_items_public to anon, authenticated;
grant select on public.admin_users to authenticated;
grant select, insert, update on public.menu_items to authenticated;
grant select, insert on public.menu_change_logs to authenticated;
grant select, insert on public.menu_snapshots to authenticated;
