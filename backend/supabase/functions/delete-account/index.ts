// delete-account Edge Function — kullanıcının hesabını ve verisini kalıcı olarak siler.
// App Store ve Google Play, uygulama içinden hesap silmeyi zorunlu tutar.
//
// İstemci: supabase.functions.invoke("delete-account", { body: { confirm: "DELETE" } })
// Silinenler: auth kullanıcısı (-> profiles, visits, user_achievements, friendships,
//             photo_submissions ve onaylı fotoğrafları cascade ile),
//             avatars/<user_id>/ ve user-photos/<user_id>/ altındaki dosyalar.
// Kalanlar:   place_submissions satırları kimliksiz kalır (user_id = null).
// Yanıt: 200 { ok: true } | 400 invalid_input | 401 not_authenticated | 500 server_error

import { createClient } from "jsr:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
};

function json(status: number, body: unknown): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return json(405, { ok: false, error: "invalid_input" });

  const admin = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    { auth: { persistSession: false, autoRefreshToken: false } },
  );

  const token = (req.headers.get("Authorization") ?? "").replace(/^Bearer\s+/i, "");
  if (!token) return json(401, { ok: false, error: "not_authenticated" });
  const { data: userData, error: authError } = await admin.auth.getUser(token);
  const user = userData?.user;
  if (authError || !user) return json(401, { ok: false, error: "not_authenticated" });

  let body: { confirm?: unknown } = {};
  try {
    body = await req.json();
  } catch {
    return json(400, { ok: false, error: "invalid_input" });
  }
  if (body?.confirm !== "DELETE") return json(400, { ok: false, error: "invalid_input" });

  // 1. Avatar ve fotoğraf dosyaları (hata olsa da hesap silmeye devam edilir; kalan dosyaları
  //    photo-cleanup temizler, avatarlar sahipsiz kalır)
  for (const bucket of ["avatars", "user-photos"]) {
    const { data: files, error: listError } = await admin.storage.from(bucket).list(user.id, { limit: 1000 });
    if (listError) {
      console.error(`${bucket} list`, listError);
    } else if (files && files.length > 0) {
      const { error: removeError } = await admin.storage
        .from(bucket)
        .remove(files.map((f) => `${user.id}/${f.name}`));
      if (removeError) console.error(`${bucket} remove`, removeError);
    }
  }

  // 2. Kullanıcı (profil, ziyaret ve rozetler cascade ile silinir)
  const { error: deleteError } = await admin.auth.admin.deleteUser(user.id);
  if (deleteError) {
    console.error("deleteUser", deleteError);
    return json(500, { ok: false, error: "server_error" });
  }

  return json(200, { ok: true });
});
