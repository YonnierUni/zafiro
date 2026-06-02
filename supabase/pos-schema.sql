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
  sales_session_id uuid,
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
  sales_session_id uuid,
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

create table if not exists public.pos_sales_sessions (
  id uuid primary key default gen_random_uuid(),
  session_label text not null,
  business_date date not null,
  status text not null check (status in ('open', 'closed')) default 'open',
  opened_at timestamptz not null default timezone('utc', now()),
  opened_by_email text not null,
  closed_at timestamptz,
  closed_by_email text,
  cutoff_hour integer not null default 18 check (cutoff_hour between 0 and 23),
  notes text not null default '',
  summary jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

drop trigger if exists trg_pos_sales_sessions_set_updated_at on public.pos_sales_sessions;
create trigger trg_pos_sales_sessions_set_updated_at
before update on public.pos_sales_sessions
for each row
execute function public.set_updated_at();

alter table public.pos_orders
  drop constraint if exists pos_orders_sales_session_id_fkey;

alter table public.pos_orders
  add constraint pos_orders_sales_session_id_fkey
  foreign key (sales_session_id) references public.pos_sales_sessions(id) on delete set null;

alter table public.pos_payments
  drop constraint if exists pos_payments_sales_session_id_fkey;

alter table public.pos_payments
  add constraint pos_payments_sales_session_id_fkey
  foreign key (sales_session_id) references public.pos_sales_sessions(id) on delete set null;

create index if not exists pos_orders_sales_session_idx on public.pos_orders(sales_session_id);
create index if not exists pos_payments_sales_session_idx on public.pos_payments(sales_session_id);
create index if not exists pos_sales_sessions_status_idx on public.pos_sales_sessions(status, opened_at desc);
create index if not exists pos_sales_sessions_business_date_idx on public.pos_sales_sessions(business_date desc);

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

create table if not exists public.pos_operational_flow_settings (
  area text primary key check (area in ('bar', 'kitchen')),
  use_in_process boolean not null default false,
  use_picking_up boolean not null default false,
  updated_at timestamptz not null default timezone('utc', now()),
  updated_by_email text
);

insert into public.pos_operational_flow_settings (area, use_in_process, use_picking_up)
values
  ('bar', false, false),
  ('kitchen', false, false)
on conflict (area) do nothing;

drop trigger if exists trg_pos_operational_flow_settings_set_updated_at on public.pos_operational_flow_settings;
create trigger trg_pos_operational_flow_settings_set_updated_at
before update on public.pos_operational_flow_settings
for each row
execute function public.set_updated_at();

create or replace function public.move_pos_active_order_to_table(
  source_table_id uuid,
  destination_table_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  actor_role text;
  source_table public.pos_tables%rowtype;
  destination_table public.pos_tables%rowtype;
  active_order public.pos_orders%rowtype;
  moved_at timestamptz := timezone('utc', now());
  before_payload jsonb;
  after_payload jsonb;
begin
  if actor_email = '' then
    raise exception 'No hay una sesion operativa valida para mover cuentas.';
  end if;

  if not (public.is_catalog_admin() or public.has_staff_role('waiter')) then
    raise exception 'Tu rol actual no puede mover cuentas entre mesas.';
  end if;

  if source_table_id = destination_table_id then
    raise exception 'Selecciona una mesa destino diferente a la mesa origen.';
  end if;

  perform 1
  from public.pos_tables
  where id in (source_table_id, destination_table_id)
  order by id
  for update;

  select *
  into source_table
  from public.pos_tables
  where id = source_table_id;

  if not found then
    raise exception 'No se encontro la mesa origen.';
  end if;

  select *
  into destination_table
  from public.pos_tables
  where id = destination_table_id;

  if not found then
    raise exception 'No se encontro la mesa destino.';
  end if;

  if source_table.active_order_id is null then
    raise exception 'La mesa origen no tiene una cuenta activa para trasladar.';
  end if;

  select *
  into active_order
  from public.pos_orders
  where id = source_table.active_order_id
  for update;

  if not found then
    raise exception 'No se encontro la orden activa asociada a la mesa origen.';
  end if;

  if active_order.closed_at is not null then
    raise exception 'No puedes mover una cuenta que ya esta cerrada.';
  end if;

  if active_order.table_id <> source_table.id then
    raise exception 'La cuenta activa no coincide con la mesa origen. Actualiza el POS e intenta de nuevo.';
  end if;

  if destination_table.status <> 'available' or destination_table.active_order_id is not null then
    raise exception 'La mesa destino no esta disponible. La fusion de mesas aun no esta habilitada.';
  end if;

  before_payload := jsonb_build_object(
    'movedAt', moved_at,
    'sourceTable', to_jsonb(source_table),
    'destinationTable', to_jsonb(destination_table),
    'order', to_jsonb(active_order)
  );

  update public.pos_orders
  set
    table_id = destination_table.id,
    assigned_staff_email = actor_email
  where id = active_order.id
  returning * into active_order;

  update public.pos_tables
  set
    active_order_id = null,
    assigned_staff_email = null,
    status = 'available'
  where id = source_table.id
  returning * into source_table;

  update public.pos_tables
  set
    active_order_id = active_order.id,
    assigned_staff_email = actor_email,
    status = 'occupied'
  where id = destination_table.id
  returning * into destination_table;

  actor_role := case
    when public.is_catalog_admin() then 'superadmin'
    when public.has_staff_role('waiter') then 'waiter'
    else null
  end;

  after_payload := jsonb_build_object(
    'movedAt', moved_at,
    'sourceTable', to_jsonb(source_table),
    'destinationTable', to_jsonb(destination_table),
    'order', to_jsonb(active_order)
  );

  insert into public.pos_order_status_logs (
    actor_email,
    actor_role,
    after_data,
    before_data,
    event_type,
    notes,
    order_id,
    table_id
  )
  values (
    actor_email,
    actor_role,
    after_payload,
    before_payload,
    'table_account_moved',
    'Cuenta trasladada de ' || source_table.code || ' a ' || destination_table.code,
    active_order.id,
    destination_table.id
  );

  return after_payload;
end;
$$;

create or replace function public.delete_pos_sales_session(
  sales_session_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  target_session public.pos_sales_sessions%rowtype;
  deleted_at timestamptz := timezone('utc', now());
begin
  if actor_email = '' then
    raise exception 'No hay una sesion valida para eliminar jornadas.';
  end if;

  if not public.is_catalog_admin() then
    raise exception 'Solo superadmin puede eliminar jornadas POS.';
  end if;

  select *
  into target_session
  from public.pos_sales_sessions
  where id = sales_session_id
  for update;

  if not found then
    raise exception 'No se encontro la jornada indicada.';
  end if;

  if target_session.status = 'open' then
    raise exception 'No puedes eliminar una jornada abierta. Cierrala primero.';
  end if;

  insert into public.pos_order_status_logs (
    actor_email,
    actor_role,
    before_data,
    event_type,
    notes
  )
  values (
    actor_email,
    'superadmin',
    jsonb_build_object(
      'deletedAt', deleted_at,
      'salesSession', to_jsonb(target_session)
    ),
    'sales_session_deleted',
    'Jornada eliminada del historial: ' || target_session.session_label
  );

  delete from public.pos_sales_sessions
  where id = target_session.id;

  return jsonb_build_object(
    'deletedAt', deleted_at,
    'salesSession', to_jsonb(target_session)
  );
end;
$$;

create or replace function public.rebuild_pos_sales_session_summary(
  target_sales_session_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  summary_payload jsonb;
begin
  if actor_email = '' then
    raise exception 'No hay una sesion valida para recalcular jornadas.';
  end if;

  if not public.is_catalog_admin() then
    raise exception 'Solo superadmin puede recalcular jornadas POS.';
  end if;

  with session_orders as (
    select *
    from public.pos_orders
    where sales_session_id = target_sales_session_id
  ),
  order_totals as (
    select
      o.id,
      o.closed_at,
      coalesce(sum(
        case
          when i.operational_status <> 'cancelled'
            and i.financial_status <> 'cancelled'
          then i.total_price
          else 0
        end
      ), 0) as total_due
    from session_orders o
    left join public.pos_order_items i on i.order_id = o.id
    group by o.id, o.closed_at
  ),
  payment_totals as (
    select
      o.id,
      coalesce(sum(case when p.status = 'confirmed' then p.amount_applied else 0 end), 0) as total_paid,
      count(p.id) filter (where p.status = 'pending') as pending_payments,
      count(p.id) filter (where p.status = 'confirmed') as confirmed_payments
    from session_orders o
    left join public.pos_payments p
      on p.order_id = o.id
      and p.sales_session_id = target_sales_session_id
    group by o.id
  ),
  products as (
    select coalesce(jsonb_agg(
      jsonb_build_object(
        'menuItemSourceKey', product_rows.menu_item_source_key,
        'prepArea', product_rows.prep_area,
        'productName', product_rows.product_name,
        'quantity', product_rows.quantity,
        'totalAmount', product_rows.total_amount
      )
      order by product_rows.quantity desc, product_rows.total_amount desc
    ), '[]'::jsonb) as products_json
    from (
      select
        i.menu_item_source_key,
        i.prep_area,
        i.product_name,
        sum(i.quantity)::integer as quantity,
        sum(i.total_price) as total_amount
      from session_orders o
      join public.pos_order_items i on i.order_id = o.id
      where i.operational_status <> 'cancelled'
        and i.financial_status <> 'cancelled'
      group by i.menu_item_source_key, i.prep_area, i.product_name
    ) product_rows
  ),
  payment_methods as (
    select coalesce(jsonb_agg(
      jsonb_build_object(
        'method', method_rows.method,
        'paymentCount', method_rows.payment_count,
        'totalAmount', method_rows.total_amount
      )
      order by method_rows.total_amount desc
    ), '[]'::jsonb) as methods_json
    from (
      select
        p.method,
        count(*)::integer as payment_count,
        sum(p.amount_applied) as total_amount
      from public.pos_payments p
      where p.sales_session_id = target_sales_session_id
        and p.status = 'confirmed'
      group by p.method
    ) method_rows
  )
  select jsonb_build_object(
    'confirmedPayments', coalesce((select sum(confirmed_payments) from payment_totals), 0),
    'deliveredProducts', coalesce((
      select sum(i.quantity)
      from session_orders o
      join public.pos_order_items i on i.order_id = o.id
      where i.operational_status = 'delivered'
        and i.financial_status <> 'cancelled'
    ), 0),
    'grossSales', coalesce((select sum(total_due) from order_totals), 0),
    'openOrders', coalesce((select count(*) from session_orders where closed_at is null), 0),
    'orderCount', coalesce((select count(*) from session_orders), 0),
    'paymentMethods', (select methods_json from payment_methods),
    'pendingBalance', coalesce((
      select sum(greatest(order_totals.total_due - payment_totals.total_paid, 0))
      from order_totals
      join payment_totals on payment_totals.id = order_totals.id
    ), 0),
    'pendingPayments', coalesce((select sum(pending_payments) from payment_totals), 0),
    'products', (select products_json from products),
    'totalCollected', coalesce((select sum(total_paid) from payment_totals), 0)
  )
  into summary_payload;

  update public.pos_sales_sessions
  set summary = summary_payload
  where id = target_sales_session_id;

  return summary_payload;
end;
$$;

create or replace function public.reassign_pos_order_sales_session(
  target_order_id uuid,
  destination_sales_session_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  target_order public.pos_orders%rowtype;
  source_session public.pos_sales_sessions%rowtype;
  destination_session public.pos_sales_sessions%rowtype;
  source_sales_session_id uuid;
  moved_at timestamptz := timezone('utc', now());
  source_summary jsonb;
  destination_summary jsonb;
begin
  if actor_email = '' then
    raise exception 'No hay una sesion valida para mover cuentas entre jornadas.';
  end if;

  if not public.is_catalog_admin() then
    raise exception 'Solo superadmin puede mover cuentas entre jornadas.';
  end if;

  select *
  into target_order
  from public.pos_orders
  where id = target_order_id
  for update;

  if not found then
    raise exception 'No se encontro la cuenta indicada.';
  end if;

  if target_order.closed_at is null then
    raise exception 'Solo puedes mover cuentas cerradas entre jornadas.';
  end if;

  source_sales_session_id := target_order.sales_session_id;

  if source_sales_session_id = destination_sales_session_id then
    raise exception 'La cuenta ya pertenece a esa jornada.';
  end if;

  if source_sales_session_id is not null then
    select *
    into source_session
    from public.pos_sales_sessions
    where id = source_sales_session_id
    for update;
  end if;

  select *
  into destination_session
  from public.pos_sales_sessions
  where id = destination_sales_session_id
  for update;

  if not found then
    raise exception 'No se encontro la jornada destino.';
  end if;

  update public.pos_orders
  set sales_session_id = destination_session.id
  where id = target_order.id;

  update public.pos_payments
  set sales_session_id = destination_session.id
  where order_id = target_order.id;

  if source_sales_session_id is not null then
    source_summary := public.rebuild_pos_sales_session_summary(source_sales_session_id);
  end if;

  destination_summary := public.rebuild_pos_sales_session_summary(destination_session.id);

  insert into public.pos_order_status_logs (
    actor_email,
    actor_role,
    after_data,
    before_data,
    event_type,
    notes,
    order_id,
    table_id
  )
  values (
    actor_email,
    'superadmin',
    jsonb_build_object(
      'movedAt', moved_at,
      'destinationSalesSession', to_jsonb(destination_session),
      'destinationSummary', destination_summary,
      'sourceSummary', source_summary
    ),
    jsonb_build_object(
      'order', to_jsonb(target_order),
      'sourceSalesSession', case when source_sales_session_id is null then null else to_jsonb(source_session) end
    ),
    'order_sales_session_reassigned',
    'Cuenta movida a jornada ' || destination_session.session_label,
    target_order.id,
    target_order.table_id
  );

  return jsonb_build_object(
    'movedAt', moved_at,
    'destinationSalesSession', to_jsonb(destination_session),
    'destinationSummary', destination_summary,
    'orderId', target_order.id,
    'sourceSalesSessionId', source_sales_session_id,
    'sourceSummary', source_summary
  );
end;
$$;

create or replace function public.create_pos_sales_session_manual(
  manual_business_date date,
  manual_opened_at timestamptz,
  manual_closed_at timestamptz,
  manual_session_label text default null,
  manual_notes text default ''
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  created_session public.pos_sales_sessions%rowtype;
  normalized_label text;
begin
  if actor_email = '' then
    raise exception 'No hay una sesion valida para crear jornadas manuales.';
  end if;

  if not public.is_catalog_admin() then
    raise exception 'Solo superadmin puede crear jornadas POS manuales.';
  end if;

  if manual_closed_at <= manual_opened_at then
    raise exception 'La fecha de cierre debe ser posterior a la fecha de apertura.';
  end if;

  normalized_label := coalesce(nullif(trim(manual_session_label), ''), 'Jornada ' || manual_business_date::text);

  insert into public.pos_sales_sessions (
    business_date,
    closed_at,
    closed_by_email,
    cutoff_hour,
    notes,
    opened_at,
    opened_by_email,
    session_label,
    status,
    summary
  )
  values (
    manual_business_date,
    manual_closed_at,
    actor_email,
    18,
    coalesce(manual_notes, ''),
    manual_opened_at,
    actor_email,
    normalized_label,
    'closed',
    '{}'::jsonb
  )
  returning * into created_session;

  perform public.rebuild_pos_sales_session_summary(created_session.id);

  insert into public.pos_order_status_logs (
    actor_email,
    actor_role,
    after_data,
    event_type,
    notes
  )
  values (
    actor_email,
    'superadmin',
    to_jsonb(created_session),
    'sales_session_manual_created',
    'Jornada manual creada: ' || created_session.session_label
  );

  return to_jsonb(created_session);
end;
$$;

create or replace function public.update_pos_sales_session_window(
  sales_session_id uuid,
  manual_business_date date,
  manual_opened_at timestamptz,
  manual_closed_at timestamptz,
  manual_session_label text default null,
  manual_notes text default null
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  actor_email text := lower(coalesce(auth.jwt() ->> 'email', ''));
  before_session public.pos_sales_sessions%rowtype;
  updated_session public.pos_sales_sessions%rowtype;
  normalized_label text;
begin
  if actor_email = '' then
    raise exception 'No hay una sesion valida para ajustar jornadas.';
  end if;

  if not public.is_catalog_admin() then
    raise exception 'Solo superadmin puede ajustar jornadas POS.';
  end if;

  if manual_closed_at <= manual_opened_at then
    raise exception 'La fecha de cierre debe ser posterior a la fecha de apertura.';
  end if;

  select *
  into before_session
  from public.pos_sales_sessions
  where id = sales_session_id
  for update;

  if not found then
    raise exception 'No se encontro la jornada indicada.';
  end if;

  normalized_label := coalesce(nullif(trim(manual_session_label), ''), before_session.session_label, 'Jornada ' || manual_business_date::text);

  update public.pos_sales_sessions
  set
    business_date = manual_business_date,
    closed_at = manual_closed_at,
    closed_by_email = coalesce(closed_by_email, actor_email),
    notes = coalesce(manual_notes, notes),
    opened_at = manual_opened_at,
    session_label = normalized_label,
    status = 'closed'
  where id = before_session.id
  returning * into updated_session;

  perform public.rebuild_pos_sales_session_summary(updated_session.id);

  insert into public.pos_order_status_logs (
    actor_email,
    actor_role,
    after_data,
    before_data,
    event_type,
    notes
  )
  values (
    actor_email,
    'superadmin',
    to_jsonb(updated_session),
    to_jsonb(before_session),
    'sales_session_window_updated',
    'Fechas de jornada ajustadas: ' || updated_session.session_label
  );

  return to_jsonb(updated_session);
end;
$$;

alter table public.staff_profiles enable row level security;
alter table public.staff_role_assignments enable row level security;
alter table public.pos_tables enable row level security;
alter table public.pos_orders enable row level security;
alter table public.pos_order_items enable row level security;
alter table public.pos_payments enable row level security;
alter table public.pos_sales_sessions enable row level security;
alter table public.pos_order_status_logs enable row level security;
alter table public.pos_operational_flow_settings enable row level security;

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

drop policy if exists "pos_sales_sessions_staff_access" on public.pos_sales_sessions;
create policy "pos_sales_sessions_staff_access"
on public.pos_sales_sessions
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_logs_staff_access" on public.pos_order_status_logs;
create policy "pos_logs_staff_access"
on public.pos_order_status_logs
for all
using (public.is_pos_staff())
with check (public.is_pos_staff());

drop policy if exists "pos_operational_flow_settings_staff_read" on public.pos_operational_flow_settings;
create policy "pos_operational_flow_settings_staff_read"
on public.pos_operational_flow_settings
for select
using (public.is_pos_staff());

drop policy if exists "pos_operational_flow_settings_admin_manage" on public.pos_operational_flow_settings;
create policy "pos_operational_flow_settings_admin_manage"
on public.pos_operational_flow_settings
for all
using (public.is_catalog_admin())
with check (public.is_catalog_admin());

grant select, insert, update on public.staff_profiles to authenticated;
grant select, insert, update on public.staff_role_assignments to authenticated;
grant select, insert, update, delete on public.pos_tables to authenticated;
grant select, insert, update on public.pos_orders to authenticated;
grant select, insert, update on public.pos_order_items to authenticated;
grant select, insert, update on public.pos_payments to authenticated;
grant select, insert, update on public.pos_sales_sessions to authenticated;
grant select, insert, update on public.pos_order_status_logs to authenticated;
grant select, insert, update on public.pos_operational_flow_settings to authenticated;
grant execute on function public.move_pos_active_order_to_table(uuid, uuid) to authenticated;
grant execute on function public.delete_pos_sales_session(uuid) to authenticated;
grant execute on function public.rebuild_pos_sales_session_summary(uuid) to authenticated;
grant execute on function public.reassign_pos_order_sales_session(uuid, uuid) to authenticated;
grant execute on function public.create_pos_sales_session_manual(date, timestamptz, timestamptz, text, text) to authenticated;
grant execute on function public.update_pos_sales_session_window(uuid, date, timestamptz, timestamptz, text, text) to authenticated;
