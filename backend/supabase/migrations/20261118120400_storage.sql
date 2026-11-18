-- Gezi App: dosya depolama alanları (herkese açık okuma, yazma yalnızca service role)
insert into storage.buckets (id, name, public)
values
  ('place-photos', 'place-photos', true),
  ('badges', 'badges', true),
  ('avatars', 'avatars', true)
on conflict (id) do nothing;
