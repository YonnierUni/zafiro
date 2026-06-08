-- POS recovery inspection.
-- Run this in Supabase SQL Editor. It does not modify data.

-- 1) Current surviving row counts.
select 'pos_sales_sessions' as table_name, count(*) as rows from public.pos_sales_sessions
union all
select 'pos_tables', count(*) from public.pos_tables
union all
select 'pos_orders', count(*) from public.pos_orders
union all
select 'pos_order_items', count(*) from public.pos_order_items
union all
select 'pos_payments', count(*) from public.pos_payments
union all
select 'pos_order_status_logs', count(*) from public.pos_order_status_logs
union all
select 'pos_deleted_records_archive', count(*) from public.pos_deleted_records_archive;

-- 2) Surviving deletion/table logs. These can identify who deleted which table and when.
select
  id,
  created_at,
  actor_email,
  actor_role,
  event_type,
  notes,
  before_data,
  after_data
from public.pos_order_status_logs
where event_type in ('table_deleted', 'sales_session_deleted')
   or notes ilike '%elimin%'
order by created_at desc;

-- 3) Surviving sales-session close logs. These often keep aggregate summaries even if order rows are gone.
select
  id,
  created_at,
  actor_email,
  event_type,
  after_data ->> 'id' as sales_session_id,
  after_data ->> 'session_label' as session_label,
  after_data -> 'summary' as summary
from public.pos_order_status_logs
where event_type = 'sales_session_closed'
order by created_at desc;

-- 4) Current session summaries saved in pos_sales_sessions.
select
  id,
  session_label,
  business_date,
  status,
  opened_at,
  closed_at,
  summary
from public.pos_sales_sessions
order by opened_at desc;

-- 5) Payments that survived, grouped by session.
select
  sales_session_id,
  status,
  method,
  count(*) as payment_count,
  sum(amount_applied) as total_amount,
  min(created_at) as first_payment_at,
  max(created_at) as last_payment_at
from public.pos_payments
group by sales_session_id, status, method
order by last_payment_at desc;

-- 6) Orders that survived, with current items/payments totals.
-- Items and payments are aggregated separately to avoid multiplying amounts
-- when an order has multiple items and multiple payments.
with item_totals as (
  select
    order_id,
    coalesce(sum(total_price) filter (
      where operational_status <> 'cancelled'
        and financial_status <> 'cancelled'
    ), 0) as item_total,
    count(*) as item_count
  from public.pos_order_items
  group by order_id
),
payment_totals as (
  select
    order_id,
    coalesce(sum(amount_applied) filter (where status = 'confirmed'), 0) as confirmed_paid,
    count(*) as payment_count
  from public.pos_payments
  group by order_id
)
select
  o.id,
  o.sales_session_id,
  o.table_id,
  o.table_code_snapshot,
  o.table_name_snapshot,
  o.opened_at,
  o.closed_at,
  o.financial_status,
  coalesce(i.item_total, 0) as item_total,
  coalesce(p.confirmed_paid, 0) as confirmed_paid,
  coalesce(i.item_count, 0) as item_count,
  coalesce(p.payment_count, 0) as payment_count
from public.pos_orders o
left join item_totals i on i.order_id = o.id
left join payment_totals p on p.order_id = o.id
order by o.opened_at desc;

-- 7) Integrity checks after recovery.
select
  'orders_without_sales_session' as check_name,
  count(*)::numeric as value
from public.pos_orders
where sales_session_id is null
union all
select
  'orders_missing_items_but_not_cancelled',
  count(*)::numeric
from public.pos_orders o
where o.financial_status <> 'cancelled'
  and not exists (
    select 1 from public.pos_order_items i where i.order_id = o.id
  )
union all
select
  'paid_orders_missing_confirmed_payment',
  count(*)::numeric
from public.pos_orders o
where o.financial_status = 'paid_total'
  and not exists (
    select 1 from public.pos_payments p
    where p.order_id = o.id
      and p.status = 'confirmed'
  )
union all
select
  'business_date_2026_05_25_sessions',
  count(*)::numeric
from public.pos_sales_sessions
where business_date = '2026-05-25'::date
union all
select
  'business_date_2026_06_02_sessions',
  count(*)::numeric
from public.pos_sales_sessions
where business_date = '2026-06-02'::date
union all
select
  'business_date_2026_05_27_sessions',
  count(*)::numeric
from public.pos_sales_sessions
where business_date = '2026-05-27'::date;

-- 8) Orders without a linked sales session. Review before repairing because
-- some may be old surviving rows or duplicates outside a valid jornada window.
select
  id,
  sales_session_id,
  table_id,
  table_code_snapshot,
  table_name_snapshot,
  opened_at,
  closed_at,
  financial_status
from public.pos_orders
where sales_session_id is null
order by opened_at;

-- 9) Archive rows captured after installing pos-prevent-table-cascade.sql.
select
  archived_at,
  source_table,
  source_id,
  row_data
from public.pos_deleted_records_archive
order by archived_at desc;
