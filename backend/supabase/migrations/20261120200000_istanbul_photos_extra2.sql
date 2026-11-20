-- Genel ve ilk ek aramada fotoğrafı çıkmayan 3 İstanbul yeri için hedefli aramayla seçilmiş Commons fotoğrafları.
-- Üreten: data-pipeline/content/build_photos_extra2.py (kaynak: results/photo-candidates-2/candidates.json).
-- Mobil, fotoğrafın altında author ve license bilgisini göstermelidir (lisans koşulu).

delete from public.place_photos ph
using public.places p
where ph.place_id = p.id
  and ph.url like 'https://%.wikimedia.org/%'
  and p.slug in ('aydos-ormani', 'hacilli-selalesi', 'yenikoy-seyir-terasi');

insert into public.place_photos
  (place_id, url, thumb_url, width, height, license, license_url, author, source_url, sort_order)
select p.id, v.url, v.thumb_url, v.width::int, v.height::int, v.license, v.license_url, v.author, v.source_url, 0
from (values
  ('aydos-ormani', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/05/Aydos.jpg/1280px-Aydos.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/05/Aydos.jpg/500px-Aydos.jpg', 1280, 960, 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Seyidkılıc', 'https://commons.wikimedia.org/wiki/File:Aydos.jpg'),
  ('hacilli-selalesi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/38/Agva_wineport_otel_-_panoramio.jpg/1280px-Agva_wineport_otel_-_panoramio.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/38/Agva_wineport_otel_-_panoramio.jpg/500px-Agva_wineport_otel_-_panoramio.jpg', 1280, 960, 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Wineport Lodge Agva', 'https://commons.wikimedia.org/wiki/File:Agva_wineport_otel_-_panoramio.jpg'),
  ('yenikoy-seyir-terasi', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/65/Yenik%C3%B6y_%2856561%29.jpg/1280px-Yenik%C3%B6y_%2856561%29.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/65/Yenik%C3%B6y_%2856561%29.jpg/500px-Yenik%C3%B6y_%2856561%29.jpg', 1280, 576, 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Özgür Arda BAYRAM', 'https://commons.wikimedia.org/wiki/File:Yenik%C3%B6y_(56561).jpg')
) v(slug, url, thumb_url, width, height, license, license_url, author, source_url)
join public.places p on p.slug = v.slug;
