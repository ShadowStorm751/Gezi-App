-- 'Gezi Arkadaşı' ve 'Gezi Ekibi' rozet görselleri (assets/badges/, Storage 'badges' bucket).
update public.achievements set badge_path = slug || '.webp'
where slug in ('first-friend', 'travel-crew') and badge_path is null;
