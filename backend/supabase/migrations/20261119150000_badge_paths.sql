-- Rozet görselleri: 'badges' Storage bucket'ında <slug>.webp (512×512, şeffaf arka plan).
-- Görsellerin kaynağı repodaki assets/badges/ klasörü; Storage'a ayrıca yüklenir
-- (bkz. backend/README.md "Rozet görselleri"). Mobil uygulama aynı dosyaları paketine de koyabilir.
update public.achievements
set badge_path = slug || '.webp'
where badge_path is null
  and slug in (
    'first-step', 'explorer-10', 'explorer-25', 'explorer-50', 'streak-4-weeks', 'istanbul-complete',
    'mosque-wanderer', 'palace-life', 'museum-lover', 'wall-keeper', 'byzantine-traveler',
    'ottoman-heritage', 'history-buff-10', 'istanbul-history-complete', 'sultans-rest',
    'first-view', 'view-hunter', 'nature-explorer', 'forest-walker', 'islands-tour', 'sunset-collector'
  );
