create extension if not exists pgcrypto;
create table if not exists public.products(id uuid primary key default gen_random_uuid(),name text not null,description text default '',price bigint not null check(price>0),category text default 'Digital',active boolean not null default true,created_at timestamptz not null default now());
create table if not exists public.orders(id uuid primary key default gen_random_uuid(),product_id uuid references public.products(id),product_name text not null,amount bigint not null,buyer_name text not null,buyer_wa text not null,buyer_email text,paid_amount bigint not null,proof_url text not null,status text not null default 'pending',created_at timestamptz not null default now());
alter table public.products enable row level security;alter table public.orders enable row level security;
create policy "public read active products" on public.products for select using(active=true);
create policy "admin manage products" on public.products for all to authenticated using(true) with check(true);
create policy "public submit order" on public.orders for insert to anon with check(status='pending');
create policy "admin read orders" on public.orders for select to authenticated using(true);
create policy "admin update orders" on public.orders for update to authenticated using(true) with check(true);
-- Storage buckets: create public buckets payment-proofs and store-assets in Supabase Storage.
-- payment-proofs: allow anon INSERT; allow authenticated SELECT. Keep bucket size/type limits enabled.
