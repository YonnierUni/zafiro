-- Unified POS recovery from all CSV exports.
-- Conservative mode: DOES NOT DELETE rows. It upserts sessions/orders and inserts only missing CSV products/payments by content and occurrence.
-- STOP: do not run again after the duplicate recovery incident. Use pos-recovery-soft-reconcile-duplicates.sql first.


begin;

create table if not exists public.pos_deleted_records_archive (id uuid primary key default gen_random_uuid(), archived_at timestamptz not null default timezone('utc', now()), source_table text not null, source_id uuid, row_data jsonb not null);

-- Upsert official sessions recovered from exports.

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('929b3f56-e936-4e8c-8183-962bd63115d4', 'Jornada 2026-05-22', '2026-05-22'::date, 'closed', '2026-05-23T07:02:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-23T08:37:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-22 - abierta 23/05/2026, 02:02 a. m. - cerrada 23/05/2026, 03:37 a. m.', '{"confirmedPayments": 5, "deliveredProducts": 18, "grossSales": 347000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "nequi", "paymentCount": 4, "totalAmount": 328000}, {"method": "cash", "paymentCount": 1, "totalAmount": 19000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Budweiser (4)", "ticket": 86750}, "totalCollected": 347000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'Jornada 2026-05-23', '2026-05-23'::date, 'closed', '2026-05-24T00:19:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-24T07:11:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-23 - abierta 23/05/2026, 07:19 p. m. - cerrada 24/05/2026, 02:11 a. m.', '{"confirmedPayments": 10, "deliveredProducts": 31, "grossSales": 383000, "openOrders": 0, "orderCount": 5, "paymentMethods": [{"method": "nequi", "paymentCount": 4, "totalAmount": 136000}, {"method": "bank_transfer", "paymentCount": 3, "totalAmount": 111000}, {"method": "cash", "paymentCount": 3, "totalAmount": 93000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Speed Max (5)", "ticket": 76600}, "totalCollected": 383000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'Jornada 2026-05-24', '2026-05-24'::date, 'closed', '2026-05-25T01:20:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-25T05:54:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-24 - abierta 24/05/2026, 08:20 p. m. - cerrada 25/05/2026, 12:54 a. m.', '{"confirmedPayments": 2, "deliveredProducts": 9, "grossSales": 142000, "openOrders": 0, "orderCount": 1, "paymentMethods": [{"method": "nequi", "paymentCount": 1, "totalAmount": 132000}, {"method": "cash", "paymentCount": 1, "totalAmount": 10000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Ãguila Original (2)", "ticket": 142000}, "totalCollected": 142000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'Jornada 2026-05-26', '2026-05-26'::date, 'closed', '2026-05-27T04:44:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-29T06:30:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-26 - abierta 26/05/2026, 11:44 p. m. - cerrada 29/05/2026, 01:30 a. m.', '{"confirmedPayments": 7, "deliveredProducts": 12, "grossSales": 98000, "openOrders": 0, "orderCount": 5, "paymentMethods": [{"method": "nequi", "paymentCount": 5, "totalAmount": 88000}, {"method": "cash", "paymentCount": 2, "totalAmount": 10000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Corona (2)", "ticket": 19600}, "totalCollected": 98000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('48866b4b-c259-4cb0-916a-16e888a57408', 'Jornada 2026-05-27', '2026-05-27'::date, 'closed', '2026-05-28T00:00:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-28T07:00:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-27 - abierta 27/05/2026, 07:00 p. m. - cerrada 28/05/2026, 02:00 a. m.', '{"confirmedPayments": 0, "deliveredProducts": 0, "grossSales": 0, "openOrders": 0, "orderCount": 0, "paymentMethods": [], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Sin ventas", "ticket": 0}, "totalCollected": 0}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('a514e729-b6e1-437c-b0ce-ae6d8d81be15', 'Jornada 2026-05-28', '2026-05-28'::date, 'closed', '2026-05-29T00:00:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-29T07:00:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-28 - abierta 28/05/2026, 07:00 p. m. - cerrada 29/05/2026, 02:00 a. m.', '{"confirmedPayments": 1, "deliveredProducts": 4, "grossSales": 51000, "openOrders": 0, "orderCount": 1, "paymentMethods": [{"method": "nequi", "paymentCount": 1, "totalAmount": 51000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Reina Pepiada (1)", "ticket": 51000}, "totalCollected": 51000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'Jornada 2026-05-29', '2026-05-29'::date, 'closed', '2026-05-30T00:26:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-30T07:12:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-29 - abierta 29/05/2026, 07:26 p. m. - cerrada 30/05/2026, 02:12 a. m.', '{"confirmedPayments": 6, "deliveredProducts": 13, "grossSales": 165000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "nequi", "paymentCount": 3, "totalAmount": 73000}, {"method": "cash", "paymentCount": 3, "totalAmount": 92000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Michelada Premium Frutal (2)", "ticket": 41250}, "totalCollected": 165000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('0fc2cad5-1577-4f77-83b2-b5690998e06f', 'Jornada 2026-05-30', '2026-05-30'::date, 'closed', '2026-05-31T00:10:00+00'::timestamptz, 'recovery@zafiro.local', '2026-05-31T05:56:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-30 - abierta 30/05/2026, 07:10 p. m. - cerrada 31/05/2026, 12:56 a. m.', '{"confirmedPayments": 6, "deliveredProducts": 18, "grossSales": 276000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "cash", "paymentCount": 1, "totalAmount": 5000}, {"method": "other", "paymentCount": 1, "totalAmount": 5000}, {"method": "nequi", "paymentCount": 3, "totalAmount": 188000}, {"method": "bank_transfer", "paymentCount": 1, "totalAmount": 78000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "La Reina Doble (2)", "ticket": 69000}, "totalCollected": 276000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('ac8bcbaf-23dd-4673-8200-7fe06338843f', 'Jornada 2026-05-31', '2026-05-31'::date, 'closed', '2026-06-01T01:01:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-02T00:29:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-05-31 - abierta 31/05/2026, 08:01 p. m. - cerrada 01/06/2026, 07:29 p. m.', '{"confirmedPayments": 7, "deliveredProducts": 24, "grossSales": 358000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "nequi", "paymentCount": 3, "totalAmount": 150000}, {"method": "cash", "paymentCount": 2, "totalAmount": 35000}, {"method": "bank_transfer", "paymentCount": 2, "totalAmount": 173000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Jugo de Lulo en Agua (4)", "ticket": 89500}, "totalCollected": 358000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'Jornada 2026-06-01', '2026-06-01'::date, 'closed', '2026-06-02T00:29:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-02T06:11:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-06-01 - abierta 01/06/2026, 07:29 p. m. - cerrada 02/06/2026, 01:11 a. m.', '{"confirmedPayments": 7, "deliveredProducts": 12, "grossSales": 135000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "cash", "paymentCount": 2, "totalAmount": 13000}, {"method": "nequi", "paymentCount": 4, "totalAmount": 96000}, {"method": "bank_transfer", "paymentCount": 1, "totalAmount": 26000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Jugo Hit Surtido (2)", "ticket": 33750}, "totalCollected": 135000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('2e4d61ae-d48a-429a-9d56-d7538abab917', 'Jornada 2026-06-03', '2026-06-03'::date, 'closed', '2026-06-04T00:00:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-04T07:51:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-06-03 - abierta 03/06/2026, 07:00 p. m. - cerrada 04/06/2026, 02:51 a. m.', '{"confirmedPayments": 10, "deliveredProducts": 34, "grossSales": 440000, "openOrders": 0, "orderCount": 4, "paymentMethods": [{"method": "bank_transfer", "paymentCount": 2, "totalAmount": 145000}, {"method": "nequi", "paymentCount": 4, "totalAmount": 86000}, {"method": "cash", "paymentCount": 4, "totalAmount": 209000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Ãguila Original (7)", "ticket": 110000}, "totalCollected": 440000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'Jornada 2026-06-04', '2026-06-04'::date, 'closed', '2026-06-05T00:06:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-05T06:48:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-06-04 - abierta 04/06/2026, 07:06 p. m. - cerrada 05/06/2026, 01:48 a. m.', '{"confirmedPayments": 9, "deliveredProducts": 20, "grossSales": 270000, "openOrders": 0, "orderCount": 2, "paymentMethods": [{"method": "nequi", "paymentCount": 8, "totalAmount": 252000}, {"method": "cash", "paymentCount": 1, "totalAmount": 18000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Mojito (4)", "ticket": 135000}, "totalCollected": 270000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('3c2b9df9-1250-4800-ad1c-610b8d5eb4a3', 'Jornada 2026-06-05', '2026-06-05'::date, 'closed', '2026-06-05T23:35:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-06T06:29:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-06-05 - abierta 05/06/2026, 06:35 p. m. - cerrada 06/06/2026, 01:29 a. m.', '{"confirmedPayments": 1, "deliveredProducts": 1, "grossSales": 5000, "openOrders": 0, "orderCount": 1, "paymentMethods": [{"method": "nequi", "paymentCount": 1, "totalAmount": 5000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Jugo Hit Surtido (1)", "ticket": 5000}, "totalCollected": 5000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'Jornada 2026-06-06', '2026-06-06'::date, 'closed', '2026-06-07T00:43:00+00'::timestamptz, 'recovery@zafiro.local', '2026-06-07T07:32:00+00'::timestamptz, 'recovery@zafiro.local', 18, 'Recuperada desde export HTML/CSV. 2026-06-06 - abierta 06/06/2026, 07:43 p. m. - cerrada 07/06/2026, 02:32 a. m.', '{"confirmedPayments": 13, "deliveredProducts": 51, "grossSales": 804000, "openOrders": 0, "orderCount": 2, "paymentMethods": [{"method": "nequi", "paymentCount": 7, "totalAmount": 425000}, {"method": "cash", "paymentCount": 6, "totalAmount": 379000}], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Corona (5)", "ticket": 402000}, "totalCollected": 804000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

-- Upsert CSV orders into their proper jornada. Existing rows are preserved; session/table snapshots are repaired if needed.

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('04259209-f015-47b9-b1df-9aa324dc4d8f', null, 'M-03', 'Mesa 3', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'paid_total', '2026-06-02T00:29:00+00'::timestamptz, '2026-06-02T06:02:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 02/06/2026, 01:02 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('0465fded-62e7-4331-8c86-7ca920fe5006', null, 'M-01', 'Mesa 01', '929b3f56-e936-4e8c-8183-962bd63115d4', 'paid_total', '2026-05-23T07:02:00+00'::timestamptz, '2026-05-23T08:04:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 03:04 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('0470d9df-4237-4811-9ef8-d2a40e1d6371', null, 'T-05', 'Terraza 5', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-29T04:39:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 28/05/2026, 11:39 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'T-02', 'Terraza 2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T04:20:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 11:20 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('0645f808-4bf6-42d4-b059-82e729773888', null, 'B-02', 'Barra 2', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T06:42:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 01:42 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'T-01', 'Terraza 01', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T03:59:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 10:59 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('0b98d323-e92f-452b-97ae-82215314a9fb', null, 'T-03', 'Terraza 3', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'paid_total', '2026-05-25T01:20:00+00'::timestamptz, '2026-05-25T02:20:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 09:20 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('10c11ad2-3dc7-4ffa-ad2e-589948d5f646', null, 'VIP-01', 'VIP 01', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T05:06:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 12:06 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('14a32cde-5e31-478f-84f4-dc281012ebb3', null, 'M-02', 'Mesa 2', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T03:16:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 03/06/2026, 10:16 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('153e1b85-3e78-4f62-bbb9-a1ce34b5b724', null, 'B-01', 'Barra 01', '929b3f56-e936-4e8c-8183-962bd63115d4', 'paid_total', '2026-05-23T07:02:00+00'::timestamptz, '2026-05-23T08:04:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 03:04 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('173aadce-cba6-453d-92da-5fe26a21e69d', null, 'M-02', 'Mesa 2', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T07:00:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 02:00 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'B-02', 'Barra 2', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T06:58:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 01:58 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'T-06', 'Terraza 6', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T06:03:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 01:03 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('1fc00905-31b6-429f-873f-1a4e58303669', null, 'B-02', 'Barra 2', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T01:58:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 08:58 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('26e809e6-d86a-47ed-8339-85708600a40e', null, 'T-06', 'Terraza 6', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T03:41:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 10:41 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('2f0a2ca0-a496-45c2-804b-11d4c3957218', null, 'VIP-01', 'VIP 01', '929b3f56-e936-4e8c-8183-962bd63115d4', 'paid_total', '2026-05-23T07:02:00+00'::timestamptz, '2026-05-23T08:09:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 03:09 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('355daae2-f2de-48be-814e-d4580a858e4c', null, 'T-03', 'Terraza 3', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T01:54:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 08:54 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('3e614951-a4c6-419e-a389-66520337da5a', null, 'T-01', 'Terraza 01', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'paid_total', '2026-06-02T00:29:00+00'::timestamptz, '2026-06-02T06:06:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 02/06/2026, 01:06 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('46142a57-894a-42d7-81d1-82f06a88e20f', null, 'M-02', 'Mesa 2', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'paid_total', '2026-06-05T00:06:00+00'::timestamptz, '2026-06-05T06:07:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 05/06/2026, 01:07 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('46503d83-e948-46eb-a5d6-7cc57b192414', null, 'T-05', 'Terraza 5', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T02:10:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 09:10 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'B-01', 'Barra 01', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T02:34:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 09:34 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('4ea5e71f-f2d4-47c9-b77f-e04248d8f668', null, 'T-03', 'Terraza 3', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-30T00:26:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 29/05/2026, 07:26 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('50a53517-864f-44d9-b9c9-516dd21f05d8', null, 'VIP-01', 'VIP 01', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T07:02:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 02:02 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('522f035f-d137-4845-8013-1640b4e97758', null, 'B-01', 'Barra 01', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T06:41:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 01:41 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('54388ffc-8714-412a-bb98-73e13e89edab', null, 'T-05', 'Terraza 5', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T03:55:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 10:55 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'T-05', 'Terraza 5', '929b3f56-e936-4e8c-8183-962bd63115d4', 'paid_total', '2026-05-23T07:02:00+00'::timestamptz, '2026-05-23T08:00:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 03:00 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('593359c4-ceb7-4f02-b2cf-46d259202acb', null, 'T-03', 'Terraza 3', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T03:43:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 10:43 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('5f6c36a6-ea72-434c-a531-0d40271d99dc', null, 'B-01', 'Barra 01', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T05:41:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 12:41 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('681314b0-53d7-4c32-8213-1a804cb304c5', null, 'T-03', 'Terraza 3', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T04:09:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 11:09 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'T-05', 'Terraza 5', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T05:06:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 12:06 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('695c6444-6e6d-474e-b599-646c930484ed', null, 'VIP-01', 'VIP 01', '929b3f56-e936-4e8c-8183-962bd63115d4', 'paid_total', '2026-05-23T07:02:00+00'::timestamptz, '2026-05-23T08:37:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 23/05/2026, 03:37 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('69cfc190-78db-4eda-bcb2-3dd821844091', null, 'M-01', 'Mesa 01', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T02:58:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 09:58 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'T-03', 'Terraza 3', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T02:51:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 29/05/2026, 09:51 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'M-02', 'Mesa 2', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T05:04:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 12:04 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'T-03', 'Terraza 3', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T06:30:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 01:30 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('72698c72-61db-4294-ad32-743bfba0af3e', null, 'VIP-01', 'VIP 01', '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3', 'paid_total', '2026-06-05T23:35:00+00'::timestamptz, '2026-06-06T06:29:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 01:29 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('78c8e74c-48be-4d0b-a996-525d33f70fbb', null, 'VIP-01', 'VIP 01', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-29T03:50:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 28/05/2026, 10:50 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'VIP-01', 'VIP 01', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'paid_total', '2026-06-02T00:29:00+00'::timestamptz, '2026-06-02T06:05:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 02/06/2026, 01:05 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('7cefad24-a203-455e-932a-5c564f2a3624', null, 'B-01', 'Barra 01', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-29T02:45:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 28/05/2026, 09:45 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('825d025e-65de-4a28-a56d-474796cd8a31', null, 'T-06', 'Terraza 6', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'paid_total', '2026-06-02T00:29:00+00'::timestamptz, '2026-06-02T03:44:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 01/06/2026, 10:44 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('83811ff2-6a42-4042-83cf-fbb14b1a05a4', null, 'B-01', 'Barra 01', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'paid_total', '2026-05-25T01:20:00+00'::timestamptz, '2026-05-25T01:21:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 08:21 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'T-04', 'Terraza 4', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T03:41:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 10:41 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', null, 'B-01', 'Barra 01', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T02:24:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 09:24 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'T-06', 'Terraza 6', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'paid_total', '2026-06-05T00:06:00+00'::timestamptz, '2026-06-05T06:04:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 05/06/2026, 01:04 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'B-01', 'Barra 01', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T04:08:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 29/05/2026, 11:08 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('8a16e76b-ffb9-406f-b437-b089915b6994', null, 'T-06', 'Terraza 6', 'a514e729-b6e1-437c-b0ce-ae6d8d81be15', 'paid_total', '2026-05-29T00:00:00+00'::timestamptz, '2026-05-29T04:38:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 28/05/2026, 11:38 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('8c340a3b-fac0-46f3-8996-5a3fb6678feb', null, 'T-01', 'Terraza 01', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-27T06:01:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 27/05/2026, 01:01 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('90df6e99-c8ae-4678-a816-d347955de1dd', null, 'VIP-01', 'VIP 01', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T06:06:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 01:06 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('99e279d9-995c-4c05-9c55-5b89814a6d09', null, 'B-01', 'Barra 01', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T05:17:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 01/06/2026, 12:17 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'T-05', 'Terraza 5', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T05:05:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 07/06/2026, 12:05 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('9fbd6c34-66a7-40a0-9b50-969dc0d17abb', null, 'T-03', 'Terraza 3', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'paid_total', '2026-06-05T00:06:00+00'::timestamptz, '2026-06-05T02:01:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 09:01 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('a113fef6-fb98-4260-9070-80042910f289', null, 'T-03', 'Terraza 3', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T02:05:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 09:05 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('a15b8cf8-8e34-4cf6-bc1f-9b638aba7203', null, 'B-03', 'Barra 3', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T06:40:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 01:40 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('a4ae9670-f0b4-4638-b02b-fb9f33dde038', null, 'T-02', 'Terraza 2', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'paid_total', '2026-06-05T00:06:00+00'::timestamptz, '2026-06-05T01:21:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 08:21 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', null, 'B-02', 'Barra 2', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T06:06:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 01:06 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'T-01', 'Terraza 01', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T06:02:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 01:02 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d', null, 'VIP-01', 'VIP 01', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'paid_total', '2026-06-05T00:06:00+00'::timestamptz, '2026-06-05T06:47:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 05/06/2026, 01:47 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('b4f8f126-4265-416e-8628-e965db52d100', null, 'VIP-01', 'VIP 01', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T06:43:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 01:43 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('b8d45027-1623-4281-8a4c-5e1303f67563', null, 'T-03', 'Terraza 3', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T02:09:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 31/05/2026, 09:09 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'M-03', 'Mesa 3', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'paid_total', '2026-05-31T00:10:00+00'::timestamptz, '2026-05-31T02:03:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 09:03 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('bacf03d0-c7c3-492a-96eb-fb897a0297dc', null, 'VIP-01', 'VIP 01', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'paid_total', '2026-06-01T01:01:00+00'::timestamptz, '2026-06-01T06:20:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 01/06/2026, 01:20 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('cd11c35c-1fba-4398-84b9-7a4b90bacbab', null, 'B-01', 'Barra 01', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-29T04:41:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 28/05/2026, 11:41 p. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('d38f98b4-16e3-40f2-81d7-d97f1dbd4da9', null, 'T-06', 'Terraza 6', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'paid_total', '2026-05-30T00:26:00+00'::timestamptz, '2026-05-30T06:42:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 30/05/2026, 01:42 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('d9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'T-04', 'Terraza 4', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T06:12:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 04/06/2026, 01:12 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'T-02', 'Terraza 2', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T04:31:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 03/06/2026, 11:31 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'T-03', 'Terraza 3', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T04:16:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 06/06/2026, 11:16 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('ec4580a9-70e8-4eb4-be68-75cd70717cd5', null, 'T-05', 'Terraza 5', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T06:02:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 07/06/2026, 01:02 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('f1c42de6-4389-43fc-9613-23a252d3b063', null, 'B-01', 'Barra 01', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'paid_total', '2026-06-02T00:29:00+00'::timestamptz, '2026-06-02T06:11:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 02/06/2026, 01:11 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('f49a1572-86cd-48d8-86b1-89ead2157652', null, 'B-01', 'Barra 01', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'paid_total', '2026-05-24T00:19:00+00'::timestamptz, '2026-05-24T06:56:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 24/05/2026, 01:56 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'T-06', 'Terraza 6', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'paid_total', '2026-06-07T00:43:00+00'::timestamptz, '2026-06-07T07:30:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 07/06/2026, 02:30 a.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('faebbf42-ace3-47f9-9df3-2d23b2e76e79', null, 'B-01', 'Barra 01', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'paid_total', '2026-05-27T04:44:00+00'::timestamptz, '2026-05-27T05:50:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 27/05/2026, 12:50 a. m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

insert into public.pos_orders (id, table_id, table_code_snapshot, table_name_snapshot, sales_session_id, financial_status, opened_at, closed_at, opened_by_email, assigned_staff_email, cashier_email, notes)
values ('fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'B-04', 'Barra 4', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'paid_total', '2026-06-04T00:00:00+00'::timestamptz, '2026-06-04T03:13:00+00'::timestamptz, 'recovery@zafiro.local', 'recovery@zafiro.local', 'recovery@zafiro.local', 'Recuperada desde CSV. Cierre visible: 03/06/2026, 10:13 p.m.')
on conflict (id) do update set sales_session_id = excluded.sales_session_id, table_code_snapshot = excluded.table_code_snapshot, table_name_snapshot = excluded.table_name_snapshot, financial_status = excluded.financial_status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, notes = excluded.notes;

-- Insert missing product rows from the unified CSV set. Occurrence guards prevent duplicated inserts while preserving legitimate repeated equal products.

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '121a7335-9b35-5a4a-951b-be68e5e307fd'::uuid, 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid and existing.product_name = 'Gin-Tonic' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '34101709-0d10-56fd-bd93-7d752c635e71'::uuid, 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid and existing.product_name = 'Gin-Tonic' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f4a1d322-b0ce-5685-a615-976835943e11'::uuid, 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid and existing.product_name = 'Margarita' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9da3cef4-9659-56cf-8844-94959b143675'::uuid, 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid and existing.product_name = 'Margarita' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6b1146db-af09-5114-a24d-dbe7322c78bf'::uuid, 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid, null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a777dd68-d2bf-5490-b848-dfac389f2153'::uuid, 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid, null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid and existing.product_name = 'Jugo de Arazá en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd64db825-28af-5ae6-88af-7760c4f2b509'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6c0fda06-658b-55a3-bf48-00d6d85ce695'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '82db9b1e-764d-5551-8ae8-1155be2c18b6'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 3
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1e05139b-de97-5614-9c3a-c204d665a3b1'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Mains Zafiro' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '99dc5f95-56ec-5490-af65-259b7b351311'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Corn Dog Zafiro Bites' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '24ffb3e7-194e-59e3-880d-69469e9dcb4b'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f10220b5-0f66-5365-b0cc-f6154d0bfe37'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9e73527f-8729-57ee-826a-5755e50a92d7'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.product_name = 'Bretaña / Soda' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ca92eade-5b58-530c-9688-c8d4b7c5ccc6'::uuid, '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid and existing.product_name = 'Club Colombia' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 8000 and existing.total_price = 16000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'caee1659-b14d-546a-b2ee-549c03715b59'::uuid, '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 16000 and existing.total_price = 16000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8564ae6c-b56a-5666-b6bb-1defe12da1d1'::uuid, '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '01fddad5-f7ce-55be-85f0-5c16d8c5aa19'::uuid, '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid and existing.product_name = 'Tostones Cartageneros' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '98fd1986-4e45-5bf5-b62a-7cb875f6f4bc'::uuid, 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid and existing.product_name = 'Limonada de Sandía' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3a2c39b1-fe3c-54d9-b89c-c69a4bb7403c'::uuid, 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = 'Light') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5db8c279-14ab-57f7-851d-d8dce95a2186'::uuid, 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, null, 'Perrito Loco', 'perrito-loco', 'kitchen', 1, 19000, 19000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid and existing.product_name = 'Perrito Loco' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 19000 and existing.total_price = 19000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5068cd4a-706a-5dee-b8d8-85373a1fd723'::uuid, 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid and existing.product_name = 'Papas a la francesa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 7000 and existing.total_price = 7000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2381e479-9d13-546c-ad22-d8a77cca3a3b'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 16000 and existing.total_price = 16000 and coalesce(existing.notes,'') = 'Mango biche') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1f95fc36-7a44-5e51-978b-52001e000573'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0e611013-e03d-567a-90e3-c1c4f75befcb'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Tostones Cartageneros' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '306725c7-a375-58f0-9b7a-7a9deb82020e'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', 'Sin lechuga y sin pico de gallo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = 'Sin lechuga y sin pico de gallo') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa4c6e0d-7521-5dd5-9a8c-87ad5564da81'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 2, 25000, 50000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Salchipapa Corte Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 2 and existing.unit_price = 25000 and existing.total_price = 50000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9c3485d7-8f2b-5690-881a-a67b8fb88198'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Gin-Tonic' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a6685977-a506-56ad-976f-65b8570215d4'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Soda Italiana de Maracuyá' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9587110a-c863-56e6-86a6-8c66bd644119'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 9000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '341b3b55-dde4-518f-aa5b-daaf2122ad26'::uuid, '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 3 and existing.unit_price = 5000 and existing.total_price = 15000 and coalesce(existing.notes,'') = 'Light') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '13721de6-74ce-512d-b4ce-ee684cd00e97'::uuid, '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid, null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b23818db-48ef-50a7-ab73-f9b80d56ae7c'::uuid, '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid, null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '68cc971b-792b-50ec-9a17-655b90e028c5'::uuid, '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid, null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid and existing.product_name = 'Club Colombia' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7b840f46-31cd-56ed-b1a0-28f62da906f7'::uuid, '26e809e6-d86a-47ed-8339-85708600a40e'::uuid, null, 'Michelada Sin Alcohol Frutal', 'michelada-sin-alcohol-frutal', 'bar', 1, 15000, 15000, 1, 'delivered', 'paid_total', 'Ginger', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid and existing.product_name = 'Michelada Sin Alcohol Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 15000 and existing.total_price = 15000 and coalesce(existing.notes,'') = 'Ginger') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2a4d48cc-7884-5802-bcfd-49d04510cf58'::uuid, '26e809e6-d86a-47ed-8339-85708600a40e'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = 'Smirnoff') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7ea11a26-7ac4-5105-8e4d-5fe928d73735'::uuid, '26e809e6-d86a-47ed-8339-85708600a40e'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f709e898-afef-5c8c-af1a-d57525d2d147'::uuid, '26e809e6-d86a-47ed-8339-85708600a40e'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3e87be30-cc4c-576a-af85-9f3ec80691ca'::uuid, '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid and existing.product_name = 'Poker' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b39e873b-fd4a-5698-9e83-9ee91692c829'::uuid, '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bc8cf06a-c8c6-504c-8570-aa08b729440f'::uuid, '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid and existing.product_name = 'Salchipapa Corte Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7a991896-104c-5cd8-863b-1894b01340d0'::uuid, '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid and existing.product_name = 'Hamburguesa de la Casa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1704f35f-b7ef-58f5-96aa-e105a056544b'::uuid, '355daae2-f2de-48be-814e-d4580a858e4c'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '80f5d3c1-749c-55d4-8261-380d149ac410'::uuid, '355daae2-f2de-48be-814e-d4580a858e4c'::uuid, null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6fa41ddd-1c20-58ae-8f09-222073614d38'::uuid, '355daae2-f2de-48be-814e-d4580a858e4c'::uuid, null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3c170539-60c5-50f0-976c-93413925a825'::uuid, '355daae2-f2de-48be-814e-d4580a858e4c'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Corona, frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = 'Corona, frutos rojos') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f8c81ef-f41f-5831-bcc1-0e89957bb677'::uuid, '72698c72-61db-4294-ad32-743bfba0af3e'::uuid, null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '72698c72-61db-4294-ad32-743bfba0af3e'::uuid and existing.product_name = 'Jugo Hit Surtido' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '838877b3-d03b-50ee-bf48-3f59e84191d4'::uuid, 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid, null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Steeven, la paga mañana', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid and existing.product_name = 'Bretaña / Soda' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = 'Steeven, la paga mañana') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '850cf12f-8bf7-5845-b343-2606d04a7c99'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '23c79816-9f4e-536e-99ab-d6d0f9e8a4b1'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'eccf026e-7ea9-56b0-953c-11217e97b6b7'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b5a48a4a-48ea-5b22-bb72-d16d3eb8d850'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Daiquiri', 'daiquiri', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Daiquiri' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 20000 and existing.total_price = 40000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cdcf1c29-5a47-5e91-8a87-2ae098b75d29'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c41d5dca-2702-5dda-9c02-de60644bf167'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Con bastante limón', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = 'Con bastante limón') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e3643e3e-65b1-5e70-ad1a-9db8cc8097cd'::uuid, '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid, null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 20000 and existing.total_price = 40000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ec4486b9-d90d-568f-ad79-f8973e3e9869'::uuid, '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid, null, 'Smirnoff Ice Personal', 'smirnoff-ice-personal', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid and existing.product_name = 'Smirnoff Ice Personal' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 13000 and existing.total_price = 26000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3ed29b5d-fabc-515d-bb9b-43520fb82c63'::uuid, '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid, null, 'Margarita', 'margarita', 'bar', 2, 22000, 44000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid and existing.product_name = 'Margarita' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 22000 and existing.total_price = 44000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '32c8a6cb-178f-5cba-bd97-573701029c80'::uuid, '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid, null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 20000 and existing.total_price = 40000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4ce029da-d2de-5f4c-86c0-71cc1482dcf6'::uuid, 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid, null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid and existing.product_name = 'Poker' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '40700120-fcb4-5fcc-8128-0f306a7982ce'::uuid, 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid, null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid and existing.product_name = 'Poker' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e73dc8c2-0b28-5a3d-9d3e-e2a44be4796b'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '031c9b97-a7d4-595c-946a-60d540b45054'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, null, 'Limonada de Mango Biche', 'limonada-de-mango-biche', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.product_name = 'Limonada de Mango Biche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9604524a-0f6a-564c-b16f-37270105ef54'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, null, 'Quesadilla Zafiro', 'quesadilla-zafiro', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.product_name = 'Quesadilla Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3fe028c9-09bf-55c1-8be5-f1f7ffa4799d'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.product_name = 'Limonada de Coco' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f1f5176a-9dc6-522e-87f5-8a788c617b4c'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Águila', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.product_name = 'Michelada Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = 'Águila') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f4c87e62-376e-5d4c-8e15-def2bd30da81'::uuid, 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid, null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid and existing.product_name = 'La Reina Doble' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 28000 and existing.total_price = 28000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f12ae3b9-4d5c-5107-b8e3-e3b2272f1a44'::uuid, 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid, null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', 'Harta leche en polvo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid and existing.product_name = 'Limonada de Coco' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = 'Harta leche en polvo') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd3693f89-1043-5b84-a54b-2a7618dcc29f'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, null, 'Squash Personal', 'squash-personal', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.product_name = 'Squash Personal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'db8db386-5813-5e81-a836-e744d94d6577'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e53a1a1-189d-5732-924d-6afeb47b9f18'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.product_name = 'Sprite' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2b08f357-6e0b-578f-93b6-eaa93b8dbd26'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.product_name = 'Sprite' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4a94223f-e8bd-58ff-b4af-73f2c0e3b911'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b4c0bfe7-106d-5aab-b34f-8cc85b589332'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'Limonada de Sandía' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a7a65f8d-5286-5088-9e7a-65424eab838f'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Soda', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 16000 and existing.total_price = 16000 and coalesce(existing.notes,'') = 'Soda') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f6701e0-5522-5403-98ad-ae0c6c54d9d5'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9419d782-fc91-5902-81ed-8ea5d70dcaf8'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4ebdd1a5-90b4-57e9-b35f-e895896b76c0'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.product_name = 'La Reina Doble' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 28000 and existing.total_price = 28000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ed01bdc7-b337-5aa8-bc7f-b07f445e7f75'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.product_name = 'Mains Zafiro' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f69045c9-3afd-5583-b548-6168fee1f71e'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.product_name = 'Soda Italiana de Frutos Rojos' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0be917b7-1c6e-585a-b18b-51ec84653538'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, null, 'Aguardiente Negro / Verde Media', 'aguardiente-negro-verde-media', 'bar', 1, 55000, 55000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.product_name = 'Aguardiente Negro / Verde Media' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 55000 and existing.total_price = 55000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '17527c78-1e5b-5bea-9e1b-8dcbd835f1a0'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.product_name = 'Agua con Gas' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 4000 and existing.total_price = 4000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '004d98a4-e53c-5168-967e-508aaefb9aaa'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.product_name = 'Agua con Gas' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 4000 and existing.total_price = 4000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '609de218-8e10-5eca-9e1a-8fae4ec3fd58'::uuid, 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid, null, 'Cubetazo light', 'cubetazo-light', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', 'Variada', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid and existing.product_name = 'Cubetazo light' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = 'Variada') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd6e172b7-19c0-58f5-9ae2-6c8402a7ee79'::uuid, 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid, null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid and existing.product_name = 'Cubetazo aguila' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '437d59f5-e22a-55ea-a2d6-d0c9861a0130'::uuid, 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 3 and existing.unit_price = 5000 and existing.total_price = 15000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '746621fe-6914-5d17-9d87-a9a3d219a146'::uuid, '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c40adaaf-37b1-5a4c-8f58-55606ffec75f'::uuid, '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid, null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid and existing.product_name = 'Jugo de Guanábana en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0791852d-b8c4-599c-ae34-87a0d419905e'::uuid, 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid, null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid and existing.product_name = 'Canada Dry' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '373bd978-e81f-55ac-9af6-c931365f0c7f'::uuid, 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid, null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid and existing.product_name = 'Canada Dry' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7213bfe7-9827-5a5c-9486-772b497933fa'::uuid, 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid, null, 'Papas adicion', 'papas-adicion', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid and existing.product_name = 'Papas adicion' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 6000 and existing.total_price = 6000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e4acdb13-a0b8-5d0d-bca4-40f362a04c2f'::uuid, 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '79c3bd91-9371-56ba-8eb2-1d15d1c1aa95'::uuid, '3e614951-a4c6-419e-a389-66520337da5a'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ca784110-d582-5068-a326-9e26dacc6f1e'::uuid, '3e614951-a4c6-419e-a389-66520337da5a'::uuid, null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid and existing.product_name = 'Michelada Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = 'Frutos rojos') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6c4168af-59c7-5458-b304-c640bf4468a0'::uuid, '3e614951-a4c6-419e-a389-66520337da5a'::uuid, null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4613d8df-536f-54e3-9e07-4075849e4635'::uuid, '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid and existing.product_name = 'Agua con Gas' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 4000 and existing.total_price = 4000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa4e1dd2-b8a0-5e84-b39d-2be5bd0b956a'::uuid, '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid and existing.product_name = 'Sprite' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '788be84b-4f3e-5e12-bf8f-12ac4c9c01e9'::uuid, '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid and existing.product_name = 'Jugo Hit Surtido' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ad19924f-39f8-57c3-9941-81bf6e5f223f'::uuid, '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid, null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid and existing.product_name = 'Cubetazo aguila' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '39898208-5f9d-5314-8294-b48738cfa8f8'::uuid, '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '47dd7a76-5fc1-5124-a168-a50f78b6b307'::uuid, '825d025e-65de-4a28-a56d-474796cd8a31'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd19676fd-9625-5276-9a90-7822e464ece8'::uuid, '825d025e-65de-4a28-a56d-474796cd8a31'::uuid, null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid and existing.product_name = 'Jugo Hit Surtido' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c93f090e-70ea-5dc2-96fa-31de8d1710ca'::uuid, 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '63917cf7-ce28-5028-843b-a640bd7e7cf4'::uuid, '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid, null, 'Bretana grande', 'bretana-grande', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid and existing.product_name = 'Bretana grande' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 6000 and existing.total_price = 6000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '60798b78-6c9d-5d81-8a79-7e03cda95ada'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.product_name = 'Soda Italiana de Frutos Rojos' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5de27014-a84d-5c7c-a8f9-6b2cb20feec5'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.product_name = 'Soda Italiana de Maracuyá' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 13000 and existing.total_price = 26000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '13b76686-c6f7-5f80-9fcd-8e56ef9a8dc4'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.product_name = 'Nachos Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '47b694c0-cfad-5aee-9909-ef5b4b211ec4'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, null, 'Tortilla Desmechada al Zafiro', 'tortilla-desmechada-al-zafiro', 'kitchen', 1, 23000, 23000, 1, 'delivered', 'paid_total', 'Divididas en 2', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.product_name = 'Tortilla Desmechada al Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 23000 and existing.total_price = 23000 and coalesce(existing.notes,'') = 'Divididas en 2') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a548ce69-27d6-53da-bc77-2364054acb39'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 16000 and existing.total_price = 16000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a850d041-2b22-51f0-851f-b0f21f4ab18f'::uuid, '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9e8d5ddb-83ca-5326-9ffc-753f1c3a0911'::uuid, '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid and existing.product_name = 'Papas Corte Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6367e604-f90b-5533-90c6-3ed4b591cb5c'::uuid, '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = 'Al clima') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6080f027-bb06-518d-a439-63d2d522ca24'::uuid, '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '30a71801-262c-59de-8420-c8e5e47fbfb4'::uuid, '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '37eaeea7-6844-514f-9ca1-42cc0368a7d1'::uuid, '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = 'Al clima') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b2012c93-b9a4-5252-acba-142838556391'::uuid, '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, null, 'La Original', 'la-original', 'kitchen', 2, 24000, 48000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid and existing.product_name = 'La Original' and existing.prep_area = 'kitchen' and existing.quantity = 2 and existing.unit_price = 24000 and existing.total_price = 48000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '53975927-e7dc-5f46-a860-1411c3eadb37'::uuid, '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid and existing.product_name = 'Soda Italiana de Maracuyá' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a111ea8b-7561-5aad-a197-5235b26fc422'::uuid, '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '64061e51-ceb4-5905-b0ad-88360fce40e8'::uuid, '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, null, 'Empaque', 'empaque', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid and existing.product_name = 'Empaque' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 1000 and existing.total_price = 1000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'eab40b79-144d-57e5-814f-dfbbee546062'::uuid, 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, null, 'Jugo de Mango en Leche', 'jugo-de-mango-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid and existing.product_name = 'Jugo de Mango en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8f85897e-918b-53e4-b949-2207e7f14542'::uuid, 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid and existing.product_name = 'Jugo de Guanábana en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '322dc031-e030-59a1-b460-dfd51832b918'::uuid, 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa582a4c-7f8c-5cd5-b9f3-2b4a57d9a0cd'::uuid, 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid and existing.product_name = 'Hamburguesa de la Casa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7e0c192a-dc6c-58de-bc65-9f1fcf298cc7'::uuid, '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid, null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid and existing.product_name = 'Sprite' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a37003a7-cfa8-5a5f-9bb6-a05b61d8667e'::uuid, '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a43eee50-7182-51cd-b0c0-69960ef38594'::uuid, '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid, null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid and existing.product_name = 'Soda Italiana de Maracuyá' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '93f71ba0-8f2e-5b78-b335-088ddf3f3d39'::uuid, '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid, null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid and existing.product_name = 'Soda Italiana de Frutos Rojos' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9cfd8e38-7a69-5f2b-bdcc-b5bc945dad99'::uuid, '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid, null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid and existing.product_name = 'Corn Dog Zafiro Bites' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7dcf4ec4-66b3-5054-aeaa-2b7b50ffc861'::uuid, '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid and existing.product_name = 'Papas Corte Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '81f9eea3-aaa2-540b-842c-66ebac1b715b'::uuid, '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c6f1b579-d0f6-5941-8571-763afa520e9b'::uuid, '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid and existing.product_name = 'Jugo de Lulo en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ee04a899-513a-5a17-8d36-d3356a0a7fdf'::uuid, '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, null, 'Jugo de Maracuyá en Agua', 'jugo-de-maracuya-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid and existing.product_name = 'Jugo de Maracuyá en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '53e3f539-a9f9-52bc-acc7-0d7afafe5637'::uuid, 'a113fef6-fb98-4260-9070-80042910f289'::uuid, null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid and existing.product_name = 'La Reina Doble' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 28000 and existing.total_price = 28000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e391400-1b72-5fc4-8607-f36668fc8cbe'::uuid, 'a113fef6-fb98-4260-9070-80042910f289'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9413f9bc-2c45-52ea-9cc3-fc837efce467'::uuid, 'a113fef6-fb98-4260-9070-80042910f289'::uuid, null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid and existing.product_name = 'Jugo de Arazá en Leche' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 9000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e5f5150e-a18a-52cb-bcc8-eaee12993f03'::uuid, 'a113fef6-fb98-4260-9070-80042910f289'::uuid, null, 'Huevos Hogaos', 'huevos-hogaos', 'kitchen', 1, 15000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid and existing.product_name = 'Huevos Hogaos' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 15000 and existing.total_price = 15000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd9b29824-fb7c-5a8f-b3f7-f4a462cb2bd9'::uuid, 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '16a68a62-b24b-5965-919d-ab19b57a10de'::uuid, 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid and existing.product_name = 'La Reina Doble' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 28000 and existing.total_price = 28000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2bb62403-2b42-513a-a4bd-f6bebb580c12'::uuid, 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c539ae25-0d7d-5722-8dbd-0cf0f55998aa'::uuid, 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 16000 and existing.total_price = 16000 and coalesce(existing.notes,'') = 'Frutos rojos') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f1db842f-e2d7-5134-b971-2258e6ee07c2'::uuid, 'b4f8f126-4265-416e-8628-e965db52d100'::uuid, null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid and existing.product_name = 'Bretaña / Soda' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4a026632-6a90-5f7a-8ecd-38e59cffd04f'::uuid, 'b4f8f126-4265-416e-8628-e965db52d100'::uuid, null, 'Zumo de limón', 'zumo-de-limon', 'bar', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid and existing.product_name = 'Zumo de limón' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 1000 and existing.total_price = 1000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b455fc45-e093-5b1d-a912-e73cd2032b1d'::uuid, 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = 'Smirnoff frutos rojos') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bb8bd343-68bd-5ba6-8ba2-fe7fcc071ae1'::uuid, 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = 'Smirnoff mango biche') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '331a0408-3bf7-5b7d-90a5-1c6b8dd5838b'::uuid, '0645f808-4bf6-42d4-b059-82e729773888'::uuid, null, 'Jugo video mango', 'jugo-video-mango', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0645f808-4bf6-42d4-b059-82e729773888'::uuid and existing.product_name = 'Jugo video mango' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ef90a683-5c8e-5282-9924-9bce759b7248'::uuid, '522f035f-d137-4845-8013-1640b4e97758'::uuid, null, 'Jugo video cereza', 'jugo-video-cereza', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '522f035f-d137-4845-8013-1640b4e97758'::uuid and existing.product_name = 'Jugo video cereza' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3de236da-d2b0-5766-9040-e1d9b4180837'::uuid, '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid, null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid and existing.product_name = 'Agua Cristal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 3000 and existing.total_price = 3000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '00d6df9e-b8d1-5032-91b8-fc0bd1f8fb7e'::uuid, '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid, null, 'Perrito descuento', 'perrito-descuento', 'kitchen', 1, 12000, 12000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid and existing.product_name = 'Perrito descuento' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 12000 and existing.total_price = 12000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fc544a3b-010e-5d1b-8a43-d708d3d30486'::uuid, '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid, null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid and existing.product_name = 'Limonada de Coco' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '717987e6-7cae-5cea-bd15-89acf4c9cb2d'::uuid, '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 16000 and existing.total_price = 32000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '606a4e28-3510-5a09-99e7-4873b9654fd4'::uuid, '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3db67e96-52e7-5b0c-b4fe-81754147fb5f'::uuid, '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '787a0c23-f3cb-5879-aad0-a00fa042bd48'::uuid, '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, null, 'Reina Pepiada', 'reina-pepiada', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid and existing.product_name = 'Reina Pepiada' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6cfedc99-ebb0-56e7-91a9-25b06319b465'::uuid, '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b5163e0c-f7c0-5ce0-ab61-2f86338f0cfe'::uuid, '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid and existing.product_name = 'Canada Dry' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a936f01e-c6b4-5db7-9281-50500072dc43'::uuid, '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid and existing.product_name = 'Tostones Cartageneros' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '76389be5-9a89-5399-8cd2-9490e9dfcb26'::uuid, '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid, null, 'Michelada Ginger Ale', 'michelada-ginger-ale', 'bar', 1, 14000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid and existing.product_name = 'Michelada Ginger Ale' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 14000 and existing.total_price = 14000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '59be03b0-ff88-5cc7-ae35-98607ed0c76d'::uuid, '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0df04e7b-8001-5302-8c32-5e89fe41f901'::uuid, 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid, null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid and existing.product_name = 'Limonada de Coco' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ef4e95fd-05ea-5bb9-a8c5-ea7fffd8194d'::uuid, '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid, null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 9000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c98525ad-6b67-5e99-8e49-83ad7ebda5ca'::uuid, '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid, null, 'Costeña', 'costena', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7c0f9431-4795-5a6b-a551-d9009f58cf27'::uuid, '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '026fad1e-1da6-5eea-816a-ee9cc9c9146d'::uuid, '7cefad24-a203-455e-932a-5c564f2a3624'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '7cefad24-a203-455e-932a-5c564f2a3624'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1557dba8-43de-5616-9811-9a094d632105'::uuid, '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid, null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid and existing.product_name = 'Soda Italiana de Maracuyá' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '65bbd10c-4fcc-55dd-b58b-a42469635ef5'::uuid, '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid, null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid and existing.product_name = 'Soda Italiana de Frutos Rojos' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 13000 and existing.total_price = 13000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '99f321de-b479-56bf-a38d-2c76b7dbf5ca'::uuid, 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b9042e2f-4a3f-505e-9829-2048b316bbd5'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Tostones Cartageneros' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4b637258-8b57-58e2-ac7e-dbc153b3ed53'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Mojito' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 20000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f86ca738-f484-5e21-90ee-b61a2884f8d6'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Mains Zafiro' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '70988c48-cf34-5bc2-89a6-e90037ab2dc9'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Desgranado El Resucitador' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 29000 and existing.total_price = 29000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '778d5f25-039b-5e04-ae51-f63c9885b976'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Nachos Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5bb8b874-890f-5d82-8e0f-5cf2551517cd'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fe8e2972-8357-54f9-bfc5-28b0e9fa698f'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.product_name = 'Corona' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ad36ad0e-ae27-5017-908c-31b52d1157a2'::uuid, '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid, null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid and existing.product_name = 'Águila Original' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 5000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2c305dee-fdad-507b-9d82-865c89a88163'::uuid, '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '325bef38-853f-5f5e-9799-f302856995ae'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', 'Bien ricas', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Papas a la francesa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 7000 and existing.total_price = 7000 and coalesce(existing.notes,'') = 'Bien ricas') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '61af0f36-7818-543b-9c1c-cb3dd4ddd04e'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Poker' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c691fb12-3f1c-5312-a9d2-e23655ae08fd'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Hamburguesa de la Casa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = 'Con queso cheddar') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e8c0eb33-2ea0-5ba6-8105-380645b046ac'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Limonada de Sandía' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f88b7449-fead-5efa-80be-9b176cf843b0'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Jugo de Mora en Agua', 'jugo-de-mora-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Poco fría', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Jugo de Mora en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = 'Poco fría') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '87f132ed-d733-5ec4-ad36-42c46bdaee07'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Yonnier', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Sprite' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = 'Yonnier') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7948ba66-293e-5a62-a928-027df6d77d73'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7c5491ce-db24-5245-ab9c-5c5a3c648c7e'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.product_name = 'Choripan Argentino' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 21000 and existing.total_price = 21000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '70156680-b73d-5fd1-9788-3533b9448260'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', 'Sin cerezas y más limon', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.product_name = 'Margarita' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = 'Sin cerezas y más limon') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fc157b78-055f-5c11-9fc9-eb3c6c3b4750'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.product_name = 'Costeña' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '783fc9c1-032b-5118-8730-7341fda3bb8f'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, null, 'Speed Max', 'speed-max', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Con doble shot de tequila x20.000$', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.product_name = 'Speed Max' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = 'Con doble shot de tequila x20.000$') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '362c549a-a81c-5297-881d-6cab151ca941'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, null, 'Speed Max', 'speed-max', 'bar', 4, 5000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.product_name = 'Speed Max' and existing.prep_area = 'bar' and existing.quantity = 4 and existing.unit_price = 5000 and existing.total_price = 20000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a81f0146-da00-5254-a23a-1043ff06e740'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 2, 10000, 20000, 1, 'delivered', 'paid_total', 'Shots de ron', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.product_name = 'Limonada de Sandía' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 10000 and existing.total_price = 20000 and coalesce(existing.notes,'') = 'Shots de ron') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '14553f9c-2560-51cb-b82d-a387d4bedd11'::uuid, 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid, null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid and existing.product_name = 'Margarita' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 22000 and existing.total_price = 22000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fde90ada-eaf2-570f-9449-f0106596f246'::uuid, 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid, null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', 'Keyner el negro', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid and existing.product_name = 'Jugo de Guanábana en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = 'Keyner el negro') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '24c60a9f-c901-53c2-848e-344631fb4abc'::uuid, '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid and existing.product_name = 'Papas Corte Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '637dea50-712f-5b53-99e1-98286785ad4a'::uuid, '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, null, 'Jugo de Mango en Agua', 'jugo-de-mango-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Sin azúcar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid and existing.product_name = 'Jugo de Mango en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = 'Sin azúcar') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '09038683-d3f8-5ef7-95bd-f05982a08ecd'::uuid, '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid and existing.product_name = 'Cuba Libre' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 18000 and existing.total_price = 18000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '13d15272-2218-5100-a7e1-0cc5cfaab7fc'::uuid, '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Zumo de limón', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid and existing.product_name = 'Bretaña / Soda' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = 'Zumo de limón') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '705c923b-b4ff-5fa8-849d-0ac6347cc043'::uuid, '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid, null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid and existing.product_name = 'Jugo de Arazá en Leche' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 9000 and existing.total_price = 9000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2425440d-18fe-5c3d-b090-57164f7d6bfd'::uuid, '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid, null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid and existing.product_name = 'Limonada de Coco' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 10000 and existing.total_price = 10000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8c242b04-05e5-5497-9c29-43a51c7d3a79'::uuid, '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid, null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid and existing.product_name = 'Nachos Zafiro' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ab59903a-3fe8-5626-80e1-31d14c478e51'::uuid, '1fc00905-31b6-429f-873f-1a4e58303669'::uuid, null, 'Jugo de Fresa en Agua', 'jugo-de-fresa-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid and existing.product_name = 'Jugo de Fresa en Agua' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0deb7e77-df25-5d52-9743-7309c6156575'::uuid, '1fc00905-31b6-429f-873f-1a4e58303669'::uuid, null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid and existing.product_name = 'Hamburguesa de la Casa' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 24000 and existing.total_price = 24000 and coalesce(existing.notes,'') = 'Con queso cheddar') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '00a4cfca-30a6-55cf-963d-1fa859f0890d'::uuid, '695c6444-6e6d-474e-b599-646c930484ed'::uuid, null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '695c6444-6e6d-474e-b599-646c930484ed'::uuid and existing.product_name = 'Agua Cristal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 3000 and existing.total_price = 3000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1b6e2795-cf89-5f02-90da-300868a1b551'::uuid, '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid, null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid and existing.product_name = 'Coca-Cola' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 5000 and existing.total_price = 5000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2ff20bf2-c0ba-57cf-a394-19f2e5d418c4'::uuid, '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid, null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid and existing.product_name = 'Mains Zafiro' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 25000 and existing.total_price = 25000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '50491aa2-118c-5026-ba47-3d74f6f03f52'::uuid, '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid, null, 'Zumo de Limon', 'zumo-de-limon', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid and existing.product_name = 'Zumo de Limon' and existing.prep_area = 'kitchen' and existing.quantity = 1 and existing.unit_price = 1000 and existing.total_price = 1000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f4c69194-e4c0-56ae-bad8-1020a6fa96f4'::uuid, '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid, null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid and existing.product_name = 'Agua con Gas' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 4000 and existing.total_price = 4000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7cb8c742-1667-5434-8cdc-a0f4acd7fdc3'::uuid, '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid, null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid and existing.product_name = 'Budweiser' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 7000 and existing.total_price = 14000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '273f4373-0e3b-5b9f-bbab-2353fc87b374'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 2, 21000, 42000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Michelada Premium Frutal' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 21000 and existing.total_price = 42000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa05b92b-1f84-5b2c-bf15-58a6c07b2869'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Club Colombia' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 8000 and existing.total_price = 16000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3d19b5ae-e6c6-596e-915b-3e3438aa0df5'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Michelada Ginger Ale Frutal' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 16000 and existing.total_price = 32000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0d0a0e1d-101b-5745-8478-94646c190d54'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Budweiser' and existing.prep_area = 'bar' and existing.quantity = 2 and existing.unit_price = 7000 and existing.total_price = 14000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '971a060e-82f2-58a2-942e-78118d09a690'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Agua Cristal' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 3000 and existing.total_price = 3000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fb29aff5-7c8a-50ea-ad96-4699ff475aa8'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Old Parr Media', 'old-parr-media', 'bar', 1, 180000, 180000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Old Parr Media' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 180000 and existing.total_price = 180000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd306ee70-5903-5047-ac1f-d8edfbaf5120'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where (select count(*) from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.product_name = 'Club Colombia' and existing.prep_area = 'bar' and existing.quantity = 1 and existing.unit_price = 8000 and existing.total_price = 8000 and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

-- Insert missing payments from the unified CSV set. Rejected CSV payments are preserved as rejected, confirmed as confirmed.

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'ae53f137-e2c7-5fe4-95a3-06acdcd462c1'::uuid, 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 88000, 88000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 88000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '3641ad5c-a53b-55ed-adc9-f74282816729'::uuid, 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 29000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'af9419bf-b5c0-5339-b513-8003dc38b946'::uuid, '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 142000, 142000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 142000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '3467a5f8-ba8e-510c-82e2-74eb3d74f660'::uuid, '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 81000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '21b3c127-43c5-5660-99be-f93328bce370'::uuid, 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 41000, 41000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 41000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a27c1ff5-8fc4-5802-8431-af8e3a104eb6'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 67000, 67000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 67000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '517992ab-de3c-5e06-96d6-fcb251a3854d'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 47000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '4bd016cf-af31-59bd-9782-228c5878853c'::uuid, '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 63000, 63000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 63000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '66735e74-2eb6-5112-bb40-7863e13fda73'::uuid, '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 15000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'abb189ae-7861-5f2f-8c6b-b1fb54a2a29e'::uuid, '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 26000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '5b99d235-161f-5d94-89ad-0d9e337ab164'::uuid, '26e809e6-d86a-47ed-8339-85708600a40e'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'cash', 'confirmed', 'amount', 86000, 86000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 86000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'bd20a8e0-1f02-5b0f-8809-3d1485f5ef82'::uuid, '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 59000, 59000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 59000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'b88b5535-a133-5820-9e08-f72905b05a23'::uuid, '355daae2-f2de-48be-814e-d4580a858e4c'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, 'nequi', 'confirmed', 'amount', 60000, 60000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid and existing.sales_session_id = '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 60000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '648508eb-e146-5bf3-b592-2aa1d8613f8b'::uuid, '72698c72-61db-4294-ad32-743bfba0af3e'::uuid, '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '72698c72-61db-4294-ad32-743bfba0af3e'::uuid and existing.sales_session_id = '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '01586789-3aec-5a39-a40a-14b1b06db716'::uuid, 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'f489b6a2-596d-5aa5-affa-93038804a1c0'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 10000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '817149b9-934a-5ed6-8122-879636247ca8'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 27000, 27000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 27000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '628e62c1-33ba-597f-b9eb-609334dc16be'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 20000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'aae8bbd0-9369-5062-bf6c-c337b936be51'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 20000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 2
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'db315e1a-9592-544e-aa84-f84af9bbc1cb'::uuid, '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'cash', 'confirmed', 'amount', 18000, 18000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 18000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '399fba7a-253a-58e7-af46-93ec4e45d663'::uuid, '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 110000, 110000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 110000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '24881ab9-73ef-5fb5-a86c-b07e4865e428'::uuid, '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 40000, 40000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 40000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a5cc420e-10d4-56a5-a2b7-f9a1c5abbae7'::uuid, 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, 'nequi', 'confirmed', 'amount', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid and existing.sales_session_id = '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 20000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '3f716cb8-6a7c-5b0d-b4ed-044822869c8c'::uuid, 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'bank_transfer', 'confirmed', 'amount', 80000, 80000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 80000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'dd4a8f27-165f-5c58-a257-32e0726c7ea0'::uuid, 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'nequi', 'confirmed', 'amount', 38000, 38000, 0, '[]'::jsonb, null, 'Se debe', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 38000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = 'Se debe') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'e01d965e-a455-5058-8f08-9fb86799f0fa'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '6d1e0337-93e8-59a2-8d8a-c95b498c20d7'::uuid, '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'nequi', 'confirmed', 'amount', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 15000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'cd25330f-3f35-5639-90c1-4500a0b63ce0'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'cash', 'confirmed', 'amount', 93000, 93000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 93000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '60f61c6f-039d-5846-b395-ae6f2c22d0ba'::uuid, '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'cash', 'confirmed', 'amount', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 10000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '75bab6bf-4ffc-52dd-bf4a-a658d3dfc114'::uuid, 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'cash', 'confirmed', 'amount', 101000, 101000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 101000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'cd769331-2edd-534c-82a2-66efe8aa08ed'::uuid, 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'bank_transfer', 'confirmed', 'amount', 65000, 65000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 65000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '8ab0b1ff-1095-5dd1-b1e7-e7eda48c57ff'::uuid, '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'nequi', 'confirmed', 'amount', 17000, 17000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 17000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'b9b1aec6-28c4-585b-91a8-9620efe1ebf0'::uuid, 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, 'nequi', 'confirmed', 'amount', 16000, 16000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid and existing.sales_session_id = '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 16000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '63eed389-ada9-5544-8d99-02d20c50b201'::uuid, 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'cash', 'confirmed', 'amount', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 8000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '33ad86e3-5427-5e04-bf4c-81684b711622'::uuid, '3e614951-a4c6-419e-a389-66520337da5a'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'nequi', 'confirmed', 'amount', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 47000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '1726bf65-f2cf-5468-85e0-21361c47228e'::uuid, '3e614951-a4c6-419e-a389-66520337da5a'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '8db9fcf4-cf5c-5092-8ccb-36126711f5c8'::uuid, '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '458ef0dd-1578-52cc-89ea-85ae8bf5bfb7'::uuid, '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'nequi', 'confirmed', 'amount', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 9000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'db6de80e-4035-53c8-808f-018a8b68ca73'::uuid, '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'nequi', 'confirmed', 'amount', 35000, 35000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 35000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'e05896e3-b2f0-57eb-971d-b567e5f5fc2b'::uuid, '825d025e-65de-4a28-a56d-474796cd8a31'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, 'bank_transfer', 'confirmed', 'amount', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid and existing.sales_session_id = 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 26000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '7d866d90-4e6a-51ad-8a54-248b48e84510'::uuid, 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'nequi', 'confirmed', 'amount', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 10000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a912c15e-e8cf-586e-8605-adbae8b452c5'::uuid, '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'cash', 'confirmed', 'amount', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 6000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'b81b2899-ad8b-555a-a950-54368afe9f44'::uuid, '54388ffc-8714-412a-bb98-73e13e89edab'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'bank_transfer', 'confirmed', 'amount', 102000, 102000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 102000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '91a96281-cab5-5dcb-b3c8-0ca11e56f1cb'::uuid, '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'nequi', 'confirmed', 'amount', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 70000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'd7b66912-c14d-56cb-8eaf-a80861a5a642'::uuid, '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'cash', 'confirmed', 'amount', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 29000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '3cbdb68d-c312-5f65-9877-1157a6350729'::uuid, '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'nequi', 'confirmed', 'amount', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 70000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '2453bef0-1095-5152-ad0b-e885c14fd2aa'::uuid, 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, 'bank_transfer', 'confirmed', 'amount', 71000, 71000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid and existing.sales_session_id = 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 71000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '018faa50-a38c-5614-964d-bffe38bc5c7b'::uuid, '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '83f7eec1-e37f-52e6-8e23-687de7316809'::uuid, '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'other', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, 'Descontar del sueldo', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'other' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = 'Descontar del sueldo') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '78056410-52e4-5b01-b704-7690647a2cfa'::uuid, '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'nequi', 'confirmed', 'amount', 44000, 44000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 44000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '18ec53f8-7c1e-5f54-ae7a-7f9e6fa9b763'::uuid, '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'nequi', 'confirmed', 'amount', 62000, 62000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 62000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a07a8338-50b3-53ad-8581-6135eb0af950'::uuid, 'a113fef6-fb98-4260-9070-80042910f289'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'nequi', 'confirmed', 'amount', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 82000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '858cac88-d5f1-5ae9-9ee2-0c356610770f'::uuid, 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, 'bank_transfer', 'confirmed', 'amount', 78000, 78000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid and existing.sales_session_id = '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 78000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '0b7f757b-31cf-5fea-91bd-f0a3feca3a43'::uuid, 'b4f8f126-4265-416e-8628-e965db52d100'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'nequi', 'confirmed', 'amount', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 6000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '751a9413-fd9c-5376-95c1-2b3b026c12c0'::uuid, 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'nequi', 'confirmed', 'amount', 42000, 42000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 42000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'bb731cdb-6a11-5b91-98d3-d167e87457c0'::uuid, '0645f808-4bf6-42d4-b059-82e729773888'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0645f808-4bf6-42d4-b059-82e729773888'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'c1793635-3156-578e-8fa4-06cc2ced8eab'::uuid, '522f035f-d137-4845-8013-1640b4e97758'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '522f035f-d137-4845-8013-1640b4e97758'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'bea336f2-0b9c-5e66-9635-5be92d291e78'::uuid, '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'nequi', 'confirmed', 'amount', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 25000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'd8ad6128-8447-55bb-9de9-eae7a308e267'::uuid, '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, 'cash', 'confirmed', 'amount', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid and existing.sales_session_id = 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 82000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '9c29817e-9810-5d49-a8c0-a53a4cc7b396'::uuid, '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, 'a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid, 'nequi', 'confirmed', 'amount', 51000, 51000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid and existing.sales_session_id = 'a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 51000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'af335931-fbf2-5dfb-aba8-bf33fca5ece9'::uuid, '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'nequi', 'confirmed', 'amount', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 19000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'b080b4c6-3075-54bd-ac74-aa7e1e10fa47'::uuid, 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'nequi', 'confirmed', 'amount', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 10000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '5f603907-7e3b-5a2d-8c7e-f4d3ad7c935b'::uuid, '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'nequi', 'confirmed', 'amount', 28000, 28000, 0, '[]'::jsonb, null, 'Cambio por nequi', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 28000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = 'Cambio por nequi') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '79555a40-b690-5673-9d76-4c89aa722ca4'::uuid, '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '8b54e827-e868-5bbe-94ec-b2f928c2827b'::uuid, '7cefad24-a203-455e-932a-5c564f2a3624'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'cash', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '7cefad24-a203-455e-932a-5c564f2a3624'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'e53367fa-ef38-5677-966c-b9a0807add9e'::uuid, '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'nequi', 'confirmed', 'amount', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 26000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '4b82603e-0282-5b36-bfea-50a91589e0d1'::uuid, 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid and existing.sales_session_id = '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '4d1e3754-21d3-5376-a67c-a90b5aaffadd'::uuid, '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid, 'nequi', 'confirmed', 'amount', 132000, 132000, 0, '[]'::jsonb, '7992', null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid and existing.sales_session_id = 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 132000 and coalesce(existing.reference,'') = '7992' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '08163b9c-f7c0-5b55-baae-d3d2c9050fa8'::uuid, '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid, 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid, 'cash', 'confirmed', 'amount', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid and existing.sales_session_id = 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 10000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'fde59498-e764-5c98-95ab-ef1be54b8b0b'::uuid, '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a4dfc040-2b4e-5b9c-90b1-0901a7b7b8f3'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'rejected', 'amount', 7000, 7000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null::timestamptz, null, timezone('utc', now()), 'recovery@zafiro.local', 'Recuperado desde CSV como pago rechazado'
where (select count(*) from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'rejected' and existing.amount_applied = 7000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '1fd791c0-e5b1-5147-bf77-e261fc094203'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'bank_transfer', 'confirmed', 'amount', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 81000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a748dc02-4c89-5ce6-b29f-221a0efee182'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'bank_transfer', 'confirmed', 'amount', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 8000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '12f61d20-4058-5086-890f-ac54b25e5818'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'rejected', 'amount', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null::timestamptz, null, timezone('utc', now()), 'recovery@zafiro.local', 'Recuperado desde CSV como pago rechazado'
where (select count(*) from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'rejected' and existing.amount_applied = 12000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '743d1f50-de18-5bd3-a2b0-4bff072f9406'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'cash', 'confirmed', 'amount', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 12000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '1316aa94-1b21-50ac-8fe0-e05647b1077f'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'bank_transfer', 'rejected', 'amount', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null::timestamptz, null, timezone('utc', now()), 'recovery@zafiro.local', 'Recuperado desde CSV como pago rechazado'
where (select count(*) from public.pos_payments existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'bank_transfer' and existing.status = 'rejected' and existing.amount_applied = 72000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'cb0b5d06-74e3-55cc-a1dd-bdf4a058500c'::uuid, '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'cash', 'confirmed', 'amount', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 72000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'e249c2a3-b0b5-5186-bd56-6a34236b5ae2'::uuid, 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'bank_transfer', 'confirmed', 'amount', 22000, 22000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'bank_transfer' and existing.status = 'confirmed' and existing.amount_applied = 22000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'ad40e7ce-84c2-52a6-8554-7f27d8f08d5e'::uuid, 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'cash', 'confirmed', 'amount', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 9000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'aefd4382-53b5-52d4-99d3-e6b063604121'::uuid, '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'confirmed', 'amount', 56000, 56000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 56000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '6461e086-354b-5d89-ab68-87d56bb43c30'::uuid, '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'confirmed', 'amount', 43000, 43000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 43000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '7b279da1-39f6-5fe0-aabd-7f95e75831e9'::uuid, '1fc00905-31b6-429f-873f-1a4e58303669'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'nequi', 'confirmed', 'amount', 32000, 32000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid and existing.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 32000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '18d16cdb-446c-5b1d-9966-c7355f473d90'::uuid, '695c6444-6e6d-474e-b599-646c930484ed'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, 'nequi', 'confirmed', 'amount', 3000, 3000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '695c6444-6e6d-474e-b599-646c930484ed'::uuid and existing.sales_session_id = '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 3000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '46c91d90-24ad-5509-8546-c1dc4013fd6d'::uuid, '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, 'nequi', 'confirmed', 'amount', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid and existing.sales_session_id = '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 5000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select 'a60bc81e-f8a5-5e52-b771-dc1f0b21a79d'::uuid, '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, 'nequi', 'confirmed', 'amount', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid and existing.sales_session_id = '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 25000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '572643e3-4e5a-55fb-9995-d9cb6b7263de'::uuid, '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, 'cash', 'confirmed', 'amount', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid and existing.sales_session_id = '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid and existing.method = 'cash' and existing.status = 'confirmed' and existing.amount_applied = 19000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email, rejected_at, rejected_by_email, rejection_reason)
select '5133e04e-e0f9-5848-90b8-d9d4d01e6198'::uuid, '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, 'nequi', 'confirmed', 'amount', 295000, 295000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local', null::timestamptz, null, null
where (select count(*) from public.pos_payments existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid and existing.sales_session_id = '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid and existing.method = 'nequi' and existing.status = 'confirmed' and existing.amount_applied = 295000 and coalesce(existing.reference,'') = '' and coalesce(existing.notes,'') = '') < 1
on conflict (id) do nothing;

-- Official jornada summaries from the control table provided by the user. This updates summary only; no transactional rows are deleted.

create temp table recovery_expected_sessions (id uuid primary key, business_date date, session_label text, total_collected numeric, order_count integer, delivered_products integer, average_ticket numeric) on commit drop;

insert into recovery_expected_sessions values
('929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, '2026-05-22'::date, 'Jornada 2026-05-22', 347000, 5, 18, 69400),
('855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, '2026-05-23'::date, 'Jornada 2026-05-23', 383000, 8, 31, 47875),
('e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid, '2026-05-24'::date, 'Jornada 2026-05-24', 142000, 2, 9, 71000),
('8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, '2026-05-26'::date, 'Jornada 2026-05-26', 98000, 7, 12, 14000),
('48866b4b-c259-4cb0-916a-16e888a57408'::uuid, '2026-05-27'::date, 'Jornada 2026-05-27', 0, 0, 0, 0),
('a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid, '2026-05-28'::date, 'Jornada 2026-05-28', 51000, 1, 4, 51000),
('cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, '2026-05-29'::date, 'Jornada 2026-05-29', 165000, 6, 13, 27500),
('0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, '2026-05-30'::date, 'Jornada 2026-05-30', 276000, 6, 18, 46000),
('ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, '2026-05-31'::date, 'Jornada 2026-05-31', 358000, 7, 24, 51143),
('e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, '2026-06-01'::date, 'Jornada 2026-06-01', 135000, 5, 12, 27000),
('2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, '2026-06-03'::date, 'Jornada 2026-06-03', 440000, 8, 34, 55000),
('8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, '2026-06-04'::date, 'Jornada 2026-06-04', 270000, 5, 20, 54000),
('3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid, '2026-06-05'::date, 'Jornada 2026-06-05', 5000, 1, 1, 5000),
('36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, '2026-06-06'::date, 'Jornada 2026-06-06', 804000, 7, 51, 114857);

update public.pos_sales_sessions s set session_label = e.session_label, business_date = e.business_date, summary = jsonb_set(jsonb_set(jsonb_set(jsonb_set(coalesce(s.summary, '{}'::jsonb), '{totalCollected}', to_jsonb(e.total_collected)), '{grossSales}', to_jsonb(e.total_collected)), '{deliveredProducts}', to_jsonb(e.delivered_products)), '{orderCount}', to_jsonb(e.order_count)) || jsonb_build_object('recoveryExpected', jsonb_build_object('averageTicket', e.average_ticket, 'source', 'unified_csv_no_delete')) from recovery_expected_sessions e where s.id = e.id;

commit;


-- Validation report: expected control table vs database after conservative recovery.
with expected(session_id, business_date, venta_total, mesas_ordenes, productos_vendidos, ticket_promedio) as (
  values
('929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, '2026-05-22'::date, 347000::numeric, 5::integer, 18::integer, 69400::numeric),
('855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, '2026-05-23'::date, 383000::numeric, 8::integer, 31::integer, 47875::numeric),
('e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid, '2026-05-24'::date, 142000::numeric, 2::integer, 9::integer, 71000::numeric),
('8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, '2026-05-26'::date, 98000::numeric, 7::integer, 12::integer, 14000::numeric),
('48866b4b-c259-4cb0-916a-16e888a57408'::uuid, '2026-05-27'::date, 0::numeric, 0::integer, 0::integer, 0::numeric),
('a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid, '2026-05-28'::date, 51000::numeric, 1::integer, 4::integer, 51000::numeric),
('cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, '2026-05-29'::date, 165000::numeric, 6::integer, 13::integer, 27500::numeric),
('0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, '2026-05-30'::date, 276000::numeric, 6::integer, 18::integer, 46000::numeric),
('ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, '2026-05-31'::date, 358000::numeric, 7::integer, 24::integer, 51143::numeric),
('e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, '2026-06-01'::date, 135000::numeric, 5::integer, 12::integer, 27000::numeric),
('2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, '2026-06-03'::date, 440000::numeric, 8::integer, 34::integer, 55000::numeric),
('8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, '2026-06-04'::date, 270000::numeric, 5::integer, 20::integer, 54000::numeric),
('3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid, '2026-06-05'::date, 5000::numeric, 1::integer, 1::integer, 5000::numeric),
('36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, '2026-06-06'::date, 804000::numeric, 7::integer, 51::integer, 114857::numeric)
), item_totals as (
  select o.sales_session_id,
    coalesce(sum(i.total_price) filter (where i.operational_status <> 'cancelled' and i.financial_status <> 'cancelled'), 0) as actual_venta_productos,
    coalesce(sum(i.quantity) filter (where i.operational_status <> 'cancelled' and i.financial_status <> 'cancelled'), 0) as actual_productos
  from public.pos_orders o
  left join public.pos_order_items i on i.order_id = o.id
  group by o.sales_session_id
), payment_totals as (
  select sales_session_id,
    coalesce(sum(amount_applied) filter (where status = 'confirmed'), 0) as actual_cobrado
  from public.pos_payments
  group by sales_session_id
)
select
  e.business_date as jornada,
  e.venta_total,
  coalesce((s.summary ->> 'totalCollected')::numeric, 0) as resumen_cobrado,
  coalesce(p.actual_cobrado, 0) as pagos_confirmados,
  coalesce(i.actual_venta_productos, 0) as productos_total,
  e.mesas_ordenes,
  coalesce((s.summary ->> 'orderCount')::integer, 0) as resumen_mesas_ordenes,
  e.productos_vendidos,
  coalesce(i.actual_productos, 0) as productos_en_detalle,
  e.ticket_promedio,
  case
    when e.venta_total = coalesce((s.summary ->> 'totalCollected')::numeric, 0)
     and e.mesas_ordenes = coalesce((s.summary ->> 'orderCount')::integer, 0)
     and e.productos_vendidos = coalesce((s.summary ->> 'deliveredProducts')::integer, 0)
    then 'OK_RESUMEN'
    else 'REVISAR_RESUMEN'
  end as estado_resumen,
  case
    when e.venta_total = coalesce(p.actual_cobrado, 0)
     and e.venta_total = coalesce(i.actual_venta_productos, 0)
     and e.productos_vendidos = coalesce(i.actual_productos, 0)
    then 'OK_DETALLE'
    else 'REVISAR_DETALLE'
  end as estado_detalle
from expected e
left join public.pos_sales_sessions s on s.id = e.session_id
left join item_totals i on i.sales_session_id = e.session_id
left join payment_totals p on p.sales_session_id = e.session_id
order by e.business_date;
