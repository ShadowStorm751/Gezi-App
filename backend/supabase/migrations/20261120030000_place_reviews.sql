-- Yer değerlendirmeleri: gezilen yere 1-5 yıldız ve isteğe bağlı kısa not.
-- Kurallar:
--   * Yalnızca check-in yapılmış (işaretsiz ziyaret) yer değerlendirilebilir; kişi başı yer başına tek
--     değerlendirme, istenince güncellenir ya da silinir.
--   * Puan hemen ortalamaya katılır. Not, yönetici onaylayana kadar yalnızca yazana görünür.
--   * Ortalama en az 3 değerlendirme olunca döner (az sayıda puan yanıltmasın); sayı her zaman döner.
-- Hesap silinince değerlendirmeler de silinir; export_my_data değerlendirmeleri içerir.

create type public.review_comment_status as enum ('none', 'pending', 'approved', 'rejected');

create table public.place_reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  place_id uuid not null references public.places(id) on delete cascade,
  rating smallint not null check (rating between 1 and 5),
  comment text check (char_length(comment) between 1 and 300),
  comment_status public.review_comment_status not null default 'none',
  lang text not null default 'tr' check (lang in ('tr', 'en')),
  admin_note text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, place_id),
  check ((comment is null) = (comment_status = 'none'))
);
create index place_reviews_place_idx on public.place_reviews (place_id, updated_at desc);
create index place_reviews_pending_idx on public.place_reviews (comment_status, updated_at)
  where comment_status = 'pending';

alter table public.place_reviews enable row level security;
create policy "read own or admin" on public.place_reviews
  for select to authenticated
  using (user_id = (select auth.uid()) or (select public.is_admin()));
revoke all on public.place_reviews from anon;
revoke insert, update, delete, truncate, references, trigger on public.place_reviews from authenticated;
grant select on public.place_reviews to authenticated;

-- Yer puanı özeti (herkese açık, kimlik içermez)
create or replace function public.place_rating(p_place uuid)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'count', count(*),
    'average', case when count(*) >= 3 then round(avg(r.rating)::numeric, 1) end)
  from public.place_reviews r
  where r.place_id = p_place;
$$;

-- Değerlendir (ekle ya da güncelle) -------------------------------------------------
create or replace function public.review_place(
  place_id uuid,
  rating integer,
  comment text default null,
  lang text default 'tr'
)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  c text := nullif(trim(coalesce(review_place.comment, '')), '');
  old public.place_reviews;
  new_status public.review_comment_status;
begin
  if uid is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  if review_place.rating is null or review_place.rating not between 1 and 5
     or char_length(coalesce(c, '')) > 300 then
    return jsonb_build_object('ok', false, 'error', 'invalid_input');
  end if;
  if not exists (select 1 from public.places p where p.id = review_place.place_id and p.is_published) then
    return jsonb_build_object('ok', false, 'error', 'place_not_found');
  end if;
  if not exists (select 1 from public.visits v
                 where v.user_id = uid and v.place_id = review_place.place_id and not v.flagged) then
    return jsonb_build_object('ok', false, 'error', 'not_visited');
  end if;

  select * into old from public.place_reviews r where r.user_id = uid and r.place_id = review_place.place_id;
  if not found and (select count(*) from public.place_reviews r
                    where r.user_id = uid and r.created_at > now() - interval '1 day') >= 30 then
    return jsonb_build_object('ok', false, 'error', 'rate_limited');
  end if;

  new_status := case
    when c is null then 'none'
    when old.id is not null and old.comment is not distinct from c then old.comment_status
    else 'pending' end;

  insert into public.place_reviews (user_id, place_id, rating, comment, comment_status, lang)
  values (uid, review_place.place_id, review_place.rating, c, new_status, public.norm_lang(review_place.lang))
  on conflict on constraint place_reviews_user_id_place_id_key do update
    set rating = excluded.rating,
        comment = excluded.comment,
        comment_status = excluded.comment_status,
        lang = excluded.lang,
        admin_note = case when excluded.comment_status = 'pending' then null else place_reviews.admin_note end,
        updated_at = now();

  return jsonb_build_object('ok', true, 'comment_status', new_status,
                            'rating', public.place_rating(review_place.place_id));
end;
$$;

create or replace function public.delete_my_review(place_id uuid)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  n int;
begin
  if auth.uid() is null then
    return jsonb_build_object('ok', false, 'error', 'not_authenticated');
  end if;
  delete from public.place_reviews r where r.user_id = auth.uid() and r.place_id = delete_my_review.place_id;
  get diagnostics n = row_count;
  if n = 0 then
    return jsonb_build_object('ok', false, 'error', 'review_not_found');
  end if;
  return jsonb_build_object('ok', true);
end;
$$;

-- Bir yerin değerlendirmeleri (herkese açık) ----------------------------------------
create or replace function public.reviews_for_place(
  place_id uuid,
  lang text default 'tr',
  max_results integer default 20
)
returns jsonb
language sql
stable
security definer
set search_path = public
as $$
  select jsonb_build_object(
    'ok', true,
    'rating', public.place_rating(reviews_for_place.place_id),
    'distribution', (
      select jsonb_build_object('1', count(*) filter (where r.rating = 1), '2', count(*) filter (where r.rating = 2),
                                '3', count(*) filter (where r.rating = 3), '4', count(*) filter (where r.rating = 4),
                                '5', count(*) filter (where r.rating = 5))
      from public.place_reviews r where r.place_id = reviews_for_place.place_id),
    'my_review', (
      select jsonb_build_object('rating', r.rating, 'comment', r.comment, 'comment_status', r.comment_status,
                                'admin_note', r.admin_note, 'updated_at', r.updated_at)
      from public.place_reviews r
      where auth.uid() is not null and r.user_id = auth.uid() and r.place_id = reviews_for_place.place_id),
    'can_review', auth.uid() is not null and exists (
      select 1 from public.visits v
      where v.user_id = auth.uid() and v.place_id = reviews_for_place.place_id and not v.flagged),
    'reviews', coalesce((
      select jsonb_agg(jsonb_build_object(
               'username', x.username, 'avatar_path', x.avatar_path, 'rating', x.rating,
               'comment', x.comment, 'lang', x.lang, 'updated_at', x.updated_at,
               'is_me', x.user_id = auth.uid()) order by x.same_lang desc, x.updated_at desc)
      from (
        select r.*, pr.username, pr.avatar_path, (r.lang = public.norm_lang(reviews_for_place.lang)) as same_lang
        from public.place_reviews r
        join public.profiles pr on pr.id = r.user_id
        where r.place_id = reviews_for_place.place_id and r.comment_status = 'approved'
        order by (r.lang = public.norm_lang(reviews_for_place.lang)) desc, r.updated_at desc
        limit least(greatest(coalesce(reviews_for_place.max_results, 20), 1), 50)
      ) x), '[]'::jsonb));
$$;

create or replace function public.my_reviews(lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
           'place_id', r.place_id, 'place_slug', p.slug, 'place_name', t.name,
           'rating', r.rating, 'comment', r.comment, 'comment_status', r.comment_status,
           'admin_note', r.admin_note, 'updated_at', r.updated_at) order by r.updated_at desc), '[]'::jsonb)
  from public.place_reviews r
  join public.places p on p.id = r.place_id
  left join public.place_translations t on t.place_id = p.id and t.lang = public.norm_lang(my_reviews.lang)
  where r.user_id = auth.uid();
$$;

-- Yönetici: not onayı --------------------------------------------------------------
create or replace function public.admin_review_comments(
  only_status text default 'pending',
  max_results integer default 100
)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;
  return coalesce((
    select jsonb_agg(jsonb_build_object(
             'id', r.id, 'place', p.slug, 'username', pr.username, 'rating', r.rating,
             'comment', r.comment, 'lang', r.lang, 'comment_status', r.comment_status,
             'updated_at', r.updated_at) order by r.updated_at)
    from (select * from public.place_reviews x
          where x.comment is not null
            and (admin_review_comments.only_status is null
                 or x.comment_status::text = admin_review_comments.only_status)
          order by x.updated_at
          limit least(greatest(coalesce(admin_review_comments.max_results, 100), 1), 500)) r
    join public.places p on p.id = r.place_id
    left join public.profiles pr on pr.id = r.user_id), '[]'::jsonb);
end;
$$;

create or replace function public.admin_resolve_review(
  review_id uuid,
  accept boolean,
  admin_note text default null
)
returns jsonb
language plpgsql
volatile
security definer
set search_path = public
as $$
declare
  n int;
begin
  if not public.can_admin() then
    raise exception 'admin only' using errcode = '42501';
  end if;
  update public.place_reviews r
     set comment_status = case when admin_resolve_review.accept then 'approved' else 'rejected' end::public.review_comment_status,
         admin_note = admin_resolve_review.admin_note
   where r.id = admin_resolve_review.review_id and r.comment_status = 'pending';
  get diagnostics n = row_count;
  if n = 0 then
    return jsonb_build_object('ok', false, 'error', 'review_not_found');
  end if;
  return jsonb_build_object('ok', true, 'comment_status',
                            case when admin_resolve_review.accept then 'approved' else 'rejected' end);
end;
$$;

revoke execute on function public.review_place(uuid, integer, text, text), public.delete_my_review(uuid),
  public.my_reviews(text), public.admin_review_comments(text, integer),
  public.admin_resolve_review(uuid, boolean, text)
  from public, anon;
grant execute on function public.review_place(uuid, integer, text, text), public.delete_my_review(uuid),
  public.my_reviews(text), public.admin_review_comments(text, integer),
  public.admin_resolve_review(uuid, boolean, text)
  to authenticated;
grant execute on function public.reviews_for_place(uuid, text, integer), public.place_rating(uuid)
  to anon, authenticated;

-- place_detail: puan özeti ('rating': { count, average })
create or replace function public.place_detail(place_id uuid, lang text default 'tr')
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'id', p.id,
    'slug', p.slug,
    'kind', p.kind,
    'category', c.slug,
    'category_name', ct.name,
    'city', ci.slug,
    'name', t.name,
    'short_desc', t.short_desc,
    'long_desc', t.long_desc,
    'best_time', t.best_time,
    'period', public.period_label(p.period, place_detail.lang),
    'period_code', p.period,
    'built_year', p.built_year,
    'opening_hours', p.opening_hours,
    'latitude', st_y(p.location::geometry),
    'longitude', st_x(p.location::geometry),
    'checkin_radius_m', p.checkin_radius_m,
    'has_area', p.area is not null,
    'rating', public.place_rating(p.id),
    'photos', coalesce((
      select jsonb_agg(jsonb_build_object(
               'storage_path', ph.storage_path,
               'url', ph.url,
               'thumb_url', ph.thumb_url,
               'width', ph.width,
               'height', ph.height,
               'license', ph.license,
               'license_url', ph.license_url,
               'author', ph.author,
               'source_url', ph.source_url) order by ph.sort_order)
      from public.place_photos ph
      where ph.place_id = p.id), '[]'::jsonb),
    'visited_at', (
      select v.visited_at from public.visits v
      where v.place_id = p.id and v.user_id = auth.uid())
  )
  from public.places p
  join public.cities ci on ci.id = p.city_id
  join public.categories c on c.id = p.category_id
  left join public.category_translations ct
    on ct.category_id = c.id and ct.lang = public.norm_lang(place_detail.lang)
  join public.place_translations t
    on t.place_id = p.id and t.lang = public.norm_lang(place_detail.lang)
  where p.id = place_detail.place_id
    and p.is_published;
$$;

-- KVKK dışa aktarımına değerlendirmeler
create or replace function public.export_my_data()
returns jsonb
language sql
stable
set search_path = public, extensions
as $$
  select jsonb_build_object(
    'exported_at', now(),
    'profile', (select to_jsonb(pr) from public.profiles pr where pr.id = auth.uid()),
    'visits', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', p.slug,
               'place_id', v.place_id,
               'visited_at', v.visited_at,
               'method', v.method,
               'distance_m', v.distance_m,
               'gps_accuracy_m', v.gps_accuracy_m) order by v.visited_at)
      from public.visits v left join public.places p on p.id = v.place_id
      where v.user_id = auth.uid()), '[]'::jsonb),
    'achievements', coalesce((
      select jsonb_agg(jsonb_build_object('achievement', a.slug, 'earned_at', ua.earned_at)
                       order by ua.earned_at)
      from public.user_achievements ua join public.achievements a on a.id = ua.achievement_id
      where ua.user_id = auth.uid()), '[]'::jsonb),
    'submissions', coalesce((
      select jsonb_agg(jsonb_build_object(
               'kind', s.kind,
               'place', s.place_id,
               'name', s.name,
               'category', s.category_slug,
               'lat', st_y(s.location::geometry),
               'lng', st_x(s.location::geometry),
               'note', s.note,
               'status', s.status,
               'admin_note', s.admin_note,
               'created_at', s.created_at,
               'resolved_at', s.resolved_at) order by s.created_at)
      from public.place_submissions s
      where s.user_id = auth.uid()), '[]'::jsonb),
    'friendships', coalesce((
      select jsonb_agg(jsonb_build_object(
               'username', pr.username,
               'direction', case when f.requester_id = auth.uid() then 'sent' else 'received' end,
               'status', f.status,
               'created_at', f.created_at,
               'responded_at', f.responded_at) order by f.created_at)
      from public.friendships f
      left join public.profiles pr
        on pr.id = case when f.requester_id = auth.uid() then f.addressee_id else f.requester_id end
      where f.requester_id = auth.uid() or f.addressee_id = auth.uid()), '[]'::jsonb),
    'photos', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', s.place_id,
               'storage_path', s.storage_path,
               'caption', s.caption,
               'status', s.status,
               'created_at', s.created_at,
               'resolved_at', s.resolved_at) order by s.created_at)
      from public.photo_submissions s
      where s.user_id = auth.uid()), '[]'::jsonb),
    'reviews', coalesce((
      select jsonb_agg(jsonb_build_object(
               'place', r.place_id,
               'rating', r.rating,
               'comment', r.comment,
               'comment_status', r.comment_status,
               'created_at', r.created_at,
               'updated_at', r.updated_at) order by r.created_at)
      from public.place_reviews r
      where r.user_id = auth.uid()), '[]'::jsonb)
  );
$$;
