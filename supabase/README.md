# Supabase Catalog Migration

This folder contains the first Supabase-backed persistence layer for the ZAFIRO catalog.

## Files

- `schema.sql`
  Creates `admin_users`, `menu_items`, `menu_change_logs`, `menu_snapshots`, `menu_items_public` and the final Auth + RLS model.
- `auth-rls.sql`
  Upgrade script for projects that already ran the transitional schema and now need protected admin access.
- `pos-schema.sql`
  Creates the first operational POS layer: staff profiles, staff roles, mesas, ordenes, lineas, pagos, logs and their RLS policies.
- `seed-menu-items.sql`
  Generated from the current `public/data/menu.json` catalog and ready for the initial load.
- `pos-seed.sql`
  Optional starter seed with base mesas and examples for staff profiles / role assignments.

## Recommended setup

1. Create a Supabase project.
2. Run `supabase/schema.sql` in the SQL editor.
3. Run `supabase/seed-menu-items.sql` in the SQL editor.
4. Add the frontend env vars for this Vite project:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
5. Rebuild the frontend.

## Existing projects upgrading from the transitional mode

If your project already had public writes enabled:

1. Run `supabase/auth-rls.sql` in the SQL editor.
2. Create your admin users in Supabase Auth.
3. Insert each allowed operator email into `public.admin_users`.
4. Run `supabase/pos-schema.sql`.
5. Optionally run `supabase/pos-seed.sql`.
6. Create the POS operators in `staff_profiles` and `staff_role_assignments`.

Example:

```sql
insert into public.admin_users (email)
values ('admin@zafiro.com')
on conflict (email) do nothing;
```

Example POS roles:

```sql
insert into public.staff_profiles (email, full_name)
values
  ('mesero@zafiro.com', 'Mesero turno A'),
  ('cocina@zafiro.com', 'Preparacion cocina'),
  ('bar@zafiro.com', 'Preparacion bar'),
  ('caja@zafiro.com', 'Caja principal')
on conflict (email) do update
set full_name = excluded.full_name;

insert into public.staff_role_assignments (email, role)
values
  ('mesero@zafiro.com', 'waiter'),
  ('cocina@zafiro.com', 'kitchen'),
  ('bar@zafiro.com', 'bar'),
  ('caja@zafiro.com', 'cashier')
on conflict (email, role) do nothing;
```

## GitHub Pages / Actions

The GitHub Pages workflow expects these repository secrets:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

They are injected during the `npm run build` step in `.github/workflows/deploy-pages.yml`.

## Current security model

- `menu_items_public`: public read for the website.
- `menu_items`: read/write only for authenticated emails present in `public.admin_users`.
- `menu_change_logs`: read/insert only for authenticated admin operators.
- `menu_snapshots`: read/insert only for authenticated admin operators.
- `staff_profiles`, `staff_role_assignments`, `pos_tables`, `pos_orders`, `pos_order_items`, `pos_payments`, `pos_order_status_logs`:
  read/write only for authenticated POS staff or catalog superadmins through RLS.

The frontend admin now expects email/password login through Supabase Auth.
