# Ortak görseller

## `badges/` — rozet görselleri

21 rozet, `<rozet slug'ı>.webp`, 512×512, şeffaf arka plan. Gemini ile üretildi (2026-11-19), Claude tarafından kırpılıp şeffaflaştırıldı.

- Veritabanında `achievements.badge_path` = `<slug>.webp` (migration `20261119150000_badge_paths.sql`). Aynı dosyalar Supabase Storage'daki `badges` bucket'ına yüklenir.
- Mobil uygulama bu dosyaları paketine de koyabilir (çevrimdışı çalışır, ağ isteği gerekmez). Paketinde olmayan yeni bir rozet gelirse `badge_path` ile Storage'dan çeker, o da yoksa kategoriye göre bir ikon gösterir.
- **Kazanılmamış rozet** için ayrı görsel yok: aynı görsel gri tonlamalı ve yarı saydam (%40) gösterilir, altında ilerleme (ör. 3/5).
- Kademeler: `explorer-10` bronz ★, `explorer-25` gümüş ★★, `explorer-50` altın ★★★.
