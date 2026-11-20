-- 'Rotacı' ve 'Rota Ustası' rozet görselleri (assets/badges/, Storage 'badges' bucket).
update public.achievements set badge_path = slug || '.webp'
where slug in ('route-first', 'route-master') and badge_path is null;
