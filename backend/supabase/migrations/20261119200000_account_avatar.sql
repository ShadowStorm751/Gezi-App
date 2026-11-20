-- Hesap ve avatar
-- 1) avatars bucket: en fazla 2 MB, yalnızca JPEG/PNG/WebP.
-- 2) Kullanıcı yalnızca kendi klasörüne (avatars/<user_id>/...) yükleyebilir, değiştirebilir, silebilir.
--    Bucket herkese açık olduğu için okuma public URL ile yapılır.
-- 3) update_profile: avatar_path kullanıcının kendi klasöründe olmalı.
-- Hesap silme: delete-account Edge Function'ı (functions/delete-account).

update storage.buckets
set file_size_limit = 2097152,
    allowed_mime_types = array['image/jpeg', 'image/png', 'image/webp']
where id = 'avatars';

create policy "avatars: read own folder" on storage.objects
  for select to authenticated
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "avatars: upload to own folder" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "avatars: update own folder" on storage.objects
  for update to authenticated
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "avatars: delete own folder" on storage.objects
  for delete to authenticated
  using (bucket_id = 'avatars' and (storage.foldername(name))[1] = auth.uid()::text);

-- update_profile: aynı imza ve dönüş; avatar_path doğrulaması eklendi.
create or replace function public.update_profile(
  username text default null,
  avatar_path text default null,
  is_public boolean default null,
  preferred_lang text default null
)
returns jsonb
language plpgsql volatile
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  result jsonb;
begin
  if uid is null then
    raise exception 'not_authenticated' using errcode = '28000';
  end if;
  if update_profile.avatar_path is not null
     and update_profile.avatar_path not like uid::text || '/%' then
    raise exception 'avatar_path must be inside the user''s own folder (<user_id>/...)'
      using errcode = '22023';
  end if;

  update public.profiles pr set
    username       = coalesce(update_profile.username, pr.username),
    avatar_path    = coalesce(update_profile.avatar_path, pr.avatar_path),
    is_public      = coalesce(update_profile.is_public, pr.is_public),
    preferred_lang = coalesce(update_profile.preferred_lang, pr.preferred_lang)
  where pr.id = uid
  returning jsonb_build_object(
    'id', pr.id,
    'username', pr.username,
    'avatar_path', pr.avatar_path,
    'is_public', pr.is_public,
    'preferred_lang', pr.preferred_lang)
  into result;

  return result;
end;
$$;
