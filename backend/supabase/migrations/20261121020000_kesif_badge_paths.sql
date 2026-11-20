-- İzmir, Bursa ve Kapadokya keşif rozetlerinin görselleri: 'badges' Storage bucket'ında <slug>.webp
-- (512×512, şeffaf). Kaynak: assets/badges/. Storage'a yükleme ayrıca yapılır (backend/README.md "Rozet görselleri");
-- badge-upload Edge Function'ının izin listesine bu 15 dosya eklendi, fonksiyonun yeniden deploy edilmesi gerekir.
update public.achievements
set badge_path = slug || '.webp'
where badge_path is null
  and slug in (
    'birgi-kesif',
    'bursa-kapalicarsi-kesif',
    'bursa-muradiye-camii-kesif',
    'cavusin-kesif',
    'efes-kesif',
    'gediz-deltasi-kesif',
    'golyazi-adasi-kesif',
    'goreme-deki-kiliseler-listesi-kesif',
    'ihlara-vadisi-kesif',
    'kemeralti-carsisi-kesif',
    'kulturpark-kesif',
    'merinos-parki-kesif',
    'pergamon-kesif',
    'soganli-vadisi-kesif',
    'tirilye-kesif'
  );
