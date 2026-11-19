// Geçici uçtan uca test: geçici kullanıcı -> giriş -> checkin (red ve başarı) -> rozet -> kullanıcıyı sil.
// Test bitince bu fonksiyon 410 dönen bir taslakla değiştirilir.
// Kullanım: bu dosyayı 'selftest-checkin' adıyla (verify_jwt=false) Edge Function olarak yükle,
// data-pipeline/selftest-request.txt'yi değiştirip push'la (.github/workflows/selftest.yml),
// sonucu data-pipeline/results/selftest.json'da oku, sonra fonksiyonu yine devre dışı bırak.
// functions/ klasöründe değil: toplu 'supabase functions deploy' ile kazara yayına çıkmasın.
import { createClient } from "npm:@supabase/supabase-js@2";

Deno.serve(async () => {
  const url = Deno.env.get("SUPABASE_URL")!;
  const anon = Deno.env.get("SUPABASE_ANON_KEY")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
  const out: Record<string, unknown> = {};
  const email = `selftest-${crypto.randomUUID()}@example.com`;
  const password = crypto.randomUUID() + "Aa1!";
  let userId: string | null = null;
  try {
    const { data: created, error: ce } = await admin.auth.admin.createUser({ email, password, email_confirm: true });
    if (ce) throw new Error("createUser: " + ce.message);
    userId = created.user.id;
    const userClient = createClient(url, anon, { auth: { persistSession: false } });
    const { data: s, error: se } = await userClient.auth.signInWithPassword({ email, password });
    if (se) throw new Error("signIn: " + se.message);
    const token = s.session!.access_token;
    const { data: place } = await admin.from("places").select("id, location").eq("slug", "galata-kulesi").single();
    const placeId = place!.id as string;
    const call = async (body: unknown, auth = true) => {
      const r = await fetch(`${url}/functions/v1/checkin`, {
        method: "POST",
        headers: { "content-type": "application/json", apikey: anon, ...(auth ? { authorization: `Bearer ${token}` } : {}) },
        body: JSON.stringify(body),
      });
      let j: unknown = null; try { j = await r.json(); } catch { /* */ }
      return { status: r.status, body: j };
    };
    const base = { place_id: placeId, lang: "tr" };
    out.no_token = await call({ ...base, lat: 41.0256, lng: 28.97416, accuracy_m: 10 }, false);
    out.bad_input = await call({ place_id: "x", lat: 1, lng: 1, accuracy_m: 1 });
    out.too_far = await call({ ...base, lat: 41.0369, lng: 28.9850, accuracy_m: 10 });
    out.low_accuracy = await call({ ...base, lat: 41.0256, lng: 28.97416, accuracy_m: 80 });
    out.success = await call({ ...base, lat: 41.02560, lng: 28.97416, accuracy_m: 10 });
    out.again = await call({ ...base, lat: 41.02560, lng: 28.97416, accuracy_m: 10 });
    const { data: ach, error: ae } = await userClient.rpc("my_achievements", { lang: "tr" });
    out.earned = ae ? ae.message : (ach as Array<{ slug: string; earned_at: string | null }>).filter((a) => a.earned_at).map((a) => a.slug);
    const { data: vis, error: ve } = await userClient.rpc("my_visits", { page_size: 10, before_time: null, lang: "tr" });
    out.my_visits = ve ? ve.message : (vis as Array<{ slug: string }>).map((v) => v.slug);
  } catch (e) {
    out.fatal = String(e);
  } finally {
    if (userId) {
      const { error } = await admin.auth.admin.deleteUser(userId);
      out.cleanup = error ? error.message : "deleted";
      const { count } = await admin.from("visits").select("id", { count: "exact", head: true }).eq("user_id", userId);
      out.leftover_visits = count;
    }
  }
  return new Response(JSON.stringify(out, null, 2), { headers: { "content-type": "application/json" } });
});
