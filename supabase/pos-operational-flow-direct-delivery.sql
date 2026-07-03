alter table public.pos_operational_flow_settings
  add column if not exists use_direct_delivery boolean not null default false;

insert into public.pos_operational_flow_settings (area, use_direct_delivery, use_in_process, use_picking_up)
values
  ('bar', false, false, false),
  ('kitchen', false, false, false)
on conflict (area) do nothing;
