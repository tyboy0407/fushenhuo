-- 富紳活 尺寸簿：共用資料表
-- 用法：Supabase 專案 → 左側 SQL Editor → 整份貼上 → Run（可重複執行）
--
-- 一列存一個房間、一個視角、一個物件或一件家具。
-- path 是它在資料裡的位置，例如 rooms/study/views/door/items/c

create table if not exists public.fushenhuo_docs (
  path        text primary key check (char_length(path) between 1 and 200),
  data        jsonb not null check (pg_column_size(data) <= 16384),
  updated_at  timestamptz not null default now()
);

-- Row Level Security：任何拿到網站的人都能讀寫「這一張表」，其他表不受影響
alter table public.fushenhuo_docs enable row level security;

drop policy if exists "fushenhuo public read" on public.fushenhuo_docs;
create policy "fushenhuo public read"
  on public.fushenhuo_docs for select
  to anon, authenticated
  using (true);

drop policy if exists "fushenhuo public insert" on public.fushenhuo_docs;
create policy "fushenhuo public insert"
  on public.fushenhuo_docs for insert
  to anon, authenticated
  with check (true);

drop policy if exists "fushenhuo public update" on public.fushenhuo_docs;
create policy "fushenhuo public update"
  on public.fushenhuo_docs for update
  to anon, authenticated
  using (true)
  with check (true);

drop policy if exists "fushenhuo public delete" on public.fushenhuo_docs;
create policy "fushenhuo public delete"
  on public.fushenhuo_docs for delete
  to anon, authenticated
  using (true);

grant select, insert, update, delete on public.fushenhuo_docs to anon, authenticated;

-- 即時同步：別人一改，其他人的畫面馬上更新
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'fushenhuo_docs'
  ) then
    alter publication supabase_realtime add table public.fushenhuo_docs;
  end if;
end $$;
