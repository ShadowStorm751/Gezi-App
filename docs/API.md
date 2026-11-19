# API Sözleşmesi (Backend ↔ Mobil)

Bu dosya backend (Claude) ile mobil uygulama (ChatGPT) arasındaki **tek sözleşmedir**.
Backend bir fonksiyonun adını, parametresini ya da dönüş şeklini değiştirirse bu dosyayı **aynı commit'te** günceller.
Mobil tarafın yeni bir ihtiyacı varsa `docs/REQUESTS.md` dosyasına yazar.

- İstemci: [`@supabase/supabase-js`](https://supabase.com/docs/reference/javascript) v2
- Tüm okuma işlemleri **RPC** (`supabase.rpc(...)`), tek yazma işlemi olan check-in **Edge Function** (`supabase.functions.invoke("checkin")`).
- Mobil uygulama tablolara doğrudan **yazmaz**. Tablolardan doğrudan okumak da önerilmez; aşağıdaki fonksiyonları kullan.
- Her fonksiyon `lang` alır: `"tr"` veya `"en"`. Başka bir değer `"tr"` sayılır. Cihaz dilinden seç.
- Koordinatlar WGS84 derece (`latitude`, `longitude`). Mesafeler **metre**. Açılar **derece**.
- Kimlik: Supabase Auth (e-posta, Apple, Google). Giriş yapılmadan da okuma fonksiyonları çalışır; `visited` alanları `false` gelir.

## Kurulum

```ts
import { createClient } from "@supabase/supabase-js";
import AsyncStorage from "@react-native-async-storage/async-storage";

export const supabase = createClient(
  process.env.EXPO_PUBLIC_SUPABASE_URL!,
  process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!,
  { auth: { storage: AsyncStorage, autoRefreshToken: true, persistSession: true, detectSessionInUrl: false } },
);
```

Yalnızca **anon key** uygulamaya girer. `service_role` key asla mobil koda konmaz.

## Ortak tipler

```ts
export type Lang = "tr" | "en";
export type PlaceKind = "historical" | "nature";

// Kategori slug'ları (seed.sql + migration'lar). "tomb" 2026-11-19'da eklendi. Ekranda göstermek için place_detail.category_name kullan.
export type CategorySlug =
  | "mosque" | "church" | "synagogue" | "palace" | "museum" | "fortress" | "tower"
  | "cistern" | "monument" | "archaeological_site" | "tomb"              // historical
  | "viewpoint" | "hill" | "forest" | "park" | "beach" | "island" | "waterfall"; // nature
```

---

## Okuma fonksiyonları

### `list_cities` — şehir listesi (şehir seçici)

```ts
const { data } = await supabase.rpc("list_cities", { lang: "tr" });
// -> [{ slug, name, timezone, place_count, historical_count, nature_count,
//       center: { lat, lng }, bbox: { min_lat, min_lng, max_lat, max_lng },
//       visited_count }]   // visited_count: girişsizse null
```

- Yalnızca yayında yeri olan şehirler döner, en çok yeri olan önce. Şimdilik yalnızca `istanbul`.
- `center`/`bbox` haritayı şehre odaklamak için. Seçilen şehrin paketi `city_pack(slug)` ile iner.
- Tek şehir varken şehir seçici gizlenebilir; liste 2+ olunca gösterilir.

### `list_routes` ve `route_detail` — hazır rotalar

```ts
const { data: routes } = await supabase.rpc("list_routes", { city_slug: "istanbul", lang: "tr" });
// -> [{ slug, city, title, summary, kind, travel_mode, est_minutes, distance_m, stop_count,
//       thumb_url, visited_count, completed }]

const { data: route } = await supabase.rpc("route_detail", { route_slug: "adalar", lang: "en" });
// -> { ...yukarıdaki alanlar, stops: [{ position, place_id, slug, name, kind, category,
//       latitude, longitude, thumb_url, leg_m, visited }] }   // bulunamazsa null
```

- `kind`: `historical` | `nature` | `mixed`. `travel_mode`: `walking` | `mixed` (yürüyüş + toplu taşıma) | `ferry` | `driving`.
- `est_minutes`: gezme dahil yaklaşık toplam süre. `distance_m` ve `leg_m` duraklar arası **kuş uçuşu** mesafe (yol değil); ilk durakta `leg_m = 0`. Ekranda "~3 km" gibi yuvarlak gösterin.
- `visited_count`, `completed`, `stops[].visited`: girişsizse `null`.
- Rota için ayrı check-in yok: duraklar normal `checkin` ile gezilir. Bütün duraklar gezilince rota tamamlanır; `checkin` yanıtındaki `new_achievements` içinde `route-first` ("Rotacı", ilk rota) ve `route-master` ("Rota Ustası", 5 rota) gelebilir.
- Haritada rotayı çizmek için durakları sırayla düz çizgiyle bağlamak yeterli; gerçek yol tarifi için harita uygulamasına yönlendirin.
- Şimdilik İstanbul'da 11 rota var.

### `nearby_places` — harita, liste ve geo-AR

Yakından uzağa sıralı. Geo-AR için `bearing_deg` hazır gelir: kullanıcıdan yere pusula açısı (0 = kuzey, 90 = doğu, saat yönünde). Telefonun pusula yönüyle karşılaştırıp etiketi ekranda konumlandır.

```ts
const { data, error } = await supabase.rpc("nearby_places", {
  lat: 41.0086, lng: 28.9802,
  radius_m: 1000,          // varsayılan 1000, en fazla 20000
  kinds: null,             // ["nature"] ya da ["historical"]; null = hepsi
  lang: "tr",
  max_results: 100,        // varsayılan 100, en fazla 500
});

type NearbyPlace = {
  id: string; slug: string; name: string; short_desc: string | null;
  kind: PlaceKind; category: CategorySlug;
  latitude: number; longitude: number;
  distance_m: number;
  bearing_deg: number | null;   // kullanıcı tam yerin üstündeyse null
  visited: boolean;
};
```

### `places_in_bbox` — harita kaydırılırken ekrandaki pinler

```ts
await supabase.rpc("places_in_bbox", {
  min_lat: 41.00, min_lng: 28.96, max_lat: 41.02, max_lng: 28.99,
  kinds: null, lang: "tr", max_results: 500,
});
// -> Array<{ id, slug, name, kind, category, latitude, longitude, visited }>
```

### `place_detail` — detay sayfası

Yer yoksa ya da yayında değilse `null` döner.

```ts
await supabase.rpc("place_detail", { place_id: "<uuid>", lang: "en" });

type PlaceDetail = {
  id: string; slug: string; kind: PlaceKind; category: CategorySlug;
  category_name: string;            // "Grove & Forest"
  city: string;                     // "istanbul"
  name: string; short_desc: string | null; long_desc: string | null;
  best_time: string | null;         // doğa yerleri: "Sunset", "April (tulip season)"
  period: string | null;            // tarihi yerler: "Bizans", "Osmanlı", "Ceneviz"
  built_year: number | null;
  opening_hours: unknown | null;    // biçimi henüz sabit değil; MVP'de gösterme
  latitude: number; longitude: number;
  checkin_radius_m: number;
  has_area: boolean;                // true: orman/ada gibi alan; içindeyken check-in yapılabilir
  photos: Array<{
    url: string | null;           // tam boy (≤1280 px), dış adres (Wikimedia)
    thumb_url: string | null;     // küçük resim (500 px)
    storage_path: string | null;  // kendi Storage'ımızdaki fotoğraflar için (şimdilik yok)
    width: number | null; height: number | null;
    author: string;               // fotoğrafın altında gösterilmeli
    license: string;              // ör. "CC BY-SA 4.0", "CC0", "FAL"; author ile birlikte gösterilmeli
    license_url: string | null;   // lisans metni bağlantısı
    source_url: string | null;    // Commons sayfası
  }>;
  visited_at: string | null;        // ISO tarih; giriş yapılmamışsa ya da gezilmemişse null
};
```

Fotoğraf adresi: `photo.url` (dolu ise doğrudan kullan). `url` boş ve `storage_path` dolu ise:
`supabase.storage.from("place-photos").getPublicUrl(photo.storage_path).data.publicUrl`.

**Lisans koşulu (zorunlu):** Fotoğrafın altında ya da üstüne dokununca açılan bir satırda `author` ve `license` görünmeli, örn. "Foto: A.Savin · FAL". `license_url` doluysa lisans adına, `source_url` doluysa yazar adına bağlantı verilmeli. CC BY-SA ve FAL fotoğraflarda bu atıf yapılmazsa fotoğraf kullanılamaz.

156 yerin 133'ünde fotoğraf var; olmayanlarda kategoriye göre bir yer tutucu göster.

### `search_places` — arama

TR ve EN adların ikisinde de arar, sonucu istenen dilde döner. En az 2 karakter. Türkçe harfe duyarsız ("kiz kulesi" → Kız Kulesi), büyük/küçük harf fark etmez.

Sıralama: tam eşleşme → adın başında → bir kelimenin başında → adın içinde; eşitlikte daha tanınmış yer önce (ör. "galata" → Galata Kulesi ilk). Mobil sonucu yeniden sıralamasın.

```ts
await supabase.rpc("search_places", { q: "kule", lang: "tr", max_results: 20 });
// -> Array<{ id, slug, name, short_desc, kind, category, latitude, longitude }>
```

### `city_pack` — çevrimdışı şehir paketi

Şehrin tüm yerleri tek JSON (~15 yerde birkaç KB, 150 yerde ~50-100 KB). Açılışta indir ve sakla; harita ve geo-AR bu yerel veriyle çalışsın, her saniye sunucuya gitme.

```ts
await supabase.rpc("city_pack", { city_slug: "istanbul", lang: "tr" });
// Şehir yoksa null.

type CityPack = {
  city: string; name: string;
  version: string;   // opak sürüm (32 karakter); yalnızca eşitlikle karşılaştır
  places: Array<{ id: string; slug: string; name: string; short_desc: string | null;
                  kind: PlaceKind; category: CategorySlug;
                  latitude: number; longitude: number; checkin_radius_m: number;
                  has_area: boolean;              // true: ada/orman gibi alan; check-in için sınırın içinde olmak yeterli
                  thumb_url: string | null }>;   // ilk fotoğrafın küçük resmi (liste/harita kartı)
};
```

`thumb_url` gösterilen her yerde atıf da gerekir: kartta küçük bir "Foto: Wikimedia Commons" yazısı yeterli, tam yazar ve lisans detay sayfasında (`place_detail.photos`) görünür.

### `city_pack_version` — paketi indirmeden sürüm kontrolü

Yalnızca sürümü döner (birkaç bayt). Kayıtlı paketin `version` değeriyle aynıysa `city_pack`'i indirme.

```ts
const { data: version } = await supabase.rpc("city_pack_version", { city_slug: "istanbul", lang: "tr" });
// -> string, şehir yoksa null
if (version !== cached?.version) {
  const { data: pack } = await supabase.rpc("city_pack", { city_slug: "istanbul", lang: "tr" });
}
```

**Sürüm kuralları:**
- Sürüm, o dildeki paket içeriğinin özetidir. Paketteki herhangi bir alan (ad, kısa açıklama, kategori, konum, yarıçap), şehir adı ya da yayındaki yer listesi değişirse sürüm de değişir. Bir yerin yayından kaldırılması da buna dahildir.
- Sürüm dile göre ayrıdır. EN metinleri değişince yalnızca `lang: "en"` sürümü değişir.
- Yeri olmayan şehir için de sürüm döner (`places: []`). `null` yalnızca şehir yoksa gelir.

### `city_progress` — ilerleme çubuğu (giriş gerekli)

```ts
await supabase.rpc("city_progress", { city_slug: "istanbul" });

type CityProgress = {
  city: string; total: number; visited: number;
  by_kind: Partial<Record<PlaceKind, { total: number; visited: number }>>;
  by_category: Array<{ category: CategorySlug; total: number; visited: number }>;
};
```

### `my_achievements` — rozetler (giriş gerekli)

Tüm aktif rozetler. Kazanılanlar önce (yeniden eskiye), sonra kilitliler ilerlemeyle.

```ts
await supabase.rpc("my_achievements", { lang: "tr" });
// -> Array<{ slug: string; name: string; description: string | null; badge_path: string | null;
//            earned_at: string | null; progress: number; target: number }>
```

Rozet görseli: `supabase.storage.from("badges").getPublicUrl(badge_path)`. `badge_path` henüz boş; görseller hazır olunca dolacak, o zamana kadar slug'a göre yerel ikon kullan.

### `my_visits` — ziyaret geçmişi (giriş gerekli)

Yeniden eskiye. Sonraki sayfa için son satırın `visited_at` değerini `before_time` olarak gönder.

```ts
await supabase.rpc("my_visits", { page_size: 20, before_time: null, lang: "tr" });
// -> Array<{ visit_id, place_id, slug, name, kind, category, visited_at }>
```

### `my_summary` — yıllık özet ve paylaşım kartı (giriş gerekli)

Yıl içinde "şu ana kadarki özet" olarak çalışır. Paylaşım kartı (9:16) görselini mobil çizer.

```ts
await supabase.rpc("my_summary", { for_year: 2027, lang: "tr" });  // for_year: null = bu yıl

type YearSummary = {
  year: number;
  total_places: number; historical: number; nature: number;
  top_city: string | null;
  oldest_place: { slug: string; name: string; built_year: number } | null;
  favorite_period: string | null;
  favorite_category: CategorySlug | null;
  distance_km: number;          // gezilen yerler arası düz mesafe toplamı (yaklaşık)
  sunset_checkins: number;      // seyir noktalarında 17:00-20:00 arası check-in
  badges_earned: number;
  busiest_month: number | null; // 1-12; ay adını dile göre sen yaz
};
```

### `update_profile` ve `export_my_data` (giriş gerekli)

```ts
await supabase.rpc("update_profile", {
  username: "emre_1",        // ^[a-z0-9_]{3,20}$ ; null = değiştirme
  avatar_path: null, is_public: null, preferred_lang: "en",
});
// -> { id, username, avatar_path, is_public, preferred_lang }
// Kullanıcı adı alınmışsa ya da kurala uymuyorsa error döner (Postgres 23505 / 23514).

await supabase.rpc("export_my_data"); // KVKK: kullanıcının tüm verisi tek JSON
// -> { exported_at, profile, visits: [{ place, place_id, visited_at, method, distance_m, gps_accuracy_m }],
//      achievements: [{ achievement, earned_at }],
//      submissions: [{ kind, place, name, category, lat, lng, note, status, admin_note, created_at, resolved_at }] }
// visits[].place yayından kalkmış bir yer için null olabilir (place_id yine dolu).
// friendships: [{ username, direction: "sent"|"received", status, created_at, responded_at }]
```

Profil yalnızca `update_profile` ile değiştirilmeli. `profiles` tablosuna doğrudan yazma
`username`, `avatar_path`, `is_public`, `preferred_lang` ile sınırlıdır; `avatar_path` her
durumda `<user_id>/...` olmalıdır (aksi halde 23514).

### Avatar yükleme (giriş gerekli)

Kullanıcı yalnızca kendi klasörüne yazabilir: `avatars/<user_id>/...`. En fazla 2 MB, yalnızca JPEG, PNG, WebP.

```ts
const { data: { user } } = await supabase.auth.getUser();
const path = `${user.id}/avatar-${Date.now()}.jpg`;      // yeni ad: önbellek sorunu olmaz
await supabase.storage.from("avatars").upload(path, file, { contentType: "image/jpeg", upsert: true });
await supabase.rpc("update_profile", { avatar_path: path });  // başka klasör -> hata (22023)
const url = supabase.storage.from("avatars").getPublicUrl(path).data.publicUrl;
```

Yüklemeden önce görseli 512×512'ye küçültmen önerilir (`expo-image-manipulator`).

## Hesap silme (Edge Function, giriş gerekli)

App Store ve Google Play, uygulama içinden hesap silmeyi zorunlu tutar. Ayarlar'da "Hesabımı sil" → onay penceresi → çağrı → oturumu kapat.

```ts
const { data, error } = await supabase.functions.invoke("delete-account", { body: { confirm: "DELETE" } });
// data: { ok: true }  -> await supabase.auth.signOut(); yerel verileri (ziyaret önbelleği vb.) temizle
```

| HTTP | `error` | Anlamı |
| --- | --- | --- |
| 200 | – | Silindi: hesap, profil, ziyaretler, rozetler, avatar dosyaları. Kullanıcının bildirimleri kimliksiz kalır. |
| 400 | `invalid_input` | `confirm: "DELETE"` gönderilmedi |
| 401 | `not_authenticated` | Oturum yok |
| 500 | `server_error` | Tekrar dene |

Geri alınamaz; onay penceresinde bunu açıkça yaz.

## Kullanıcı katkısı: bildirim ve yeni yer önerisi (giriş gerekli)

Yanıtlar `{ ok: true, ... }` ya da `{ ok: false, error }`. Bildirimler proje sahibinin onayına düşer.

### `report_place` — mevcut yer için bildirim

```ts
await supabase.rpc("report_place", {
  place_id: "<uuid>",
  kind: "wrong_location",   // "wrong_location" | "wrong_info" | "closed" | "duplicate"
  note: "Giriş kapısı arka sokakta",   // isteğe bağlı, en fazla 1000 karakter
  lat: 41.0262, lng: 28.9742,          // isteğe bağlı; wrong_location için doğru konum (ikisi birlikte)
  lang: "tr",
});
// -> { ok: true, id }
```

Önerilen ekran: yer detayında "Bir sorun mu var?" → 4 seçenek. "Konum yanlış" seçilince haritada iğneyi doğru yere sürükletip `lat/lng` gönder.

### `suggest_place` — listede olmayan yeni yer

```ts
await supabase.rpc("suggest_place", {
  name: "Çamlıca Kulesi",   // 2-120 karakter
  category: "tower",        // CategorySlug
  lat: 41.0270, lng: 29.0690,
  note: "Yeni açılan seyir kulesi",   // isteğe bağlı
  lang: "tr",
});
// -> { ok: true, id, possible_duplicates: [{ id, slug, name, distance_m }] }
```

`possible_duplicates` doluysa (150 m içinde yayındaki yerler) kullanıcıya "Bunlardan biri mi?" diye göster. Öneri yine de kaydedilmiştir; kullanıcı vazgeçerse bir şey yapman gerekmez.

### Hata kodları

| `error` | Anlamı | Önerilen mesaj (TR) |
| --- | --- | --- |
| `not_authenticated` | Oturum yok | "Öneri göndermek için giriş yap." |
| `invalid_input` | Alan eksik/hatalı | "Bilgileri kontrol et." |
| `place_not_found` | Yer yok ya da yayında değil | "Bu yer bulunamadı." |
| `unknown_category` | Kategori geçersiz | – (uygulama hatası) |
| `outside_service_area` | En yakın yer 50 km'den uzak | "Bu bölge henüz uygulamada yok." |
| `already_reported` | Aynı bildirim/öneri zaten bekliyor | "Bunu zaten bildirdin, inceliyoruz." |
| `rate_limited` | Son 24 saatte 20 gönderim | "Bugünlük yeterince katkı yaptın, teşekkürler!" |

### `my_submissions` — kullanıcının gönderdikleri

```ts
await supabase.rpc("my_submissions", { lang: "tr" });
// -> Array<{ id, kind, status: "open" | "accepted" | "rejected", place_id, place_name,
//            suggested_name, admin_note, created_at, resolved_at }>
```

Kabul edilen ilk katkıda `city-helper` ("Şehir Gönüllüsü") rozeti verilir; `my_achievements` içinde görünür. Görseli `assets/badges/city-helper.webp` ve Storage'da.

`admin_submissions` ve `admin_resolve_submission` yalnızca yönetici içindir; mobil uygulama bunları çağırmaz.

---

## Arkadaşlar ve sıralama (giriş gerekli)

Tüm fonksiyonlar `{ ok: true, ... }` ya da `{ ok: false, error }` döner. Kişiler **kullanıcı adıyla** tanımlanır; kullanıcı kimliği (uuid) hiç dönmez.

```ts
await supabase.rpc("search_users", { query: "ay", max_results: 10 });
// -> { ok, users: [{ username, avatar_path, relation }] }
//    relation: "none" | "friend" | "request_sent" | "request_received"
//    Herkese açık profiller adın başıyla (en az 2 harf) bulunur; gizli profil (is_public=false) yalnızca tam adla.

await supabase.rpc("send_friend_request", { username: "ayse" });
// -> { ok, status: "pending" }   karşı taraf sana zaten istek gönderdiyse { ok, status: "accepted" }

await supabase.rpc("respond_friend_request", { username: "ayse", accept: true });
// -> { ok, status: "accepted" | "declined" }

await supabase.rpc("remove_friend", { username: "ayse" }); // arkadaşlıktan çıkar ya da gönderdiğin isteği geri al

await supabase.rpc("my_friends");
// -> { ok, friends: [{ username, avatar_path, since, total_places, badges }],
//      incoming: [{ username, avatar_path, created_at }], outgoing: [...] }

await supabase.rpc("friends_leaderboard", { period: "week", city_slug: null });
// period: "week" (pazartesiden beri) | "month" | "year" | "all"; city_slug verilirse yalnızca o şehir
// -> { ok, period, since, entries: [{ rank, username, avatar_path, places, is_me }] }
```

- Sıralama puanı: dönemde gezilen **farklı yer** sayısı (işaretli ziyaretler sayılmaz). Eşit puanlılar aynı sırayı paylaşır (1, 1, 3). Listede sen ve kabul edilmiş arkadaşların var; tek başınaysan yalnızca sen.
- Avatar: `avatar_path` Storage `avatars` bucket'ındaki yol; herkese açık adresi `supabase.storage.from("avatars").getPublicUrl(avatar_path)`.
- İstek göndermek için önce kullanıcı adı seçilmiş olmalı (`update_profile`).
- Sınırlar: günde 30 istek, en fazla 500 arkadaş.

| `error` | Anlamı | Önerilen mesaj (TR) |
| --- | --- | --- |
| `not_authenticated` | Oturum yok | "Arkadaş eklemek için giriş yap." |
| `username_required` | Kendi kullanıcı adın yok | "Önce bir kullanıcı adı seç." |
| `user_not_found` | Böyle kullanıcı yok | "Bu kullanıcı bulunamadı." |
| `cannot_add_self` | Kendini eklemeye çalıştın | – |
| `already_friends` | Zaten arkadaşsınız | "Zaten arkadaşsınız." |
| `already_requested` | İstek zaten gönderildi | "İsteğin bekliyor." |
| `request_not_found` | Yanıtlanacak istek yok | "Bu istek artık geçerli değil." |
| `not_friends` | Silinecek arkadaşlık/istek yok | – |
| `friend_limit` | 500 arkadaş sınırı | "Arkadaş sınırına ulaştın." |
| `rate_limited` | Son 24 saatte 30 istek | "Bugünlük çok istek gönderdin, yarın tekrar dene." |
| `invalid_input` | Geçersiz dönem ya da şehir | – (uygulama hatası) |

## Check-in (Edge Function)

```ts
const { data, error } = await supabase.functions.invoke("checkin", {
  body: {
    place_id: "<uuid>",
    lat: 41.0279, lng: 29.0689,
    accuracy_m: 8,          // expo-location: coords.accuracy
    lang: "tr",
  },
});
```

Giriş yapılmış olmalı; supabase-js oturum token'ını kendisi ekler.

**Başarılı:**

```json
{
  "ok": true,
  "visit_id": "7c1e…",
  "flagged": false,
  "distance_m": 28,
  "new_achievements": [
    { "slug": "first-view", "name": "İlk Manzara", "description": "İlk seyir noktanı gez.", "badge_path": null }
  ],
  "city_progress": { "city": "istanbul", "total": 15, "visited": 1, "by_kind": { "...": "..." }, "by_category": [] }
}
```

`flagged: true` ise ziyaret kaydedildi ama hız kontrolüne takıldı (ör. 5 dakikada 20 km). Rozete sayılmaz, `new_achievements` boş gelir. Kullanıcıya hata gösterme; normal "kaydedildi" ekranı yeterli.

**Beklenen retler HTTP 200 ile döner**, `ok: false`:

| `error` | Ne zaman | Ek alanlar | Kullanıcıya önerilen mesaj (TR) |
| --- | --- | --- | --- |
| `too_far` | Yere uzak | `distance_m`, `allowed_m` | "Check-in için biraz daha yaklaş (şu an 240 m uzaktasın)." |
| `low_accuracy` | GPS doğruluğu 50 m'den kötü | `accuracy_m`, `max_accuracy_m` | "Konum net değil. Açık bir alana çıkıp tekrar dene." |
| `already_visited` | Bu yer zaten gezilmiş | – | "Burayı zaten gezdin." |
| `rate_limited` | Son 1 dakikada 5 check-in | – | "Biraz yavaş! Bir dakika sonra tekrar dene." |
| `place_not_found` | Yer yok ya da yayında değil | – | "Bu yer bulunamadı." |

**HTTP hataları** (`error` dolu gelir; gövde: `await error.context.json()`):

| HTTP | `error` | Anlamı |
| --- | --- | --- |
| 400 | `invalid_input` | Eksik/bozuk alan (place_id UUID, lat/lng aralık dışı vb.) |
| 401 | `not_authenticated` | Oturum yok ya da süresi dolmuş → giriş ekranı |
| 500 | `server_error` | Sunucu hatası → "Bir sorun oldu, tekrar dene." |

**İzin verilen mesafe** = yerin `checkin_radius_m` değeri + GPS doğruluğu (en fazla 50 m). Orman, koru, ada gibi alanı tanımlı yerlerde (`has_area: true`) alanın içinde olmak yeterli. Butonu aktif etmek için mobil tarafta aynı hesabı yapabilirsin; son kararı her zaman sunucu verir.

---

## Supabase hatası alırsan

`supabase.rpc` hata döndürürse `error.code` Postgres hata kodudur (ör. `42501` = yetki yok, `PGRST202` = fonksiyon bulunamadı veya parametre adı yanlış). Parametre adları bu dosyadakiyle birebir aynı olmalı.
