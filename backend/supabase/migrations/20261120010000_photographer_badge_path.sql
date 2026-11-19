-- 'Gezi Fotoğrafçısı' rozet görseli (assets/badges/, Storage 'badges' bucket).
update public.achievements set badge_path = 'photographer.webp'
where slug = 'photographer' and badge_path is null;
