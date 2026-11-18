// checkin Edge Function
// İstemci: supabase.functions.invoke("checkin", { body: { place_id, lat, lng, accuracy_m, lang } })
// Yanıt sözleşmesi: docs/API.md -> "checkin".
//
// Beklenen ret durumları (çok uzak, düşük doğruluk vb.) HTTP 200 + { ok: false, error } döner,
// böylece istemci tek bir yoldan okur. HTTP 400/401/500 yalnızca bozuk istek, oturum yok
// ve sunucu hatası içindir.

import { createClient } from "jsr:@supabase/supabase-js@2";
import {
  type CheckinContext,
  type CheckinErrorCode,
  decideCheckin,
  parseCheckinInput,
} from "./rules.ts";

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

function fail(status: number, error: CheckinErrorCode, details?: Record<string, number>) {
  return json(status, { ok: false, error, ...details });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return fail(405, "invalid_input");

  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const serviceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const admin = createClient(supabaseUrl, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  // 1. Oturum
  const token = (req.headers.get("Authorization") ?? "").replace(/^Bearer\s+/i, "");
  if (!token) return fail(401, "not_authenticated");
  const { data: userData, error: authError } = await admin.auth.getUser(token);
  const user = userData?.user;
  if (authError || !user) return fail(401, "not_authenticated");

  // 2. Girdi
  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return fail(400, "invalid_input");
  }
  const input = parseCheckinInput(body);
  if (!input) return fail(400, "invalid_input");

  // 3. Ölçümler (mesafe, alan, önceki ziyaret, sıklık)
  const { data: ctxData, error: ctxError } = await admin.rpc("checkin_context", {
    p_user: user.id,
    p_place: input.place_id,
    p_lat: input.lat,
    p_lng: input.lng,
  });
  if (ctxError) {
    console.error("checkin_context", ctxError);
    return fail(500, "server_error");
  }
  const ctx = ctxData as CheckinContext;

  // 4. Karar
  const decision = decideCheckin(input, ctx, new Date());
  if (!decision.ok) return fail(200, decision.error, decision.details);

  // 5. Kayıt
  const { data: visitId, error: visitError } = await admin.rpc("record_visit", {
    p_user: user.id,
    p_place: input.place_id,
    p_distance_m: decision.distance_m,
    p_accuracy_m: input.accuracy_m,
    p_flagged: decision.flagged,
  });
  if (visitError) {
    console.error("record_visit", visitError);
    return fail(500, "server_error");
  }
  if (!visitId) return fail(200, "already_visited"); // aynı anda iki istek gelirse

  // 6. Rozetler (işaretlenen ziyaret rozete sayılmaz)
  let newAchievements: Array<{
    slug: string;
    name: string | null;
    description: string | null;
    badge_path: string | null;
  }> = [];

  if (!decision.flagged) {
    const { data: ids, error: achError } = await admin.rpc("evaluate_achievements", {
      p_user: user.id,
    });
    if (achError) {
      console.error("evaluate_achievements", achError);
    } else if (Array.isArray(ids) && ids.length > 0) {
      const { data: rows } = await admin
        .from("achievements")
        .select("slug, badge_path, sort_order, achievement_translations(lang, name, description)")
        .in("id", ids)
        .eq("achievement_translations.lang", input.lang)
        .order("sort_order");
      newAchievements = (rows ?? []).map((r) => {
        const t = (r.achievement_translations as Array<{ name: string; description: string }>)[0];
        return {
          slug: r.slug as string,
          name: t?.name ?? null,
          description: t?.description ?? null,
          badge_path: (r.badge_path as string | null) ?? null,
        };
      });
    }
  }

  // 7. Şehir ilerlemesi
  const { data: progress } = await admin.rpc("city_progress_for", {
    p_user: user.id,
    p_city_slug: ctx.city_slug,
  });

  return json(200, {
    ok: true,
    visit_id: visitId,
    flagged: decision.flagged,
    distance_m: decision.distance_m,
    new_achievements: newAchievements,
    city_progress: progress ?? null,
  });
});
