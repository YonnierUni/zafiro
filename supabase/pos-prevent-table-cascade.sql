-- Emergency patch: preserve POS sales data even when operational tables are
-- deleted/recreated during service.

create table if not exists public.pos_deleted_records_archive (
  id uuid primary key default gen_random_uuid(),
  archived_at timestamptz not null default timezone('utc', now()),
  source_table text not null,
  source_id uuid,
  row_data jsonb not null
);

create or replace function public.archive_pos_deleted_record()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.pos_deleted_records_archive (source_table, source_id, row_data)
  values (TG_TABLE_NAME, OLD.id, to_jsonb(OLD));

  return OLD;
end;
$$;

alter table public.pos_orders
  add column if not exists table_code_snapshot text,
  add column if not exists table_name_snapshot text;

update public.pos_orders o
set
  table_code_snapshot = coalesce(o.table_code_snapshot, t.code),
  table_name_snapshot = coalesce(o.table_name_snapshot, t.name)
from public.pos_tables t
where o.table_id = t.id
  and (o.table_code_snapshot is null or o.table_name_snapshot is null);

alter table public.pos_orders
  drop constraint if exists pos_orders_table_id_fkey;

alter table public.pos_orders
  alter column table_id drop not null;

alter table public.pos_orders
  add constraint pos_orders_table_id_fkey
  foreign key (table_id) references public.pos_tables(id) on delete set null;

alter table public.pos_order_items
  drop constraint if exists pos_order_items_order_id_fkey;

alter table public.pos_order_items
  add constraint pos_order_items_order_id_fkey
  foreign key (order_id) references public.pos_orders(id) on delete restrict;

alter table public.pos_payments
  drop constraint if exists pos_payments_order_id_fkey;

alter table public.pos_payments
  add constraint pos_payments_order_id_fkey
  foreign key (order_id) references public.pos_orders(id) on delete restrict;

alter table public.pos_order_status_logs
  drop constraint if exists pos_order_status_logs_table_id_fkey;

alter table public.pos_order_status_logs
  add constraint pos_order_status_logs_table_id_fkey
  foreign key (table_id) references public.pos_tables(id) on delete set null;

alter table public.pos_order_status_logs
  drop constraint if exists pos_order_status_logs_order_id_fkey;

alter table public.pos_order_status_logs
  add constraint pos_order_status_logs_order_id_fkey
  foreign key (order_id) references public.pos_orders(id) on delete set null;

alter table public.pos_order_status_logs
  drop constraint if exists pos_order_status_logs_order_item_id_fkey;

alter table public.pos_order_status_logs
  add constraint pos_order_status_logs_order_item_id_fkey
  foreign key (order_item_id) references public.pos_order_items(id) on delete set null;

drop trigger if exists trg_archive_deleted_pos_tables on public.pos_tables;
create trigger trg_archive_deleted_pos_tables
before delete on public.pos_tables
for each row execute function public.archive_pos_deleted_record();

drop trigger if exists trg_archive_deleted_pos_orders on public.pos_orders;
create trigger trg_archive_deleted_pos_orders
before delete on public.pos_orders
for each row execute function public.archive_pos_deleted_record();

drop trigger if exists trg_archive_deleted_pos_order_items on public.pos_order_items;
create trigger trg_archive_deleted_pos_order_items
before delete on public.pos_order_items
for each row execute function public.archive_pos_deleted_record();

drop trigger if exists trg_archive_deleted_pos_payments on public.pos_payments;
create trigger trg_archive_deleted_pos_payments
before delete on public.pos_payments
for each row execute function public.archive_pos_deleted_record();

drop trigger if exists trg_archive_deleted_pos_order_status_logs on public.pos_order_status_logs;
create trigger trg_archive_deleted_pos_order_status_logs
before delete on public.pos_order_status_logs
for each row execute function public.archive_pos_deleted_record();

grant select on public.pos_deleted_records_archive to authenticated;
