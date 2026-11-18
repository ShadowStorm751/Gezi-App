-- "Adalar Turu" rozeti: kural 'burgazada' diyordu ama yerin slug'ı 'burgaz-adasi'.
-- Bu hâliyle rozet kazanılamıyordu. Yalnızca eski (yanlış) kural duruyorsa düzeltilir.
update public.achievements
set rule = '{"type":"place_set","places":["buyukada","heybeliada","burgaz-adasi","kinaliada"]}'::jsonb
where slug = 'islands-tour'
  and rule->'places' ? 'burgazada';
