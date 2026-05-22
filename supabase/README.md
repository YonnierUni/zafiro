# Supabase Catalog Migration

This folder contains the first Supabase-backed persistence layer for the ZAFIRO catalog.

## Files

- `schema.sql`
  Creates `admin_users`, `menu_items`, `menu_change_logs`, `menu_snapshots`, `menu_items_public` and the final Auth + RLS model.
- `auth-rls.sql`
  Upgrade script for projects that already ran the transitional schema and now need protected admin access.
- `seed-menu-items.sql`
  Generated from the current `public/data/menu.json` catalog and ready for the initial load.

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

Example:

```sql
insert into public.admin_users (email)
values ('admin@zafiro.com')
on conflict (email) do nothing;
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

The frontend admin now expects email/password login through Supabase Auth.
