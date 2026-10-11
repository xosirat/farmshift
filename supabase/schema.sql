-- FarmShift account data schema (Supabase SQL Editor)
-- Run after creating a Supabase project. Every row is private to its owner.
create table if not exists public.farmshift_user_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  constraint farmshift_payload_object check (jsonb_typeof(payload) = 'object')
);

alter table public.farmshift_user_data enable row level security;

revoke all on table public.farmshift_user_data from anon;
grant select, insert, update, delete on table public.farmshift_user_data to authenticated;

drop policy if exists "Users can read their own FarmShift data" on public.farmshift_user_data;
create policy "Users can read their own FarmShift data"
  on public.farmshift_user_data for select
  to authenticated using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert their own FarmShift data" on public.farmshift_user_data;
create policy "Users can insert their own FarmShift data"
  on public.farmshift_user_data for insert
  to authenticated with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own FarmShift data" on public.farmshift_user_data;
create policy "Users can update their own FarmShift data"
  on public.farmshift_user_data for update
  to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own FarmShift data" on public.farmshift_user_data;
create policy "Users can delete their own FarmShift data"
  on public.farmshift_user_data for delete
  to authenticated using ((select auth.uid()) = user_id);

-- Keep updated_at current even if a future client forgets to set it.
create or replace function public.farmshift_touch_updated_at()
returns trigger language plpgsql set search_path = ''
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists farmshift_user_data_updated_at on public.farmshift_user_data;
create trigger farmshift_user_data_updated_at
before update on public.farmshift_user_data
for each row execute function public.farmshift_touch_updated_at();
