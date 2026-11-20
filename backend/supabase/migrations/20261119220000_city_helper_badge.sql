-- 'Şehir Gönüllüsü' (city-helper) rozet görseli: badges/city-helper.webp (assets/badges/city-helper.webp)
update public.achievements
set badge_path = 'city-helper.webp'
where slug = 'city-helper' and badge_path is null;
