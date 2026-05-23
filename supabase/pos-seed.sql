insert into public.pos_tables (code, name, type, zone, capacity, status, notes)
values
  ('M-01', 'Mesa 01', 'fixed', 'salon', 4, 'available', ''),
  ('M-02', 'Mesa 02', 'fixed', 'salon', 4, 'available', ''),
  ('M-03', 'Mesa 03', 'fixed', 'salon', 4, 'available', ''),
  ('T-01', 'Terraza 01', 'fixed', 'terrace', 2, 'available', ''),
  ('B-01', 'Barra 01', 'fixed', 'bar', 2, 'available', ''),
  ('VIP-01', 'VIP 01', 'fixed', 'vip', 6, 'reserved', 'Mesa reservable para eventos')
on conflict (code) do update
set
  name = excluded.name,
  type = excluded.type,
  zone = excluded.zone,
  capacity = excluded.capacity,
  status = excluded.status,
  notes = excluded.notes,
  updated_at = timezone('utc', now());

-- Example staff setup. Replace emails with your real operators.
-- insert into public.staff_profiles (email, full_name)
-- values
--   ('mesero@zafiro.com', 'Mesero turno A'),
--   ('cocina@zafiro.com', 'Preparacion cocina'),
--   ('bar@zafiro.com', 'Preparacion bar'),
--   ('caja@zafiro.com', 'Caja principal')
-- on conflict (email) do update
-- set full_name = excluded.full_name;
--
-- insert into public.staff_role_assignments (email, role)
-- values
--   ('mesero@zafiro.com', 'waiter'),
--   ('cocina@zafiro.com', 'kitchen'),
--   ('bar@zafiro.com', 'bar'),
--   ('caja@zafiro.com', 'cashier')
-- on conflict (email, role) do nothing;
