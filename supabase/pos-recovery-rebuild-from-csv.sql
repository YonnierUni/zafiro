-- POS recovery rebuild from CSV exports.
-- Run after pos-prevent-table-cascade.sql. It archives current recovered details, rebuilds products/payments from CSV, and fixes official session summaries.


begin;

create table if not exists public.pos_deleted_records_archive (id uuid primary key default gen_random_uuid(), archived_at timestamptz not null default timezone('utc', now()), source_table text not null, source_id uuid, row_data jsonb not null);

create temp table recovery_csv_orders (id uuid primary key, sales_session_id uuid not null) on commit drop;

insert into recovery_csv_orders (id, sales_session_id) values
('04259209-f015-47b9-b1df-9aa324dc4d8f'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid),
('0465fded-62e7-4331-8c86-7ca920fe5006'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid),
('0470d9df-4237-4811-9ef8-d2a40e1d6371'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('0645f808-4bf6-42d4-b059-82e729773888'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('0a3c26cf-15fa-4255-9275-499f8c4f52b2'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('0b98d323-e92f-452b-97ae-82215314a9fb'::uuid, 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid),
('10c11ad2-3dc7-4ffa-ad2e-589948d5f646'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('14a32cde-5e31-478f-84f4-dc281012ebb3'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('153e1b85-3e78-4f62-bbb9-a1ce34b5b724'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid),
('173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('1bec3141-0350-414d-8c12-4fc3c06e40a4'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('1cd556fd-3cc9-4db4-b54b-536e94ca22bd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('1fc00905-31b6-429f-873f-1a4e58303669'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('26e809e6-d86a-47ed-8339-85708600a40e'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('2f0a2ca0-a496-45c2-804b-11d4c3957218'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid),
('355daae2-f2de-48be-814e-d4580a858e4c'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('3e614951-a4c6-419e-a389-66520337da5a'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid),
('46142a57-894a-42d7-81d1-82f06a88e20f'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid),
('46503d83-e948-46eb-a5d6-7cc57b192414'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('4e33d0ec-e975-4a0d-b471-e1e951b2688b'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('4ea5e71f-f2d4-47c9-b77f-e04248d8f668'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('50a53517-864f-44d9-b9c9-516dd21f05d8'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('522f035f-d137-4845-8013-1640b4e97758'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('54388ffc-8714-412a-bb98-73e13e89edab'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('566f932d-4c7c-4962-a5fc-6959fc96be0f'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid),
('593359c4-ceb7-4f02-b2cf-46d259202acb'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('5f6c36a6-ea72-434c-a531-0d40271d99dc'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('681314b0-53d7-4c32-8213-1a804cb304c5'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('6914e2f5-07c7-42b8-be44-eb567f03747a'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('695c6444-6e6d-474e-b599-646c930484ed'::uuid, '929b3f56-e936-4e8c-8183-962bd63115d4'::uuid),
('69cfc190-78db-4eda-bcb2-3dd821844091'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('6e9ffa4d-7a3e-4910-9441-cb70c54e02c4'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('71c2075e-bf5f-4531-85a6-1139f5ceaa47'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('72698c72-61db-4294-ad32-743bfba0af3e'::uuid, '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid),
('78c8e74c-48be-4d0b-a996-525d33f70fbb'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('7922b6cd-c2ea-4df9-85e5-586783afcc8d'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid),
('7cefad24-a203-455e-932a-5c564f2a3624'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('825d025e-65de-4a28-a56d-474796cd8a31'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid),
('83811ff2-6a42-4042-83cf-fbb14b1a05a4'::uuid, 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid),
('83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('85da1ae7-7385-4d90-9ab0-4aaacf29f2e8'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('877ee3ac-8d9b-4d3f-98f6-7956f292e416'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid),
('887cec88-8897-4cb6-8a6c-4aae3eb92de3'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('8a16e76b-ffb9-406f-b437-b089915b6994'::uuid, 'a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid),
('8c340a3b-fac0-46f3-8996-5a3fb6678feb'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('90df6e99-c8ae-4678-a816-d347955de1dd'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('99e279d9-995c-4c05-9c55-5b89814a6d09'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('9ea3687b-7126-49f5-a692-55ad244b42ee'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('9fbd6c34-66a7-40a0-9b50-969dc0d17abb'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid),
('a113fef6-fb98-4260-9070-80042910f289'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('a15b8cf8-8e34-4cf6-bc1f-9b638aba7203'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('a4ae9670-f0b4-4638-b02b-fb9f33dde038'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid),
('a9a1bee7-070d-4c86-a6f8-31b542a5fdf1'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('ad3415ff-3d54-44ee-9691-d57cd8f01b25'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d'::uuid, '8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid),
('b4f8f126-4265-416e-8628-e965db52d100'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('b8d45027-1623-4281-8a4c-5e1303f67563'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('ba3c5059-0ba0-4839-8c98-3180f971a271'::uuid, '0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid),
('bacf03d0-c7c3-492a-96eb-fb897a0297dc'::uuid, 'ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid),
('cd11c35c-1fba-4398-84b9-7a4b90bacbab'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('d38f98b4-16e3-40f2-81d7-d97f1dbd4da9'::uuid, 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid),
('d9cf2b65-d040-45f3-ba2a-db2aaf15409e'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('dd5b18d2-2fb1-464b-9322-4b58866a75ac'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid),
('eb368a47-a4b1-4ac4-bbf2-500b012f7b94'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('ec4580a9-70e8-4eb4-be68-75cd70717cd5'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('f1c42de6-4389-43fc-9613-23a252d3b063'::uuid, 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid),
('f49a1572-86cd-48d8-86b1-89ead2157652'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid),
('f7a7742d-fbed-4d43-8d83-1fdeaa2af222'::uuid, '36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid),
('faebbf42-ace3-47f9-9df3-2d23b2e76e79'::uuid, '8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid),
('fb31121c-bcba-4ef4-a0e8-0a8f81854907'::uuid, '2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid);

insert into public.pos_deleted_records_archive (source_table, source_id, row_data) select 'pos_payments_before_csv_rebuild', p.id, to_jsonb(p) from public.pos_payments p join recovery_csv_orders r on r.id = p.order_id;

insert into public.pos_deleted_records_archive (source_table, source_id, row_data) select 'pos_order_items_before_csv_rebuild', i.id, to_jsonb(i) from public.pos_order_items i join recovery_csv_orders r on r.id = i.order_id;

delete from public.pos_payments p using recovery_csv_orders r where p.order_id = r.id;

delete from public.pos_order_items i using recovery_csv_orders r where i.order_id = r.id;

insert into public.pos_deleted_records_archive (source_table, source_id, row_data) select 'pos_orders_detached_before_csv_rebuild', o.id, to_jsonb(o) from public.pos_orders o where o.sales_session_id in (select distinct sales_session_id from recovery_csv_orders) and not exists (select 1 from recovery_csv_orders r where r.id = o.id);

update public.pos_orders o set sales_session_id = null, notes = trim(coalesce(o.notes,'') || ' | Separada de jornada por reconstruccion CSV; no coincide con orden_id exportado.') where o.sales_session_id in (select distinct sales_session_id from recovery_csv_orders) and not exists (select 1 from recovery_csv_orders r where r.id = o.id);

-- Reinsert CSV products and payments extracted from pos-recovery-from-exports.sql.

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '78340466-f55a-5063-9bc9-32f193d065c0', '5f6c36a6-ea72-434c-a531-0d40271d99dc', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b7ac7980-690d-54c2-a3bf-34b336fbc38d', '10c11ad2-3dc7-4ffa-ad2e-589948d5f646', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3864a0d3-d94a-5c59-a1b6-85d53e67ca3d', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '347df39d-d1b6-5bf7-8253-ff082a9f4686', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'da8923ce-293d-5e64-9224-c1a480fffcb9', '6914e2f5-07c7-42b8-be44-eb567f03747a', null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6815ccf2-77a1-56c0-bc3d-066e3722bce0', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '874ea675-77f6-5497-8161-f8772843a922', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fd4d7a08-28d5-5381-8e4c-ae7073ce9b0b', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a52e1855-2176-588c-b3e1-f3a6e824c3f9', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', null, 'Jugo de Maracuyá en Agua', 'jugo-de-maracuya-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f4b08f8-c780-553d-bb97-ac67108deece', 'a113fef6-fb98-4260-9070-80042910f289', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '42af7ea3-d4c4-5dc3-b6bf-d41a1f105c93', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c2ca7652-6ade-5ef9-9db6-d4323355e5f6', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '41d6b3a3-78a4-5a7c-b8ad-5639a4e9dfc1', 'a113fef6-fb98-4260-9070-80042910f289', null, 'Huevos Hogaos', 'huevos-hogaos', 'kitchen', 1, 15000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '84cd912b-026d-59b7-a76e-e3f7e10e6386', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71927ce9-de96-549a-9031-2dab514d8990', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b6c935d1-ef6e-5440-8bda-febd5f334abe', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0576d42f-443a-5e77-953a-2cbaa82b304f', 'ba3c5059-0ba0-4839-8c98-3180f971a271', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cddbbb80-05b6-58e4-8c6f-34142cb075b2', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83d0a038-91ba-5144-8a6a-f43ae8effe06', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Limonada de Mango Biche', 'limonada-de-mango-biche', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '669a2125-206a-5f0b-99a4-c435620a6af1', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Quesadilla Zafiro', 'quesadilla-zafiro', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ae38f7e7-da51-57f9-b61a-24c265955145', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bf3bff60-25a5-5580-abda-51f649a5e3f8', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Águila', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f38c4bef-1891-5c45-a65f-7cfc6d86d392', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '49ecd6a1-027d-5332-8a28-90901717feb8', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', 'Harta leche en polvo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8f7e9a40-5e26-5608-be98-5d9d46e5b4c0', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Squash Personal', 'squash-personal', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9446008b-7c21-5ad2-b67a-e21b79b69c82', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd4c76bd5-7957-54d2-831c-6d9002f7b974', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6009ecf4-4ca7-5482-8dd5-aee7a8b8f1c4', '90df6e99-c8ae-4678-a816-d347955de1dd', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8eec4631-8458-5213-be86-220aa60e7834', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '95021bd9-9ebc-593c-a06a-8b373aadb02b', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1bb2d3ed-1be5-5c04-98d3-722e124aebc2', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Soda', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8dac99cc-8043-5463-ae81-63a0eacee9db', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '25a84398-ad6c-5f7c-b610-4f7a60a017ce', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'La Reina Doble', 'la-reina-doble', 'kitchen', 1, 28000, 28000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bb4a1e1a-573e-59cd-8b59-c7a30b720465', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '77f1f581-1001-5cbe-9919-02f93b61ab83', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '094dba66-1d19-5668-86f1-602778cb3e4f', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '899a7fc6-ad1c-517c-a32d-0e901ce4b6f5', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Aguardiente Negro / Verde Media', 'aguardiente-negro-verde-media', 'bar', 1, 55000, 55000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f3c600bd-320b-5571-b0ec-8d39d2016fac', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ae6dd0db-98a4-5de3-8919-0a30a5719629', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd0a1f8d3-a4df-5882-aaf2-b65f5c3554ba', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Cubetazo light', 'cubetazo-light', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', 'Variada', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '652cec3e-a54d-5f4f-91aa-24b3799b40f2', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a6be569d-a0c9-5631-a8d1-485974943f62', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', null, 'Águila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1301d188-7945-574e-aa4b-dd0bffebf954', '14a32cde-5e31-478f-84f4-dc281012ebb3', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ef09faa4-52b5-5a27-b209-5f89104f612c', '14a32cde-5e31-478f-84f4-dc281012ebb3', null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '69b28a57-d46d-518d-adf4-26362ed1a5ed', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2f6d22f6-985b-577a-90ac-b0f23cef0295', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c14dba97-a62a-5b9a-b2b0-8e7837c196c8', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', null, 'Papas adicion', 'papas-adicion', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '33d8c473-96f1-51f3-9f5a-35eee9c4d13f', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a35f3b4a-eca2-5c64-81fd-91024bf81316', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dd46838a-66cd-570c-9e34-4211aaf6ebb6', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd4c84e32-c9e4-5513-bbe9-a517d9e31262', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c70ee00a-a1ae-5d40-bee5-ac7aecc09259', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7a792eea-3743-5b1f-a945-e7ba440d0520', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ec9b67d2-83e4-513d-8307-2076f6c7f265', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2dad6f49-cee5-5d09-8dd7-967a6aa173c0', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c76e717b-9f08-5dc9-9191-b029bf198823', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Corn Dog Zafiro Bites', 'corn-dog-zafiro-bites', 'kitchen', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ced7ae12-aac2-505e-a5a1-3fff7598d293', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '030890da-f3b7-5502-a7ff-aae72d6025d9', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '109d24b5-86f7-576c-9aab-338a895a06c5', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f9b63d5b-7a07-512f-9b89-a825afc5b198', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e4c6dcc9-0266-5f54-8045-6112c8029bca', '9ea3687b-7126-49f5-a692-55ad244b42ee', null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '05f51533-8686-5c83-afe7-d236dc17e75b', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3d5a6b93-dbcf-5df6-99bf-f11ed053c084', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2b2932ef-3d17-5b40-bff5-68313d226264', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8204b99d-fba7-50eb-9eb5-8ee12d75d500', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '61232c6b-cdc6-5dba-9d4c-3d4409d73aa1', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9e37b46c-0566-54d0-8023-0266eb3f596e', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd44d3a76-475c-54dc-8b97-7e7d633a5d62', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Perrito Loco', 'perrito-loco', 'kitchen', 1, 19000, 19000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f0cc5de6-2743-5a02-ba81-2748d974fd9a', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9bffc62d-927a-5a0f-9beb-0aa14f521175', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', 'Mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83445eab-aaff-50ed-9d8d-6b65125bbcab', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '787791fe-a921-5e9d-96c3-94e0debc2322', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '60b26e92-544f-5b63-82c4-f1addfe65f9f', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', 'Sin lechuga y sin pico de gallo', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd6d26ea1-7b54-5b84-8b54-f122ef773139', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 2, 25000, 50000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e847e976-b6e3-5782-a9e0-8ceb7c797223', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Gin-Tonic', 'gin-tonic', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'af5cefa9-22be-5dac-a505-a59ab0566300', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1878fe4f-9b4f-53e7-a218-2cb30702ff76', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ebb268d5-71a4-5f42-b1f6-3753b0e48e29', '593359c4-ceb7-4f02-b2cf-46d259202acb', null, 'Águila Original', 'aguila-original', 'bar', 3, 5000, 15000, 1, 'delivered', 'paid_total', 'Light', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '07fb062e-8258-529d-92d7-65a724d0ebe4', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2a905e58-a13e-5cda-89fe-ac68c251b48b', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e05dfce-13f1-5f78-a25f-020027d5200e', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd28d0a3f-8532-5088-88a6-fd777238e769', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Michelada Sin Alcohol Frutal', 'michelada-sin-alcohol-frutal', 'bar', 1, 15000, 15000, 1, 'delivered', 'paid_total', 'Ginger', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '77ab9482-b429-5abd-a439-53b9d038befc', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '89770d84-77cd-5b6e-9efe-a39affb0b8f7', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bcbac0e4-683e-59b3-9434-7cd1e6fef96b', '26e809e6-d86a-47ed-8339-85708600a40e', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5bbab18e-943c-56e4-bb36-93d31df605c8', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '94e0533b-c2d6-5eb2-9575-6091895fbbb9', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '06e86836-0e5e-5581-bb08-cc7fe8100a26', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Salchipapa Corte Zafiro', 'salchipapa-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '97f40e56-08c6-5271-b710-d449d81fef0a', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '893af861-1d16-5e78-b076-0e50a5066fe9', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b22c9f1d-ca2b-575c-aaa3-6a1a606a570b', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '471525db-03f6-50fd-9b09-109ae1c74008', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Corona, frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '36a871cb-3a88-59b6-8c7f-cee789651489', '355daae2-f2de-48be-814e-d4580a858e4c', null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '27be8274-3a2c-564f-acf2-4a766fa708bf', '72698c72-61db-4294-ad32-743bfba0af3e', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '04295b5e-4976-5e11-a4fe-a733cc97982c', 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d', null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Steeven, la paga mañana', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '53f89c43-8a36-5922-8116-ed60b3bdec8b', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '255a906c-b8da-531f-99ae-7df3574124e1', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd8e4cbfc-1e84-51a7-b926-3d30e6d223be', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0d40a3b1-c0d0-57c1-846b-706085ed4e4f', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Daiquiri', 'daiquiri', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cf83f04a-e48b-5c4a-88ce-b014714897c2', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a94a0611-8899-5541-8941-a19d779c0acb', '46142a57-894a-42d7-81d1-82f06a88e20f', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Con bastante limón', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'add4a317-cb28-5d6e-8221-4bbd190db080', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'aa126958-8e38-57ea-b5a1-f8bf48b35f2c', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Smirnoff Ice Personal', 'smirnoff-ice-personal', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '72bd8a3f-e3e5-5358-a181-863e21baa503', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', null, 'Margarita', 'margarita', 'bar', 2, 22000, 44000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2cf5c346-7d88-5a59-8adb-cd62a4e7139f', '9fbd6c34-66a7-40a0-9b50-969dc0d17abb', null, 'Mojito', 'mojito', 'bar', 2, 20000, 40000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ed7cc353-72e3-5ee8-8954-3fc46bc80c92', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '46bc7ae7-264f-51ee-af10-7017428a3f63', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', null, 'Poker', 'poker', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3cf45b4c-ad76-5a27-adbc-de140e8158a5', '50a53517-864f-44d9-b9c9-516dd21f05d8', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd2733e1d-caf7-5f9d-b155-aa28b7c28e05', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Papas a la francesa', 'papas-a-la-francesa', 'kitchen', 1, 7000, 7000, 1, 'delivered', 'paid_total', 'Bien ricas', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9ee1ddf8-265c-5ae2-9fe4-ad376322dacd', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Poker', 'poker', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4673df98-3550-5b47-88e0-02b1e80954be', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '95bcf3d2-2045-585d-b9fa-4fd6966e7a3a', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '9780b850-dd27-5c88-8898-df8c7a023c03', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Jugo de Mora en Agua', 'jugo-de-mora-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Poco fría', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7540c203-c631-529e-b1a3-03b545953be7', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Yonnier', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4357ca6f-708c-5c3c-8571-f9b7d404281e', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ba8a500b-d52e-5cb8-816b-f22f87389439', '173aadce-cba6-453d-92da-5fe26a21e69d', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0d1cb93a-5f0e-5883-aa67-07f938c1fe37', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', 'Sin cerezas y más limon', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cd7dffc1-933e-559f-9728-7d76a0f982e0', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2919f8aa-2b85-5240-9399-5205bfbef24c', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Speed Max', 'speed-max', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Con doble shot de tequila x20.000$', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0fab2bdd-3e3b-53ad-b902-c2b43c055dd9', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Speed Max', 'speed-max', 'bar', 4, 5000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0eb15194-97f7-5163-b643-0fd278fcdf1b', '1bec3141-0350-414d-8c12-4fc3c06e40a4', null, 'Limonada de Sandía', 'limonada-de-sandia', 'bar', 2, 10000, 20000, 1, 'delivered', 'paid_total', 'Shots de ron', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ed52ff9f-a94e-51f8-84d4-bbc316dea842', 'f49a1572-86cd-48d8-86b1-89ead2157652', null, 'Margarita', 'margarita', 'bar', 1, 22000, 22000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '61d89a88-1266-56e7-8029-4e57093abd62', 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203', null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', 'Keyner el negro', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fdd17b21-a462-529f-9469-f5915a9b72df', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b5c2373d-a691-5cdb-a208-48190103eec7', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Jugo de Mango en Agua', 'jugo-de-mango-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Sin azúcar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6330aa13-d51d-56dc-9977-cebe78826839', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Cuba Libre', 'cuba-libre', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2b2bae07-9151-5701-9817-28a9114b1395', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', 'Zumo de limón', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '942a8577-9d25-588e-bf7f-7ac8f4b9aef2', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Jugo de Arazá en Leche', 'jugo-de-araza-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7b75886c-a7d2-5468-b209-dc6fcdfec445', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0e5e0d49-e09b-52f7-881b-2e028f59d298', '681314b0-53d7-4c32-8213-1a804cb304c5', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'de126ed9-08ab-510e-9d21-f26d0cba5b17', '1fc00905-31b6-429f-873f-1a4e58303669', null, 'Jugo de Fresa en Agua', 'jugo-de-fresa-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7e27535a-e465-503f-b9ae-2db2fcc879df', '1fc00905-31b6-429f-873f-1a4e58303669', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', 'Con queso cheddar', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f9c8154a-b29e-56d0-bdfb-e9fb9886a597', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', null, 'Michelada Ginger Ale', 'michelada-ginger-ale', 'bar', 1, 14000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5fbabf04-b0d0-5609-807e-9a09efa0d938', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '894c8834-124d-5166-84dc-90d55922b0fd', 'cd11c35c-1fba-4398-84b9-7a4b90bacbab', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b7f51341-f841-5f73-a2ef-b1feeeeb3596', '0470d9df-4237-4811-9ef8-d2a40e1d6371', null, 'Corona', 'corona', 'bar', 2, 9000, 18000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2c673127-4201-582b-9786-d059fbd903fe', '0470d9df-4237-4811-9ef8-d2a40e1d6371', null, 'Costeña', 'costena', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '964c47f6-bc74-5c97-bd77-0b88196897f4', '78c8e74c-48be-4d0b-a996-525d33f70fbb', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e56f17cb-7a1f-54a2-98aa-c17e60ead708', '7cefad24-a203-455e-932a-5c564f2a3624', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f243c234-e528-5310-8b72-3a583aa8d80e', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71026046-0f06-5676-b05e-19a915973c7b', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f77ef6e7-1c61-56e4-9cfd-f0b180e02101', 'faebbf42-ace3-47f9-9df3-2d23b2e76e79', null, 'Águila Original', 'aguila-original', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '80c830f3-8fd8-5d43-8d4a-5c7885ea661a', '695c6444-6e6d-474e-b599-646c930484ed', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ad2d5bca-14a8-5adf-95e2-d9ecd82652eb', '2f0a2ca0-a496-45c2-804b-11d4c3957218', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7cf48677-3a4e-5956-a465-40d0aa8ef1e8', '153e1b85-3e78-4f62-bbb9-a1ce34b5b724', null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fb8f1452-eff5-5874-8595-7e8463ac1d4e', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Zumo de Limon', 'zumo-de-limon', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e73484e2-9cf3-5e0a-a2d3-1556cd1c0a10', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ce24d57b-e733-5b7c-86eb-6703567b82d1', '0465fded-62e7-4331-8c86-7ca920fe5006', null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '791a8184-de74-5e72-9e64-aa5c8cc19286', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 2, 21000, 42000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3477e61f-6a73-535c-9872-cb5f35f35b3f', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Club Colombia', 'club-colombia', 'bar', 2, 8000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fa37b5a7-a8d6-577d-a784-7ba13cf95860', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a88f0813-7440-5f1d-8060-9fd2b088d020', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Budweiser', 'budweiser', 'bar', 2, 7000, 14000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e67f3043-3a4e-5bc7-a2bf-084e411328e2', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3b8b2516-b5dd-50ad-81fb-4b9c8f7b15e5', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Old Parr Media', 'old-parr-media', 'bar', 1, 180000, 180000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cf7fef10-963c-5200-a2ee-93095805eb4f', '566f932d-4c7c-4962-a5fc-6959fc96be0f', null, 'Club Colombia', 'club-colombia', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bb14e885-7bfe-5827-8a7c-4218cf45bb90', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Reina Pepiada', 'reina-pepiada', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd48fb4a5-0dc4-5163-b3c7-531c0045f50e', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1f129cf9-a290-5bc3-8749-1b5ce8231377', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Canada Dry', 'canada-dry', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '99e68dda-7d10-5ed6-ba0f-928670e01976', '8a16e76b-ffb9-406f-b437-b089915b6994', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '49e28f87-c25d-570b-aef8-a7fe6565f909', 'bacf03d0-c7c3-492a-96eb-fb897a0297dc', null, 'Coca-Cola', 'coca-cola', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '028d237a-0d52-5ee6-b890-c1a22758e0bb', '99e279d9-995c-4c05-9c55-5b89814a6d09', null, 'Bretana grande', 'bretana-grande', 'bar', 1, 6000, 6000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dd5bdbbe-6744-523b-9736-764d7edcced6', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Soda Italiana de Frutos Rojos', 'soda-italiana-de-frutos-rojos', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ee81787f-5bfa-5049-b1ff-1997bcffedc9', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 2, 13000, 26000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e1e1fbf0-8cea-5014-97a0-12cd17cb9ead', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '86e61301-331f-5935-a376-6b695acf6ec0', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Tortilla Desmechada al Zafiro', 'tortilla-desmechada-al-zafiro', 'kitchen', 1, 23000, 23000, 1, 'delivered', 'paid_total', 'Divididas en 2', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '6db7f987-0ffc-5a11-90e5-76ea89493b6f', '54388ffc-8714-412a-bb98-73e13e89edab', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 1, 16000, 16000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2663c9a5-c099-545a-b008-2ea10b9a0116', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '024c48e9-2919-5d1a-9780-7036a9fdb475', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Papas Corte Zafiro', 'papas-corte-zafiro', 'kitchen', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '4dfa0a9b-58b6-5fbd-b29b-0dac7ebcdb75', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e5123cce-7ed3-5314-8614-6d3423ecc201', '69cfc190-78db-4eda-bcb2-3dd821844091', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3d3bb691-6369-5ffb-b283-8bbacfca6b89', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c41c9b82-2838-559a-8e40-db67b9a124f8', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', 'Al clima', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '1a037792-fa3e-5ce0-97de-bed16232979c', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'La Original', 'la-original', 'kitchen', 2, 24000, 48000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5e0a1710-4c14-5d6a-a650-d72698a380f3', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Soda Italiana de Maracuyá', 'soda-italiana-de-maracuya', 'bar', 1, 13000, 13000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '244b29ac-c636-582e-a951-f50e726fea06', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '3af5e7ad-f928-54fd-bbeb-1e2fd3f9a2c4', '46503d83-e948-46eb-a5d6-7cc57b192414', null, 'Empaque', 'empaque', 'kitchen', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd1757185-579d-5b61-8ab6-2bcf98c2c443', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Jugo de Mango en Leche', 'jugo-de-mango-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a379f0f1-c43f-531b-bec4-00ca8423fb76', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Jugo de Guanábana en Leche', 'jugo-de-guanabana-en-leche', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'fb38ba29-b212-5325-986d-384736a6cebf', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '62b173f1-cb43-57ea-9ebb-42c133a6cb63', 'b8d45027-1623-4281-8a4c-5e1303f67563', null, 'Hamburguesa de la Casa', 'hamburguesa-de-la-casa', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dea57815-076f-5d50-b914-74401d9601da', 'b4f8f126-4265-416e-8628-e965db52d100', null, 'Bretaña / Soda', 'bretana-soda', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '72a9ae4f-16e3-5022-9f84-325269223708', 'b4f8f126-4265-416e-8628-e965db52d100', null, 'Zumo de limón', 'zumo-de-limon', 'bar', 1, 1000, 1000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '83ae1a51-ec31-5003-865e-460a804db975', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '0feec9c5-c507-5809-9481-5f0ac55f3035', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', null, 'Michelada Premium Frutal', 'michelada-premium-frutal', 'bar', 1, 21000, 21000, 1, 'delivered', 'paid_total', 'Smirnoff mango biche', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '71406c74-ef7e-52c6-a13f-5ec6df3719a9', '0645f808-4bf6-42d4-b059-82e729773888', null, 'Jugo video mango', 'jugo-video-mango', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'dbb46c0d-dca8-5aea-be40-1224849a8cbb', '522f035f-d137-4845-8013-1640b4e97758', null, 'Jugo video cereza', 'jugo-video-cereza', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f50df5d0-0e12-5f05-a840-20e86742e38a', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Agua Cristal', 'agua-cristal', 'bar', 1, 3000, 3000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '46de10bb-4390-5d6c-8c4a-03b9ff9c4c37', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Perrito descuento', 'perrito-descuento', 'kitchen', 1, 12000, 12000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7bdb0416-8c9c-55fa-b8da-452ab0ea7285', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', null, 'Limonada de Coco', 'limonada-de-coco', 'bar', 1, 10000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '2612e0e7-fcb4-5104-b3ab-26e03e03c11e', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Michelada Ginger Ale Frutal', 'michelada-ginger-ale-frutal', 'bar', 2, 16000, 32000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '092c1b57-6ecc-5ab9-93d9-3c958337cc00', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b0df9eb0-aafb-53d3-8ac9-cefed4e7d5d7', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '63dab071-f55c-56d4-9d80-a1ad35bcaeb0', 'f1c42de6-4389-43fc-9613-23a252d3b063', null, 'Jugo de Lulo en Agua', 'jugo-de-lulo-en-agua', 'bar', 1, 8000, 8000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'e5a40544-f75d-57bb-87ed-7d3623e156e9', '3e614951-a4c6-419e-a389-66520337da5a', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7f3349b3-f05b-587b-887c-d2c4e7c494c2', '3e614951-a4c6-419e-a389-66520337da5a', null, 'Michelada Frutal', 'michelada-frutal', 'bar', 1, 18000, 18000, 1, 'delivered', 'paid_total', 'Frutos rojos', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'a22ac4f2-9481-5a77-979d-4638b551fc03', '3e614951-a4c6-419e-a389-66520337da5a', null, 'Costeña', 'costena', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'c9c77757-8c75-59f0-9a3b-7dfe840acd3d', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Agua con Gas', 'agua-con-gas', 'bar', 1, 4000, 4000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '08d58f45-2508-5b0f-8cc5-26621314d270', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Sprite', 'sprite', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'f43673e7-b14b-56da-99b4-a0a4f01614af', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'bfefc064-ab47-5573-b1ca-f0a07e63e6df', '04259209-f015-47b9-b1df-9aa324dc4d8f', null, 'Cubetazo aguila', 'cubetazo-aguila', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd04803d3-5d46-5ddd-b669-86121e1c3a43', '04259209-f015-47b9-b1df-9aa324dc4d8f', null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '8674cae6-72da-54c3-a1a3-301deb357b91', '825d025e-65de-4a28-a56d-474796cd8a31', null, 'Choripan Argentino', 'choripan-argentino', 'kitchen', 1, 21000, 21000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'cdb2ba30-1da2-550d-9203-701c60dc172f', '825d025e-65de-4a28-a56d-474796cd8a31', null, 'Jugo Hit Surtido', 'jugo-hit-surtido', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '7a6d071d-d314-53af-94a9-fdc2c071d999', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Tostones Cartageneros', 'tostones-cartageneros', 'kitchen', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b3d5fea1-f3f4-52a5-9a44-ed030e126e82', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Mojito', 'mojito', 'bar', 1, 20000, 20000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'ab333242-0df6-5a1a-9168-8241c88b36e7', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Mains Zafiro', 'mains-zafiro', 'bar', 1, 25000, 25000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '443bfe0c-0899-5276-8358-90e9d1c7909e', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Desgranado El Resucitador', 'desgranado-el-resucitador', 'kitchen', 1, 29000, 29000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '5920eb40-f07b-5395-9bdc-e07c687ffc61', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Nachos Zafiro', 'nachos-zafiro', 'kitchen', 1, 24000, 24000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'b77af010-e700-5fec-b0f7-915cb79a5405', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Coca-Cola', 'coca-cola', 'bar', 1, 5000, 5000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select 'd89489a4-0cb7-502d-a9dd-08cb4b91b73f', '0b98d323-e92f-452b-97ae-82215314a9fb', null, 'Corona', 'corona', 'bar', 1, 9000, 9000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email)
select '607a52ff-4d3c-5e58-9f94-79aa3890070a', '83811ff2-6a42-4042-83cf-fbb14b1a05a4', null, 'Águila Original', 'aguila-original', 'bar', 2, 5000, 10000, 1, 'delivered', 'paid_total', '', 'recovery@zafiro.local', 'recovery@zafiro.local', timezone('utc', now()), timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ef2de188-238d-5d4a-8e45-7a30266e5c29', '5f6c36a6-ea72-434c-a531-0d40271d99dc', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '81d2d9be-db4d-5cce-8426-62ac53117eee', '10c11ad2-3dc7-4ffa-ad2e-589948d5f646', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'other', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, 'Descontar del sueldo', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1e942af3-efa2-52d8-ad0b-46a9392170c2', '6914e2f5-07c7-42b8-be44-eb567f03747a', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 44000, 44000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '500c769e-6afc-5c24-a7e0-294e74f89184', '6e9ffa4d-7a3e-4910-9441-cb70c54e02c4', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 62000, 62000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '742d181d-07f7-57ad-9fb2-94f8ddf0476f', 'a113fef6-fb98-4260-9070-80042910f289', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'nequi', 'confirmed', 'total', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '221b8c4e-d9a0-5b89-8e3b-5122bfcd79f6', 'ba3c5059-0ba0-4839-8c98-3180f971a271', '0fc2cad5-1577-4f77-83b2-b5690998e06f', 'bank_transfer', 'confirmed', 'total', 78000, 78000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e79dce65-098c-5983-b152-a2ff653aa720', 'd9cf2b65-d040-45f3-ba2a-db2aaf15409e', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'bank_transfer', 'confirmed', 'total', 80000, 80000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd1c17c05-aa0f-556a-b479-00ec6cb4067b', 'a9a1bee7-070d-4c86-a6f8-31b542a5fdf1', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 38000, 38000, 0, '[]'::jsonb, null, 'Se debe', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3d5c61b5-a634-512f-b1f3-12fd9df553cb', '90df6e99-c8ae-4678-a816-d347955de1dd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1a3aba8b-4a91-5df3-b7bb-e4893dd2383a', '90df6e99-c8ae-4678-a816-d347955de1dd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b266b5a3-1e98-589a-be69-058a3fcc1b94', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 93000, 93000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b03525cf-bbd5-53da-a3d8-a7e4ffd4d8cd', '1cd556fd-3cc9-4db4-b54b-536e94ca22bd', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'c9b89425-840d-53c5-b776-8d1377d75824', 'ad3415ff-3d54-44ee-9691-d57cd8f01b25', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'cash', 'confirmed', 'total', 101000, 101000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f7eff0a0-212c-5374-aebb-b04d83a52bf1', 'dd5b18d2-2fb1-464b-9322-4b58866a75ac', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'bank_transfer', 'confirmed', 'total', 65000, 65000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'bd237570-61e6-5c36-b79c-1ce7aaf5a682', '14a32cde-5e31-478f-84f4-dc281012ebb3', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 17000, 17000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '76e67ee6-92b7-5721-af05-5219e4e32244', 'fb31121c-bcba-4ef4-a0e8-0a8f81854907', '2e4d61ae-d48a-429a-9d56-d7538abab917', 'nequi', 'confirmed', 'total', 16000, 16000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '949d10e1-c48e-5a2a-b328-14a173d2b27a', 'f7a7742d-fbed-4d43-8d83-1fdeaa2af222', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 88000, 88000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '14bcdd1b-80bf-57d1-9606-bf3c2945bb46', 'ec4580a9-70e8-4eb4-be68-75cd70717cd5', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '5dc19bed-7501-5b1a-a636-2e132fbc816a', '9ea3687b-7126-49f5-a692-55ad244b42ee', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 142000, 142000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '56c0ca58-dfc7-586f-a7d6-d41d30a30538', '04f91ac2-2966-4b22-b8ca-1f5b5bb0b6b7', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '9c42914d-a304-5edd-a66c-094686955638', 'eb368a47-a4b1-4ac4-bbf2-500b012f7b94', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 41000, 41000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '551a1602-8f60-5912-a14b-2e349efdc7a5', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 67000, 67000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '04e3ca48-9f7e-56ae-ac26-402698766626', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '0e2ada4a-3771-52a1-a149-5db8c9767f69', '0a3c26cf-15fa-4255-9275-499f8c4f52b2', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 63000, 63000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'da877439-610a-5259-8c24-a46b90a8767b', '593359c4-ceb7-4f02-b2cf-46d259202acb', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 15000, 15000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ae1df967-c7f3-55c3-ae85-e734600b1cd9', '83b0e7e2-9ee4-40aa-8e1a-8038c9c77ef9', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'fe88616f-cf6c-50ae-9d90-b9135ea261a1', '26e809e6-d86a-47ed-8339-85708600a40e', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'cash', 'confirmed', 'total', 86000, 86000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '96a99e59-06fc-5e48-aec3-9ac4ebad863f', '4e33d0ec-e975-4a0d-b471-e1e951b2688b', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 59000, 59000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f6540b98-2254-54d1-aab4-973029ce12a4', '355daae2-f2de-48be-814e-d4580a858e4c', '36e3abba-1022-4b02-b199-4e6cc6d76fb6', 'nequi', 'confirmed', 'total', 60000, 60000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a2325dcc-d51b-50e9-95b8-2a7bb83d908f', '72698c72-61db-4294-ad32-743bfba0af3e', '3c2b9df9-1250-4800-ad1c-610b8d5eb4a3', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'f45727fc-5e32-5c99-9269-d13a1b7ef468', 'ad72a55e-f6d4-4a0f-be8a-170cb4eadc7d', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '19c33d3d-880b-5545-aedf-95f5a56926fe', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'fd87784a-a7d7-58a0-ba35-c62be5fcee0a', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 27000, 27000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '239bc1b1-5545-5dc3-b945-3c4400403b4d', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3250bf2e-0cf4-52c5-8cf3-afbf76b4abe7', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'cash', 'confirmed', 'total', 18000, 18000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'df9706cc-b422-5e49-842d-80890c9d097f', '46142a57-894a-42d7-81d1-82f06a88e20f', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b074cf8b-6c4c-5d07-8489-fa9718a4d6c7', '877ee3ac-8d9b-4d3f-98f6-7956f292e416', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 110000, 110000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '4047abfa-7f7b-5433-a883-1bbc996bc7ed', '9fbd6c34-66a7-40a0-9b50-969dc0d17abb', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 40000, 40000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '002730d9-195d-5025-97b2-03497ec6491a', 'a4ae9670-f0b4-4638-b02b-fb9f33dde038', '8481d2b5-b80f-40a7-9190-4aea56c9cdb2', 'nequi', 'confirmed', 'total', 20000, 20000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7d5ea50d-975d-501a-905a-11ce4659bcef', '50a53517-864f-44d9-b9c9-516dd21f05d8', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'b944e6b8-8423-5dab-abc1-0c79a5974cff', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'pending', 'total', 7000, 7000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e0d988bd-5646-5eff-ac74-263a4301fe63', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 81000, 81000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '0c9b6fbc-bc21-5dcf-84b1-8c94bfdd0db5', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'c4068b0c-b063-5c77-b51c-3942340f4aaf', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'pending', 'total', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '12f6fb40-bd0d-5b8f-a4c4-6f34d4ff91a2', '173aadce-cba6-453d-92da-5fe26a21e69d', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 12000, 12000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e1d2adc0-1983-5d7b-a116-58a30031a639', '1bec3141-0350-414d-8c12-4fc3c06e40a4', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'pending', 'total', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', null, null
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd7497d94-2765-5032-b9ee-d7b9db61d07d', '1bec3141-0350-414d-8c12-4fc3c06e40a4', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 72000, 72000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '970afd3d-fe35-546f-9b4d-3889a1ab9cbb', 'f49a1572-86cd-48d8-86b1-89ead2157652', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'bank_transfer', 'confirmed', 'total', 22000, 22000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a0662f06-c8e9-5864-98f6-2ac148086327', 'a15b8cf8-8e34-4cf6-bc1f-9b638aba7203', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'cash', 'confirmed', 'total', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7f22d7c2-46a2-5dd2-afab-6d9aaf43e4fa', '71c2075e-bf5f-4531-85a6-1139f5ceaa47', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 56000, 56000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '653ce784-73a9-5ff9-b1f5-9d645055d42c', '681314b0-53d7-4c32-8213-1a804cb304c5', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 43000, 43000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '915e3140-1880-52cd-80f3-35d373d251da', '1fc00905-31b6-429f-873f-1a4e58303669', '855c30a3-85d2-40c2-a309-a6d2b3762ff2', 'nequi', 'confirmed', 'total', 32000, 32000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '44588ddd-d006-5c63-a1f6-75e72527df2c', '4ea5e71f-f2d4-47c9-b77f-e04248d8f668', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '9ffe294c-aba1-567f-b26e-b5d291b922e9', 'cd11c35c-1fba-4398-84b9-7a4b90bacbab', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'badee718-ef4d-50b5-a6ff-0851cef781ae', '0470d9df-4237-4811-9ef8-d2a40e1d6371', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 28000, 28000, 0, '[]'::jsonb, null, 'Cambio por nequi', 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '2744a65c-6ca9-5fd4-8387-fa4590c32e6f', '78c8e74c-48be-4d0b-a996-525d33f70fbb', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7bece880-88f4-5b03-ac64-64c013e2d85d', '7cefad24-a203-455e-932a-5c564f2a3624', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '59345efa-675a-57ed-8480-8e6e379ac07e', '8c340a3b-fac0-46f3-8996-5a3fb6678feb', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '8bc5dc01-0ae2-5a24-a6cf-2a7c4b86f9f8', 'faebbf42-ace3-47f9-9df3-2d23b2e76e79', '8ece710e-b2a4-4985-a9ea-9e6b288704ac', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '6fb97149-04de-5603-b853-15dd53996918', '695c6444-6e6d-474e-b599-646c930484ed', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 3000, 3000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a4e2ffa8-fdcc-582f-ab2e-6103eed54d5c', '2f0a2ca0-a496-45c2-804b-11d4c3957218', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'eb462425-affc-5012-b606-c2962281ab03', '153e1b85-3e78-4f62-bbb9-a1ce34b5b724', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '076ad70d-add2-599c-a678-cd61159c0fe1', '0465fded-62e7-4331-8c86-7ca920fe5006', '929b3f56-e936-4e8c-8183-962bd63115d4', 'cash', 'confirmed', 'total', 19000, 19000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '1cd61109-6a5a-5ef9-b2c7-7f6365b51ae3', '566f932d-4c7c-4962-a5fc-6959fc96be0f', '929b3f56-e936-4e8c-8183-962bd63115d4', 'nequi', 'confirmed', 'total', 295000, 295000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '027e7620-5aa8-58a8-879d-79f104bf67b8', '8a16e76b-ffb9-406f-b437-b089915b6994', 'a514e729-b6e1-437c-b0ce-ae6d8d81be15', 'nequi', 'confirmed', 'total', 51000, 51000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '41bcba6c-7980-5544-a67d-a70cffceb868', 'bacf03d0-c7c3-492a-96eb-fb897a0297dc', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '00721698-c85f-56be-853a-e2faca163bfa', '99e279d9-995c-4c05-9c55-5b89814a6d09', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'cash', 'confirmed', 'total', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3e749979-9e29-5442-8e89-fc6f33a93c4f', '54388ffc-8714-412a-bb98-73e13e89edab', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'bank_transfer', 'confirmed', 'total', 102000, 102000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a50099a2-3a93-537e-a69c-010c0fe99f4b', '69cfc190-78db-4eda-bcb2-3dd821844091', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3ce27653-72f6-5737-a560-859cd2b13dc8', '85da1ae7-7385-4d90-9ab0-4aaacf29f2e8', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'cash', 'confirmed', 'total', 29000, 29000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '3d5e6dbc-b13f-5405-ad55-f222761d3e06', '46503d83-e948-46eb-a5d6-7cc57b192414', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'nequi', 'confirmed', 'total', 70000, 70000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '7e4aaa85-0b53-5974-99df-c7619d84fc7f', 'b8d45027-1623-4281-8a4c-5e1303f67563', 'ac8bcbaf-23dd-4673-8200-7fe06338843f', 'bank_transfer', 'confirmed', 'total', 71000, 71000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd1cc0fbc-7298-59f6-af73-fae88445a8fa', 'b4f8f126-4265-416e-8628-e965db52d100', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 6000, 6000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'dc502895-dd1d-523b-b356-f9329de5302f', 'd38f98b4-16e3-40f2-81d7-d97f1dbd4da9', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 42000, 42000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '569a0e47-8b9a-5d24-85a5-94987e01c362', '0645f808-4bf6-42d4-b059-82e729773888', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ae1dbc1e-e1ea-5f1f-8631-2c2765d96e2d', '522f035f-d137-4845-8013-1640b4e97758', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'e9959968-3595-5d72-97ba-02f7b21b9b53', '887cec88-8897-4cb6-8a6c-4aae3eb92de3', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'nequi', 'confirmed', 'total', 25000, 25000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '288c519f-8a73-58d9-b091-76427430fbcc', '6dd9f8fc-c8ec-4ab3-a8b9-2ae0ec17b57c', 'cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9', 'cash', 'confirmed', 'total', 82000, 82000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'bad4f480-e279-522f-bdfe-876cabd21f8e', 'f1c42de6-4389-43fc-9613-23a252d3b063', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'cash', 'confirmed', 'total', 8000, 8000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'd88d9d3d-7b4e-5f6d-bfc9-cfaee40d21ee', '3e614951-a4c6-419e-a389-66520337da5a', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 47000, 47000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '268e04ed-ee53-540d-85de-d089472f1dcf', '3e614951-a4c6-419e-a389-66520337da5a', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'ffa489e5-c494-59b0-ab86-a48f53261dc5', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'cash', 'confirmed', 'total', 5000, 5000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '5eaf7462-8693-53d0-bb8c-0aa7ce4f3d47', '7922b6cd-c2ea-4df9-85e5-586783afcc8d', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 9000, 9000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '956e969f-2183-58ff-9f5f-f6b8d96917da', '04259209-f015-47b9-b1df-9aa324dc4d8f', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'nequi', 'confirmed', 'total', 35000, 35000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '658cb66d-f17b-5f83-9771-e2b90bfa9780', '825d025e-65de-4a28-a56d-474796cd8a31', 'e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955', 'bank_transfer', 'confirmed', 'total', 26000, 26000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select '68fa092f-03b0-5202-8a6f-7c9a6ae5556e', '0b98d323-e92f-452b-97ae-82215314a9fb', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'nequi', 'confirmed', 'total', 132000, 132000, 0, '[]'::jsonb, '7992', null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email)
select 'a18a7808-81fd-543c-b5f3-8440e8a93738', '83811ff2-6a42-4042-83cf-fbb14b1a05a4', 'e87312ae-bb93-4dcc-a3a6-9b18ed8d457f', 'cash', 'confirmed', 'total', 10000, 10000, 0, '[]'::jsonb, null, null, 'recovery@zafiro.local', timezone('utc', now()), 'recovery@zafiro.local'
on conflict (id) do nothing;

-- 2026-05-23: the detail CSV has 29 products / 340000, but the official app summary says 31 products / 383000. Add a transparent balancing item and replace payments with the official summary totals.

insert into public.pos_order_items (id, order_id, menu_item_source_key, product_name, product_slug, prep_area, quantity, unit_price, total_price, service_round, operational_status, financial_status, notes, created_by_email, updated_by_email, sent_at, delivered_at, delivered_by_email) values ('b0adcef0-0523-4000-8000-000000000001'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, null, 'Ajuste recuperacion Jornada 2026-05-23', 'ajuste-recuperacion-jornada-2026-05-23', 'bar', 2, 21500, 43000, 1, 'delivered', 'paid_total', 'Ajuste para cuadrar resumen oficial exportado: 31 productos y $383000.', 'recovery@zafiro.local', 'recovery@zafiro.local', '2026-05-24T07:11:00+00'::timestamptz, '2026-05-24T07:11:00+00'::timestamptz, 'recovery@zafiro.local') on conflict (id) do nothing;

insert into public.pos_deleted_records_archive (source_table, source_id, row_data) select 'pos_payments_2026_05_23_detail_replaced_by_summary', p.id, to_jsonb(p) from public.pos_payments p where p.sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid;

delete from public.pos_payments where sales_session_id = '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email) values ('b0adcef0-0523-4000-9000-000000000001'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'cash', 'confirmed', 'amount', 136000, 136000, 0, '[]'::jsonb, 'recovery-summary-2026-05-23-cash', 'Pago resumen oficial recuperado 2026-05-23 efectivo.', 'recovery@zafiro.local', '2026-05-24T07:11:00+00'::timestamptz, 'recovery@zafiro.local') on conflict (id) do nothing;

insert into public.pos_payments (id, order_id, sales_session_id, method, status, allocation_mode, amount_applied, amount_received, change_due, target_item_ids, reference, notes, created_by_email, confirmed_at, confirmed_by_email) values ('b0adcef0-0523-4000-9000-000000000002'::uuid, '173aadce-cba6-453d-92da-5fe26a21e69d'::uuid, '855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, 'bank_transfer', 'confirmed', 'amount', 247000, 247000, 0, '[]'::jsonb, 'recovery-summary-2026-05-23-transfer', 'Pago resumen oficial recuperado 2026-05-23 transferencias.', 'recovery@zafiro.local', '2026-05-24T07:11:00+00'::timestamptz, 'recovery@zafiro.local') on conflict (id) do nothing;

create temp table recovery_expected_sessions (id uuid primary key, business_date date, total_collected numeric, order_count integer, delivered_products integer, average_ticket numeric) on commit drop;

insert into recovery_expected_sessions values
('929b3f56-e936-4e8c-8183-962bd63115d4'::uuid, '2026-05-22'::date, 347000, 5, 18, 69400),
('855c30a3-85d2-40c2-a309-a6d2b3762ff2'::uuid, '2026-05-23'::date, 383000, 8, 31, 47875),
('e87312ae-bb93-4dcc-a3a6-9b18ed8d457f'::uuid, '2026-05-24'::date, 142000, 2, 9, 71000),
('8ece710e-b2a4-4985-a9ea-9e6b288704ac'::uuid, '2026-05-26'::date, 98000, 7, 12, 14000),
('48866b4b-c259-4cb0-916a-16e888a57408'::uuid, '2026-05-27'::date, 0, 0, 0, 0),
('a514e729-b6e1-437c-b0ce-ae6d8d81be15'::uuid, '2026-05-28'::date, 51000, 1, 4, 51000),
('cf94d55e-6467-4f1d-b69f-d4a4ef5c3ea9'::uuid, '2026-05-29'::date, 165000, 6, 13, 27500),
('0fc2cad5-1577-4f77-83b2-b5690998e06f'::uuid, '2026-05-30'::date, 276000, 6, 18, 46000),
('ac8bcbaf-23dd-4673-8200-7fe06338843f'::uuid, '2026-05-31'::date, 358000, 7, 24, 51143),
('e34f1cb3-ff58-4ed8-a0b7-ce4476f3a955'::uuid, '2026-06-01'::date, 135000, 5, 12, 27000),
('2e4d61ae-d48a-429a-9d56-d7538abab917'::uuid, '2026-06-03'::date, 440000, 8, 34, 55000),
('8481d2b5-b80f-40a7-9190-4aea56c9cdb2'::uuid, '2026-06-04'::date, 270000, 5, 20, 54000),
('3c2b9df9-1250-4800-ad1c-610b8d5eb4a3'::uuid, '2026-06-05'::date, 5000, 1, 1, 5000),
('36e3abba-1022-4b02-b199-4e6cc6d76fb6'::uuid, '2026-06-06'::date, 804000, 7, 51, 114857);

update public.pos_sales_sessions s set summary = jsonb_set(jsonb_set(jsonb_set(jsonb_set(coalesce(s.summary, '{}'::jsonb), '{totalCollected}', to_jsonb(e.total_collected)), '{grossSales}', to_jsonb(e.total_collected)), '{deliveredProducts}', to_jsonb(e.delivered_products)), '{orderCount}', to_jsonb(e.order_count)) || jsonb_build_object('recoveryExpected', jsonb_build_object('averageTicket', e.average_ticket, 'source', 'user_expected_csv_control')), business_date = e.business_date from recovery_expected_sessions e where s.id = e.id;

commit;


-- Validation report: expected vs rebuilt database.
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
  select
    o.sales_session_id,
    coalesce(sum(i.total_price) filter (where i.operational_status <> 'cancelled' and i.financial_status <> 'cancelled'), 0) as actual_venta_productos,
    coalesce(sum(i.quantity) filter (where i.operational_status <> 'cancelled' and i.financial_status <> 'cancelled'), 0) as actual_productos
  from public.pos_orders o
  left join public.pos_order_items i on i.order_id = o.id
  group by o.sales_session_id
), payment_totals as (
  select
    sales_session_id,
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
     and e.venta_total = coalesce(p.actual_cobrado, 0)
     and e.venta_total = coalesce(i.actual_venta_productos, 0)
     and e.mesas_ordenes = coalesce((s.summary ->> 'orderCount')::integer, 0)
     and e.productos_vendidos = coalesce(i.actual_productos, 0)
    then 'OK'
    else 'REVISAR'
  end as estado
from expected e
left join public.pos_sales_sessions s on s.id = e.session_id
left join item_totals i on i.sales_session_id = e.session_id
left join payment_totals p on p.sales_session_id = e.session_id
order by e.business_date;
