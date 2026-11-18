-- Yeni kategori: türbe (tarihi). Proje sahibinin isteğiyle önemli türbeler listeye eklendi.
-- Aynı hazîredeki türbeler (ör. Ayasofya türbeleri) tek yer olarak girilir.

insert into public.categories (slug, kind, icon, sort_order)
values ('tomb', 'historical', 'tomb', 20)
on conflict (slug) do nothing;

insert into public.category_translations (category_id, lang, name)
select c.id, v.lang, v.name
from (values ('tr', 'Türbe'), ('en', 'Tomb')) v(lang, name)
join public.categories c on c.slug = 'tomb'
on conflict (category_id, lang) do nothing;

insert into public.achievements (slug, rule, sort_order)
values ('sultans-rest', '{"type":"category_count","category":"tomb","n":5}', 18)
on conflict (slug) do nothing;

insert into public.achievement_translations (achievement_id, lang, name, description)
select a.id, v.lang, v.name, v.description
from (values
  ('tr', 'Padişah Türbeleri', '5 türbe gez.'),
  ('en', 'Resting Places of Sultans', 'Visit 5 tombs.')
) v(lang, name, description)
join public.achievements a on a.slug = 'sultans-rest'
on conflict (achievement_id, lang) do nothing;
