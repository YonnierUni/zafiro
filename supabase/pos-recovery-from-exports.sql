-- Reconstructed POS data from exported sales-sessions HTML/CSV files.
-- Review before running. Idempotent for sessions, orders, items and payments by fixed UUIDs.
-- Run pos-prevent-table-cascade.sql before this file.
begin;
set constraints all deferred;

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

insert into public.pos_sales_sessions (id, session_label, business_date, status, opened_at, opened_by_email, closed_at, closed_by_email, cutoff_hour, notes, summary)
values ('34bfb0b0-0509-448a-8efb-9cfd3b831273', 'Jornada 2026-06-07', '2026-06-07'::date, 'open', '2026-06-07T23:13:00+00'::timestamptz, 'recovery@zafiro.local', null::timestamptz, null, 18, 'Recuperada desde export HTML/CSV. 2026-06-07 - abierta 07/06/2026, 06:13 p. m.', '{"confirmedPayments": 0, "deliveredProducts": 0, "grossSales": 0, "openOrders": 6, "orderCount": 6, "paymentMethods": [], "pendingBalance": 0, "pendingPayments": 0, "products": [], "recovery": {"source": "html_and_csv_exports", "top": "Sin ventas", "ticket": 40000}, "totalCollected": 240000}'::jsonb)
on conflict (id) do update set session_label = excluded.session_label, business_date = excluded.business_date, status = excluded.status, opened_at = excluded.opened_at, closed_at = excluded.closed_at, summary = excluded.summary, notes = excluded.notes;

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

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '78340466-f55a-5063-9bc9-32f193d065c0', '5f6c36a6-ea72-434c-a531-0d40271d99dc', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b7ac7980-690d-54c2-a3bf-34b336fbc38d', '10c11ad2-3dc7-4ffa-ad2e-589948d5f646', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3864a0d3-d94a-5c59-a1b6-85d53e67ca3d', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Soda Italiana de MaracuyÃ¡', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '347df39d-d1b6-5bf7-8253-ff082a9f4686', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'da8923ce-293d-5e64-9224-c1a480fffcb9', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6815ccf2-77a1-56c0-bc3d-066e3722bce0', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '874ea675-77f6-5497-8161-f8772843a922', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fd4d7a08-28d5-5381-8e4c-ae7073ce9b0b', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a52e1855-2176-588c-b3e1-f3a6e824c3f9', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Jugo de MaracuyÃ¡ en Agua', 'jugo-de-maracuya-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f4b08f8-c780-553d-bb97-ac67108deece', 'a113fef6-fb98-4260-9070-80042910f289', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '42af7ea3-d4c4-5dc3-b6bf-d41a1f105c93', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c2ca7652-6ade-5ef9-9db6-d4323355e5f6', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Jugo de ArazÃ¡ en Leche', 'jugo-de-araza-en-leche', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '41d6b3a3-78a4-5a7c-b8ad-5639a4e9dfc1', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Huevos Hogaos', 'huevos-hogaos', 'kitchen', 1, 15000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '84cd912b-026d-59b7-a76e-e3f7e10e6386', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71927ce9-de96-549a-9031-2dab514d8990', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b6c935d1-ef6e-5440-8bda-febd5f334abe', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0576d42f-443a-5e77-953a-2cbaa82b304f', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cddbbb80-05b6-58e4-8c6f-34142cb075b2', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83d0a038-91ba-5144-8a6a-f43ae8effe06', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Limonada de Mango Biche', 'limonada-de-mango-biche', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '669a2125-206a-5f0b-99a4-c435620a6af1', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Quesadilla Zafiro', 'quesadilla-zafiro', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ae38f7e7-da51-57f9-b61a-24c265955145', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bf3bff60-25a5-5580-abda-51f649a5e3f8', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Ãguila', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f38c4bef-1891-5c45-a65f-7cfc6d86d392', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '49ecd6a1-027d-5332-8a28-90901717feb8', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', 'Harta leche en polvo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8f7e9a40-5e26-5608-be98-5d9d46e5b4c0', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Squash Personal', 'squash-personal', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9446008b-7c21-5ad2-b67a-e21b79b69c82', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd4c76bd5-7957-54d2-831c-6d9002f7b974', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6009ecf4-4ca7-5482-8dd5-aee7a8b8f1c4', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8eec4631-8458-5213-be86-220aa60e7834', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '95021bd9-9ebc-593c-a06a-8b373aadb02b', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Limonada de SandÃ­a', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1bb2d3ed-1be5-5c04-98d3-722e124aebc2', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Soda', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8dac99cc-8043-5463-ae81-63a0eacee9db', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Ãguila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '25a84398-ad6c-5f7c-b610-4f7a60a017ce', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bb4a1e1a-573e-59cd-8b59-c7a30b720465', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Ãguila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '77f1f581-1001-5cbe-9919-02f93b61ab83', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'MainsÂ Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '094dba66-1d19-5668-86f1-602778cb3e4f', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '899a7fc6-ad1c-517c-a32d-0e901ce4b6f5', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Aguardiente Negro / Verde Media', 'aguardiente-negro-verde-media', 'bar', 1, 55000, 55000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f3c600bd-320b-5571-b0ec-8d39d2016fac', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ae6dd0db-98a4-5de3-8919-0a30a5719629', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd0a1f8d3-a4df-5882-aaf2-b65f5c3554ba', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Cubetazo light', 'cubetazo-light', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', 'Variada', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '652cec3e-a54d-5f4f-91aa-24b3799b40f2', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a6be569d-a0c9-5631-a8d1-485974943f62', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Ãguila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1301d188-7945-574e-aa4b-dd0bffebf954', '14a32cde-5e31-478f-84f4-dc281012ebb3', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ef09faa4-52b5-5a27-b209-5f89104f612c', '14a32cde-5e31-478f-84f4-dc281012ebb3', null, 'Jugo de GuanÃ¡bana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '69b28a57-d46d-518d-adf4-26362ed1a5ed', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f6d22f6-985b-577a-90ac-b0f23cef0295', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c14dba97-a62a-5b9a-b2b0-8e7837c196c8', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Papas adicion', 'papas-adicion', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '33d8c473-96f1-51f3-9f5a-35eee9c4d13f', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a35f3b4a-eca2-5c64-81fd-91024bf81316', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dd46838a-66cd-570c-9e34-4211aaf6ebb6', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd4c84e32-c9e4-5513-bbe9-a517d9e31262', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c70ee00a-a1ae-5d40-bee5-ac7aecc09259', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7a792eea-3743-5b1f-a945-e7ba440d0520', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', null, 'Jugo de ArazÃ¡ en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ec9b67d2-83e4-513d-8307-2076f6c7f265', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2dad6f49-cee5-5d09-8dd7-967a6aa173c0', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'MainsÂ Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c76e717b-9f08-5dc9-9191-b029bf198823', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ced7ae12-aac2-505e-a5a1-3fff7598d293', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '030890da-f3b7-5502-a7ff-aae72d6025d9', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '109d24b5-86f7-576c-9aab-338a895a06c5', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f9b63d5b-7a07-512f-9b89-a825afc5b198', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e4c6dcc9-0266-5f54-8045-6112c8029bca', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'BretaÃ±a / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '05f51533-8686-5c83-afe7-d236dc17e75b', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3d5a6b93-dbcf-5df6-99bf-f11ed053c084', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2b2932ef-3d17-5b40-bff5-68313d226264', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8204b99d-fba7-50eb-9eb5-8ee12d75d500', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '61232c6b-cdc6-5dba-9d4c-3d4409d73aa1', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Limonada de SandÃ­a', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9e37b46c-0566-54d0-8023-0266eb3f596e', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Ãguila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd44d3a76-475c-54dc-8b97-7e7d633a5d62', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Perrito Loco', 'perrito-loco', 'kitchen', 1, 19000, 19000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f0cc5de6-2743-5a02-ba81-2748d974fd9a', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9bffc62d-927a-5a0f-9beb-0aa14f521175', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83445eab-aaff-50ed-9d8d-6b65125bbcab', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '787791fe-a921-5e9d-96c3-94e0debc2322', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '60b26e92-544f-5b63-82c4-f1addfe65f9f', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', 'Sin lechuga y sin pico de gallo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd6d26ea1-7b54-5b84-8b54-f122ef773139', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 2, 25000, 50000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e847e976-b6e3-5782-a9e0-8ceb7c797223', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'af5cefa9-22be-5dac-a505-a59ab0566300', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Soda Italiana de MaracuyÃ¡', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1878fe4f-9b4f-53e7-a218-2cb30702ff76', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ebb268d5-71a4-5f42-b1f6-3753b0e48e29', '593359c4-ceb7-4f02-b2cf-46d259202acb', null, 'Ãguila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '07fb062e-8258-529d-92d7-65a724d0ebe4', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2a905e58-a13e-5cda-89fe-ac68c251b48b', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e05dfce-13f1-5f78-a25f-020027d5200e', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd28d0a3f-8532-5088-88a6-fd777238e769', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Michelada Sin Alcohol Frutal', 'michelada-sin-alcohol-frutal', 'bar', 1, 15000, 15000, 1, 'delivered', 'paid_total', 'Ginger', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '77ab9482-b429-5abd-a439-53b9d038befc', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '89770d84-77cd-5b6e-9efe-a39affb0b8f7', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bcbac0e4-683e-59b3-9434-7cd1e6fef96b', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5bbab18e-943c-56e4-bb36-93d31df605c8', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '94e0533b-c2d6-5eb2-9575-6091895fbbb9', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Ãguila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '06e86836-0e5e-5581-bb08-cc7fe8100a26', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '97f40e56-08c6-5271-b710-d449d81fef0a', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '893af861-1d16-5e78-b076-0e50a5066fe9', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b22c9f1d-ca2b-575c-aaa3-6a1a606a570b', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'CosteÃ±a', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '471525db-03f6-50fd-9b09-109ae1c74008', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Corona, frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '36a871cb-3a88-59b6-8c7f-cee789651489', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'CosteÃ±a', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '27be8274-3a2c-564f-acf2-4a766fa708bf', '72698c72-61db-4294-ad32-743bfba0af3e', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '72698c72-61db-4294-ad32-743bfba0af3e'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '04295b5e-4976-5e11-a4fe-a733cc97982c', 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d', null, 'BretaÃ±a / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Steeven, la paga maÃ±ana', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '53f89c43-8a36-5922-8116-ed60b3bdec8b', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '255a906c-b8da-531f-99ae-7df3574124e1', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Ãguila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd8e4cbfc-1e84-51a7-b926-3d30e6d223be', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'CosteÃ±a', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0d40a3b1-c0d0-57c1-846b-706085ed4e4f', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Daiquiri', 'daiquiri', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cf83f04a-e48b-5c4a-88ce-b014714897c2', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a94a0611-8899-5541-8941-a19d779c0acb', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Con bastante limÃ³n', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'add4a317-cb28-5d6e-8221-4bbd190db080', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa126958-8e38-57ea-b5a1-f8bf48b35f2c', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Smirnoff Ice Personal', 'smirnoff-ice-personal', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '72bd8a3f-e3e5-5358-a181-863e21baa503', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Margarita', 'margarita', 'bar', 2, 22000, 44000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2cf5c346-7d88-5a59-8adb-cd62a4e7139f', '9fbd6c34-66a7-40a0-9b50-969dc0d17abb', null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ed7cc353-72e3-5ee8-8954-3fc46bc80c92', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '46bc7ae7-264f-51ee-af10-7017428a3f63', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3cf45b4c-ad76-5a27-adbc-de140e8158a5', '50a53517-864f-44d9-b9c9-516dd21f05d8', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd2733e1d-caf7-5f9d-b155-aa28b7c28e05', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', 'Bien ricas', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9ee1ddf8-265c-5ae2-9fe4-ad376322dacd', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4673df98-3550-5b47-88e0-02b1e80954be', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '95bcf3d2-2045-585d-b9fa-4fd6966e7a3a', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Limonada de SandÃ­a', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9780b850-dd27-5c88-8898-df8c7a023c03', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Jugo de Mora en Agua', 'jugo-de-mora-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Poco frÃ­a', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7540c203-c631-529e-b1a3-03b545953be7', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Yonnier', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4357ca6f-708c-5c3c-8571-f9b7d404281e', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ba8a500b-d52e-5cb8-816b-f22f87389439', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0d1cb93a-5f0e-5883-aa67-07f938c1fe37', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', 'Sin cerezas y mÃ¡s limon', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cd7dffc1-933e-559f-9728-7d76a0f982e0', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'CosteÃ±a', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2919f8aa-2b85-5240-9399-5205bfbef24c', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Speed Max', 'speed-max', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Con doble shot de tequila x20.000$', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0fab2bdd-3e3b-53ad-b902-c2b43c055dd9', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Speed Max', 'speed-max', 'bar', 4, 5000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0eb15194-97f7-5163-b643-0fd278fcdf1b', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Limonada de SandÃ­a', 'limonada-de-sandia', 'bar', 2, 10000, 20000, 1, 'delivered', 'paid_total', 'Shots de ron', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ed52ff9f-a94e-51f8-84d4-bbc316dea842', 'f49a1572-86cd-48d8-86b1-89ead2157652', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '61d89a88-1266-56e7-8029-4e57093abd62', 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203', null, 'Jugo de GuanÃ¡bana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', 'Keyner el negro', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fdd17b21-a462-529f-9469-f5915a9b72df', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b5c2373d-a691-5cdb-a208-48190103eec7', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Jugo de Mango en Agua', 'jugo-de-mango-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Sin azÃºcar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6330aa13-d51d-56dc-9977-cebe78826839', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2b2bae07-9151-5701-9817-28a9114b1395', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'BretaÃ±a / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Zumo de limÃ³n', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '942a8577-9d25-588e-bf7f-7ac8f4b9aef2', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Jugo de ArazÃ¡ en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7b75886c-a7d2-5468-b209-dc6fcdfec445', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0e5e0d49-e09b-52f7-881b-2e028f59d298', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'de126ed9-08ab-510e-9d21-f26d0cba5b17', '1fc00905-31b6-429f-873f-1a4e58303669', null, 'Jugo de Fresa en Agua', 'jugo-de-fresa-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7e27535a-e465-503f-b9ae-2db2fcc879df', '1fc00905-31b6-429f-873f-1a4e58303669', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f9c8154a-b29e-56d0-bdfb-e9fb9886a597', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', null, 'Michelada Ginger Ale', 'michelada-ginger-ale', 'bar', 1, 14000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5fbabf04-b0d0-5609-807e-9a09efa0d938', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', null, 'Ãguila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '894c8834-124d-5166-84dc-90d55922b0fd', 'cd11c35c-1fba-4398-84b9-7a4b90bacbab', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b7f51341-f841-5f73-a2ef-b1feeeeb3596', '0470d9df-4237-4811-9ef8-d2a40e1d6371', null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2c673127-4201-582b-9786-d059fbd903fe', '0470d9df-4237-4811-9ef8-d2a40e1d6371', null, 'CosteÃ±a', 'costena', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '964c47f6-bc74-5c97-bd77-0b88196897f4', '78c8e74c-48be-4d0b-a996-525d33f70fbb', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e56f17cb-7a1f-54a2-98aa-c17e60ead708', '7cefad24-a203-455e-932a-5c564f2a3624', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '7cefad24-a203-455e-932a-5c564f2a3624'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f243c234-e528-5310-8b72-3a583aa8d80e', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', null, 'Soda Italiana de MaracuyÃ¡', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71026046-0f06-5676-b05e-19a915973c7b', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f77ef6e7-1c61-56e4-9cfd-f0b180e02101', 'faebbf42-ace3-47f9-9df3-2d23b2e76e79', null, 'Ãguila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '80c830f3-8fd8-5d43-8d4a-5c7885ea661a', '695c6444-6e6d-474e-b599-646c930484ed', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '695c6444-6e6d-474e-b599-646c930484ed'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ad2d5bca-14a8-5adf-95e2-d9ecd82652eb', '2f0a2ca0-a496-45c2-804b-11d4c3957218', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7cf48677-3a4e-5956-a465-40d0aa8ef1e8', '153e1b85-3e78-4f62-bbb9-a1ce34b5b724', null, 'MainsÂ Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fb8f1452-eff5-5874-8595-7e8463ac1d4e', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Zumo de Limon', 'zumo-de-limon', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e73484e2-9cf3-5e0a-a2d3-1556cd1c0a10', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ce24d57b-e733-5b7c-86eb-6703567b82d1', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '791a8184-de74-5e72-9e64-aa5c8cc19286', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 2, 21000, 42000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3477e61f-6a73-535c-9872-cb5f35f35b3f', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fa37b5a7-a8d6-577d-a784-7ba13cf95860', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a88f0813-7440-5f1d-8060-9fd2b088d020', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e67f3043-3a4e-5bc7-a2bf-084e411328e2', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3b8b2516-b5dd-50ad-81fb-4b9c8f7b15e5', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Old Parr Media', 'old-parr-media', 'bar', 1, 180000, 180000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cf7fef10-963c-5200-a2ee-93095805eb4f', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bb14e885-7bfe-5827-8a7c-4218cf45bb90', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Reina Pepiada', 'reina-pepiada', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd48fb4a5-0dc4-5163-b3c7-531c0045f50e', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1f129cf9-a290-5bc3-8749-1b5ce8231377', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '99e68dda-7d10-5ed6-ba0f-928670e01976', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '49e28f87-c25d-570b-aef8-a7fe6565f909', 'bacf03d0-c7c3-492a-96eb-fb897a0297dc', null, 'Coca-Cola', 'coca-cola', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '028d237a-0d52-5ee6-b890-c1a22758e0bb', '99e279d9-995c-4c05-9c55-5b89814a6d09', null, 'Bretana grande', 'bretana-grande', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dd5bdbbe-6744-523b-9736-764d7edcced6', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ee81787f-5bfa-5049-b1ff-1997bcffedc9', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Soda Italiana de MaracuyÃ¡', 'soda-italiana-de-maracuya', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e1e1fbf0-8cea-5014-97a0-12cd17cb9ead', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '86e61301-331f-5935-a376-6b695acf6ec0', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Tortilla Desmechada al Zafiro', 'tortilla-desmechada-al-zafiro', 'kitchen', 1, 23000, 23000, 1, 'delivered', 'paid_total', 'Divididas en 2', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6db7f987-0ffc-5a11-90e5-76ea89493b6f', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2663c9a5-c099-545a-b008-2ea10b9a0116', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '024c48e9-2919-5d1a-9780-7036a9fdb475', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4dfa0a9b-58b6-5fbd-b29b-0dac7ebcdb75', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e5123cce-7ed3-5314-8614-6d3423ecc201', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3d3bb691-6369-5ffb-b283-8bbacfca6b89', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c41c9b82-2838-559a-8e40-db67b9a124f8', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1a037792-fa3e-5ce0-97de-bed16232979c', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'La Original', 'la-original', 'kitchen', 2, 24000, 48000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e0a1710-4c14-5d6a-a650-d72698a380f3', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Soda Italiana de MaracuyÃ¡', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '244b29ac-c636-582e-a951-f50e726fea06', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3af5e7ad-f928-54fd-bbeb-1e2fd3f9a2c4', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Empaque', 'empaque', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd1757185-579d-5b61-8ab6-2bcf98c2c443', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Jugo de Mango en Leche', 'jugo-de-mango-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a379f0f1-c43f-531b-bec4-00ca8423fb76', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Jugo de GuanÃ¡bana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fb38ba29-b212-5325-986d-384736a6cebf', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '62b173f1-cb43-57ea-9ebb-42c133a6cb63', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dea57815-076f-5d50-b914-74401d9601da', 'b4f8f126-4265-416e-8628-e965db52d100', null, 'BretaÃ±a / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '72a9ae4f-16e3-5022-9f84-325269223708', 'b4f8f126-4265-416e-8628-e965db52d100', null, 'Zumo de limÃ³n', 'zumo-de-limon', 'bar', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83ae1a51-ec31-5003-865e-460a804db975', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0feec9c5-c507-5809-9481-5f0ac55f3035', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71406c74-ef7e-52c6-a13f-5ec6df3719a9', '0645f808-4bf6-42d4-b059-82e729773888', null, 'Jugo video mango', 'jugo-video-mango', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0645f808-4bf6-42d4-b059-82e729773888'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dbb46c0d-dca8-5aea-be40-1224849a8cbb', '522f035f-d137-4845-8013-1640b4e97758', null, 'Jugo video cereza', 'jugo-video-cereza', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '522f035f-d137-4845-8013-1640b4e97758'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f50df5d0-0e12-5f05-a840-20e86742e38a', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '46de10bb-4390-5d6c-8c4a-03b9ff9c4c37', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Perrito descuento', 'perrito-descuento', 'kitchen', 1, 12000, 12000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7bdb0416-8c9c-55fa-b8da-452ab0ea7285', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2612e0e7-fcb4-5104-b3ab-26e03e03c11e', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '092c1b57-6ecc-5ab9-93d9-3c958337cc00', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b0df9eb0-aafb-53d3-8ac9-cefed4e7d5d7', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '63dab071-f55c-56d4-9d80-a1ad35bcaeb0', 'f1c42de6-4389-43fc-9613-23a252d3b063', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e5a40544-f75d-57bb-87ed-7d3623e156e9', '3e614951-a4c6-419e-a389-66520337da5a', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7f3349b3-f05b-587b-887c-d2c4e7c494c2', '3e614951-a4c6-419e-a389-66520337da5a', null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a22ac4f2-9481-5a77-979d-4638b551fc03', '3e614951-a4c6-419e-a389-66520337da5a', null, 'CosteÃ±a', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c9c77757-8c75-59f0-9a3b-7dfe840acd3d', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '08d58f45-2508-5b0f-8cc5-26621314d270', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f43673e7-b14b-56da-99b4-a0a4f01614af', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bfefc064-ab47-5573-b1ca-f0a07e63e6df', '04259209-f015-47b9-b1df-9aa324dc4d8f', null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd04803d3-5d46-5ddd-b669-86121e1c3a43', '04259209-f015-47b9-b1df-9aa324dc4d8f', null, 'Ãguila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8674cae6-72da-54c3-a1a3-301deb357b91', '825d025e-65de-4a28-a56d-474796cd8a31', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cdb2ba30-1da2-550d-9203-701c60dc172f', '825d025e-65de-4a28-a56d-474796cd8a31', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7a6d071d-d314-53af-94a9-fdc2c071d999', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b3d5fea1-f3f4-52a5-9a44-ed030e126e82', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ab333242-0df6-5a1a-9168-8241c88b36e7', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'MainsÂ Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '443bfe0c-0899-5276-8358-90e9d1c7909e', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5920eb40-f07b-5395-9bdc-e07c687ffc61', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b77af010-e700-5fec-b0f7-915cb79a5405', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd89489a4-0cb7-502d-a9dd-08cb4b91b73f', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '607a52ff-4d3c-5e58-9f94-79aa3890070a', '83811ff2-6a42-4042-83cf-fbb14b1a05a4', null, 'Ãguila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_order_items existing where existing.order_id = '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ef2de188-238d-5d4a-8e45-7a30266e5c29', '5f6c36a6-ea72-434c-a531-0d40271d99dc', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '81d2d9be-db4d-5cce-8426-62ac53117eee', '10c11ad2-3dc7-4ffa-ad2e-589948d5f646', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'other', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, 'Descontar del sueldo', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1e942af3-efa2-52d8-ad0b-46a9392170c2', '6914e2f5-07c7-42b8-be44-eb567f03747a', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 44000, 44000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '500c769e-6afc-5c24-a7e0-294e74f89184', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 62000, 62000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '742d181d-07f7-57ad-9fb2-94f8ddf0476f', 'a113fef6-fb98-4260-9070-80042910f289', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'a113fef6-fb98-4260-9070-80042910f289'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '221b8c4e-d9a0-5b89-8e3b-5122bfcd79f6', 'ba3c5059-0ba0-4839-8c98-3180f971a271', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'bank_transfer', 'confirmed', 'total', 78000, 78000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e79dce65-098c-5983-b152-a2ff653aa720', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'bank_transfer', 'confirmed', 'total', 80000, 80000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd1c17c05-aa0f-556a-b479-00ec6cb4067b', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 38000, 38000, 0, '[]'::jsonb, null, 'Se debe', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3d5c61b5-a634-512f-b1f3-12fd9df553cb', '90df6e99-c8ae-4678-a816-d347955de1dd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1a3aba8b-4a91-5df3-b7bb-e4893dd2383a', '90df6e99-c8ae-4678-a816-d347955de1dd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '90df6e99-c8ae-4678-a816-d347955de1dd'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b266b5a3-1e98-589a-be69-058a3fcc1b94', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 93000, 93000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b03525cf-bbd5-53da-a3d8-a7e4ffd4d8cd', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'c9b89425-840d-53c5-b776-8d1377d75824', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 101000, 101000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f7eff0a0-212c-5374-aebb-b04d83a52bf1', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'bank_transfer', 'confirmed', 'total', 65000, 65000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'bd237570-61e6-5c36-b79c-1ce7aaf5a682', '14a32cde-5e31-478f-84f4-dc281012ebb3', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 17000, 17000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '76e67ee6-92b7-5721-af05-5219e4e32244', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 16000, 16000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '949d10e1-c48e-5a2a-b328-14a173d2b27a', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 88000, 88000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '14bcdd1b-80bf-57d1-9606-bf3c2945bb46', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '5dc19bed-7501-5b1a-a636-2e132fbc816a', '9ea3687b-7126-49f5-a692-55ad244b42ee', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 142000, 142000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '56c0ca58-dfc7-586f-a7d6-d41d30a30538', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '9c42914d-a304-5edd-a66c-094686955638', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 41000, 41000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '551a1602-8f60-5912-a14b-2e349efdc7a5', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 67000, 67000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '04e3ca48-9f7e-56ae-ac26-402698766626', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '0e2ada4a-3771-52a1-a149-5db8c9767f69', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 63000, 63000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'da877439-610a-5259-8c24-a46b90a8767b', '593359c4-ceb7-4f02-b2cf-46d259202acb', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ae1df967-c7f3-55c3-ae85-e734600b1cd9', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'fe88616f-cf6c-50ae-9d90-b9135ea261a1', '26e809e6-d86a-47ed-8339-85708600a40e', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 86000, 86000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '26e809e6-d86a-47ed-8339-85708600a40e'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '96a99e59-06fc-5e48-aec3-9ac4ebad863f', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 59000, 59000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f6540b98-2254-54d1-aab4-973029ce12a4', '355daae2-f2de-48be-814e-d4580a858e4c', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 60000, 60000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '355daae2-f2de-48be-814e-d4580a858e4c'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a2325dcc-d51b-50e9-95b8-2a7bb83d908f', '72698c72-61db-4294-ad32-743bfba0af3e', '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '72698c72-61db-4294-ad32-743bfba0af3e'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f45727fc-5e32-5c99-9269-d13a1b7ef468', 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '19c33d3d-880b-5545-aedf-95f5a56926fe', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'fd87784a-a7d7-58a0-ba35-c62be5fcee0a', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 27000, 27000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '239bc1b1-5545-5dc3-b945-3c4400403b4d', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3250bf2e-0cf4-52c5-8cf3-afbf76b4abe7', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'cash', 'confirmed', 'total', 18000, 18000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'df9706cc-b422-5e49-842d-80890c9d097f', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46142a57-894a-42d7-81d1-82f06a88e20f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b074cf8b-6c4c-5d07-8489-fa9718a4d6c7', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 110000, 110000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '4047abfa-7f7b-5433-a883-1bbc996bc7ed', '9fbd6c34-66a7-40a0-9b50-969dc0d17abb', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 40000, 40000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '002730d9-195d-5025-97b2-03497ec6491a', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7d5ea50d-975d-501a-905a-11ce4659bcef', '50a53517-864f-44d9-b9c9-516dd21f05d8', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b944e6b8-8423-5dab-abc1-0c79a5974cff', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'pending', 'total', 7000, 7000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
where not exists (select 1 from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e0d988bd-5646-5eff-ac74-263a4301fe63', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '0c9b6fbc-bc21-5dcf-84b1-8c94bfdd0db5', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'c4068b0c-b063-5c77-b51c-3942340f4aaf', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'pending', 'total', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
where not exists (select 1 from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '12f6fb40-bd0d-5b8f-a4c4-6f34d4ff91a2', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e1d2adc0-1983-5d7b-a116-58a30031a639', '1bec3141-0350-414d-8c12-4fc3c06e40a4', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'pending', 'total', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
where not exists (select 1 from public.pos_payments existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd7497d94-2765-5032-b9ee-d7b9db61d07d', '1bec3141-0350-414d-8c12-4fc3c06e40a4', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '970afd3d-fe35-546f-9b4d-3889a1ab9cbb', 'f49a1572-86cd-48d8-86b1-89ead2157652', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 22000, 22000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'f49a1572-86cd-48d8-86b1-89ead2157652'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a0662f06-c8e9-5864-98f6-2ac148086327', 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7f22d7c2-46a2-5dd2-afab-6d9aaf43e4fa', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 56000, 56000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '653ce784-73a9-5ff9-b1f5-9d645055d42c', '681314b0-53d7-4c32-8213-1a804cb304c5', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 43000, 43000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '681314b0-53d7-4c32-8213-1a804cb304c5'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '915e3140-1880-52cd-80f3-35d373d251da', '1fc00905-31b6-429f-873f-1a4e58303669', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 32000, 32000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '1fc00905-31b6-429f-873f-1a4e58303669'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '44588ddd-d006-5c63-a1f6-75e72527df2c', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '9ffe294c-aba1-567f-b26e-b5d291b922e9', 'cd11c35c-1fba-4398-84b9-7a4b90bacbab', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'badee718-ef4d-50b5-a6ff-0851cef781ae', '0470d9df-4237-4811-9ef8-d2a40e1d6371', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 28000, 28000, 0, '[]'::jsonb, null, 'Cambio por nequi', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '2744a65c-6ca9-5fd4-8387-fa4590c32e6f', '78c8e74c-48be-4d0b-a996-525d33f70fbb', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7bece880-88f4-5b03-ac64-64c013e2d85d', '7cefad24-a203-455e-932a-5c564f2a3624', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '7cefad24-a203-455e-932a-5c564f2a3624'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '59345efa-675a-57ed-8480-8e6e379ac07e', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '8bc5dc01-0ae2-5a24-a6cf-2a7c4b86f9f8', 'faebbf42-ace3-47f9-9df3-2d23b2e76e79', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '6fb97149-04de-5603-b853-15dd53996918', '695c6444-6e6d-474e-b599-646c930484ed', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 3000, 3000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '695c6444-6e6d-474e-b599-646c930484ed'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a4e2ffa8-fdcc-582f-ab2e-6103eed54d5c', '2f0a2ca0-a496-45c2-804b-11d4c3957218', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'eb462425-affc-5012-b606-c2962281ab03', '153e1b85-3e78-4f62-bbb9-a1ce34b5b724', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '076ad70d-add2-599c-a678-cd61159c0fe1', '0465fded-62e7-4331-8c86-7ca920fe5006', '929b3f56-e936-4e8c-8183-962bd63115d4', 'cash', 'confirmed', 'total', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0465fded-62e7-4331-8c86-7ca920fe5006'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1cd61109-6a5a-5ef9-b2c7-7f6365b51ae3', '566f932d-4c7c-4962-a5fc-6959fc96be0f', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 295000, 295000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '027e7620-5aa8-58a8-879d-79f104bf67b8', '8a16e76b-ffb9-406f-b437-b089915b6994', 'a514e729-b6e1-437c-b0ce-ae6d8d81be15', 'nequi', 'confirmed', 'total', 51000, 51000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '8a16e76b-ffb9-406f-b437-b089915b6994'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '41bcba6c-7980-5544-a67d-a70cffceb868', 'bacf03d0-c7c3-492a-96eb-fb897a0297dc', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '00721698-c85f-56be-853a-e2faca163bfa', '99e279d9-995c-4c05-9c55-5b89814a6d09', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'cash', 'confirmed', 'total', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3e749979-9e29-5442-8e89-fc6f33a93c4f', '54388ffc-8714-412a-bb98-73e13e89edab', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'bank_transfer', 'confirmed', 'total', 102000, 102000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '54388ffc-8714-412a-bb98-73e13e89edab'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a50099a2-3a93-537e-a69c-010c0fe99f4b', '69cfc190-78db-4eda-bcb2-3dd821844091', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '69cfc190-78db-4eda-bcb2-3dd821844091'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3ce27653-72f6-5737-a560-859cd2b13dc8', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'cash', 'confirmed', 'total', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3d5e6dbc-b13f-5405-ad55-f222761d3e06', '46503d83-e948-46eb-a5d6-7cc57b192414', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '46503d83-e948-46eb-a5d6-7cc57b192414'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7e4aaa85-0b53-5974-99df-c7619d84fc7f', 'b8d45027-1623-4281-8a4c-5e1303f67563', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'bank_transfer', 'confirmed', 'total', 71000, 71000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'b8d45027-1623-4281-8a4c-5e1303f67563'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd1cc0fbc-7298-59f6-af73-fae88445a8fa', 'b4f8f126-4265-416e-8628-e965db52d100', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'b4f8f126-4265-416e-8628-e965db52d100'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'dc502895-dd1d-523b-b356-f9329de5302f', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 42000, 42000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '569a0e47-8b9a-5d24-85a5-94987e01c362', '0645f808-4bf6-42d4-b059-82e729773888', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0645f808-4bf6-42d4-b059-82e729773888'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ae1dbc1e-e1ea-5f1f-8631-2c2765d96e2d', '522f035f-d137-4845-8013-1640b4e97758', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '522f035f-d137-4845-8013-1640b4e97758'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e9959968-3595-5d72-97ba-02f7b21b9b53', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '288c519f-8a73-58d9-b091-76427430fbcc', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'bad4f480-e279-522f-bdfe-876cabd21f8e', 'f1c42de6-4389-43fc-9613-23a252d3b063', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'cash', 'confirmed', 'total', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = 'f1c42de6-4389-43fc-9613-23a252d3b063'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd88d9d3d-7b4e-5f6d-bfc9-cfaee40d21ee', '3e614951-a4c6-419e-a389-66520337da5a', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '268e04ed-ee53-540d-85de-d089472f1dcf', '3e614951-a4c6-419e-a389-66520337da5a', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '3e614951-a4c6-419e-a389-66520337da5a'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ffa489e5-c494-59b0-ab86-a48f53261dc5', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '5eaf7462-8693-53d0-bb8c-0aa7ce4f3d47', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '956e969f-2183-58ff-9f5f-f6b8d96917da', '04259209-f015-47b9-b1df-9aa324dc4d8f', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 35000, 35000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '658cb66d-f17b-5f83-9771-e2b90bfa9780', '825d025e-65de-4a28-a56d-474796cd8a31', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'bank_transfer', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '825d025e-65de-4a28-a56d-474796cd8a31'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '68fa092f-03b0-5202-8a6f-7c9a6ae5556e', '0b98d323-e92f-452b-97ae-82215314a9fb', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'nequi', 'confirmed', 'total', 132000, 132000, 0, '[]'::jsonb, '7992', null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '0b98d323-e92f-452b-97ae-82215314a9fb'::uuid)
on conflict (id) do nothing;
insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a18a7808-81fd-543c-b5f3-8440e8a93738', '83811ff2-6a42-4042-83cf-fbb14b1a05a4', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'cash', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
where not exists (select 1 from public.pos_payments existing where existing.order_id = '83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid)
on conflict (id) do nothing;

commit;
