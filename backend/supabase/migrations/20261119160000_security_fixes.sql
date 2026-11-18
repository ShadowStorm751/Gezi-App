-- Supabase güvenlik denetçisinin uyarıları (2026-11-19):
-- 1) norm_lang fonksiyonunda search_path sabit değildi.
-- 2) handle_new_user (yalnızca auth.users tetikleyicisi için) API üzerinden çağrılabiliyordu.
alter function public.norm_lang(text) set search_path = public;
revoke execute on function public.handle_new_user() from public, anon, authenticated;
