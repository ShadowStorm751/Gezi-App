// Geçici uçtan uca test: arkadaşlar, sıralama, sosyal rozetler, rotalar ve rota rozeti, şehir listesi.
// Kullanım: 'selftest-social' adıyla (verify_jwt=false) Edge Function olarak yükle,
// data-pipeline/selftest-social-request.txt'yi değiştirip push'la (.github/workflows/selftest-social.yml),
// sonucu data-pipeline/results/selftest-social.json'da oku, sonra fonksiyonu 410 dönen taslakla değiştir.
// functions/ klasöründe değil: toplu deploy ile kazara yayına çıkmasın.
import { createClient, type SupabaseClient } from "npm:@supabase/supabase-js@2";

type J = Record<string, unknown>;

Deno.serve(async () => {
  const url = Deno.env.get("SUPABASE_URL")!;
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
  const anon = createClient(url, anonKey, { auth: { persistSession: false } });
  const out: J = {};
  const ids: string[] = [];
  const tag = crypto.randomUUID().replace(/-/g, "").slice(0, 8);
  const ok = (cond: boolean, detail: unknown) => (cond ? "ok" : { HATA: detail });

  async function newUser(name: string | null) {
    const email = `selftest-${crypto.randomUUID()}@example.com`;
    const password = crypto.randomUUID() + "Aa1!";
    const { data, error } = await admin.auth.admin.createUser({ email, password, email_confirm: true });
    if (error) throw new Error("createUser: " + error.message);
    ids.push(data.user.id);
    const { data: s, error: se } = await anon.auth.signInWithPassword({ email, password });
    if (se) throw new Error("signIn: " + se.message);
    const token = s.session!.access_token;
    const client = createClient(url, anonKey, {
      auth: { persistSession: false },
      global: { headers: { Authorization: `Bearer ${token}` } },
    });
    return { id: data.user.id, token, client, name };
  }
  const rpc = async (c: SupabaseClient, fn: string, args: J = {}) => {
    const r = await c.rpc(fn, args);
    return r.error ? { rpc_error: r.error.message, code: r.error.code } : r.data;
  };

  try {
    const A = await newUser(`sta${tag}`);
    const B = await newUser(`stb${tag}`);
    const C = await newUser(`stc${tag}`);

    // Kullanıcı adı yokken istek
    const noName = await rpc(C.client, "send_friend_request", { username: A.name });
    out.username_required = ok((noName as J)?.error === "username_required", noName);

    for (const u of [A, B, C]) {
      const r = await rpc(u.client, "update_profile", { username: u.name, is_public: u !== C });
      if ((r as J)?.rpc_error) throw new Error("update_profile: " + JSON.stringify(r));
    }

    // Arama
    const sB = await rpc(A.client, "search_users", { query: `stb${tag}`.slice(0, 6) }) as J;
    const foundB = ((sB?.users ?? []) as J[]).find((u) => u.username === B.name);
    out.search_public_prefix = ok(foundB?.relation === "none", sB);
    const sCp = await rpc(A.client, "search_users", { query: `stc${tag}`.slice(0, 6) }) as J;
    out.search_private_prefix_hidden = ok(!((sCp?.users ?? []) as J[]).some((u) => u.username === C.name), sCp);
    const sCe = await rpc(A.client, "search_users", { query: C.name }) as J;
    out.search_private_exact_found = ok(((sCe?.users ?? []) as J[]).some((u) => u.username === C.name), sCe);
    const sAnon = await rpc(anon, "search_users", { query: "st" });
    out.search_anon_blocked = ok(!!(sAnon as J)?.rpc_error, sAnon);

    // İstek, kabul, sosyal rozet
    const req1 = await rpc(A.client, "send_friend_request", { username: B.name }) as J;
    out.request_sent = ok(req1?.status === "pending", req1);
    const req1b = await rpc(A.client, "send_friend_request", { username: B.name }) as J;
    out.request_duplicate = ok(req1b?.error === "already_requested", req1b);
    const self = await rpc(A.client, "send_friend_request", { username: A.name }) as J;
    out.request_self = ok(self?.error === "cannot_add_self", self);
    const bInbox = await rpc(B.client, "my_friends") as J;
    out.incoming_visible = ok(((bInbox?.incoming ?? []) as J[]).some((x) => x.username === A.name), bInbox);
    const acc = await rpc(B.client, "respond_friend_request", { username: A.name, accept: true }) as J;
    out.accept_with_badge = ok(acc?.status === "accepted" &&
      ((acc?.new_achievements ?? []) as string[]).includes("first-friend"), acc);
    const aAch = await A.client.rpc("my_achievements", { lang: "tr" });
    const aFirst = ((aAch.data ?? []) as J[]).find((x) => x.slug === "first-friend");
    out.requester_badge_too = ok(!!aFirst?.earned_at, aAch.error ?? aFirst);

    // Ters yönden istek -> otomatik kabul
    const cReq = await rpc(C.client, "send_friend_request", { username: A.name }) as J;
    const aBack = await rpc(A.client, "send_friend_request", { username: C.name }) as J;
    out.mutual_request_auto_accept = ok(cReq?.status === "pending" && aBack?.status === "accepted", { cReq, aBack });

    // Doğrudan yazma ve başkasının kaydını okuma engeli
    const ins = await C.client.from("friendships").insert({ requester_id: C.id, addressee_id: B.id });
    out.direct_insert_blocked = ok(!!ins.error, "eklendi");
    const bRows = await B.client.from("friendships").select("*");
    out.rls_only_own_rows = ok((bRows.data ?? []).length === 1, bRows.data);

    // Rota: Kadıköy Sahili'nin ilk 3 durağı servis ile (3 saat önce), sonuncusu gerçek check-in ile
    const route = await rpc(A.client, "route_detail", { route_slug: "kadikoy-sahili", lang: "tr" }) as J;
    const stops = (route?.stops ?? []) as J[];
    if (stops.length !== 4) throw new Error("rota durakları: " + JSON.stringify(route));
    for (const s of stops.slice(0, 3)) {
      const r = await admin.rpc("record_visit", {
        p_user: A.id, p_place: s.place_id, p_distance_m: 5, p_accuracy_m: 5, p_flagged: false });
      if (r.error) throw new Error("record_visit: " + r.error.message);
    }
    await admin.from("visits").update({ visited_at: new Date(Date.now() - 3 * 3600_000).toISOString() })
      .eq("user_id", A.id);
    const mid = await rpc(A.client, "route_detail", { route_slug: "kadikoy-sahili" }) as J;
    out.route_progress_3_of_4 = ok(mid?.visited_count === 3 && mid?.completed === false, mid?.visited_count);
    const last = stops[3];
    const chk = await fetch(`${url}/functions/v1/checkin`, {
      method: "POST",
      headers: { "content-type": "application/json", apikey: anonKey, authorization: `Bearer ${A.token}` },
      body: JSON.stringify({ place_id: last.place_id, lat: last.latitude, lng: last.longitude, accuracy_m: 10, lang: "tr" }),
    });
    const chkBody = await chk.json() as J;
    const newSlugs = ((chkBody?.new_achievements ?? []) as J[]).map((x) => x.slug);
    out.checkin_last_stop = ok(chk.status === 200 && chkBody?.ok === true && chkBody?.flagged === false,
      { status: chk.status, chkBody });
    out.checkin_route_badge = ok(newSlugs.includes("route-first"), newSlugs);
    const done = await rpc(A.client, "route_detail", { route_slug: "kadikoy-sahili" }) as J;
    out.route_completed = ok(done?.completed === true && done?.visited_count === 4, done?.completed);
    const anonList = await rpc(anon, "list_routes", { city_slug: "istanbul", lang: "en" }) as J[];
    out.list_routes_anon = ok(Array.isArray(anonList) && anonList.length >= 11 && anonList[0].visited_count === null,
      Array.isArray(anonList) ? anonList.length : anonList);
    const cities = await rpc(A.client, "list_cities", { lang: "tr" }) as J[];
    out.list_cities_visited = ok(Array.isArray(cities) && cities[0]?.visited_count === 4, cities);

    // Sıralama
    const lbA = await rpc(A.client, "friends_leaderboard", { period: "week" }) as J;
    const eA = (lbA?.entries ?? []) as J[];
    out.leaderboard_a = ok(eA.length === 3 && eA[0].username === A.name && eA[0].places === 4 &&
      eA[0].is_me === true && eA[1].rank === 2 && eA[2].rank === 2, eA);
    const lbB = await rpc(B.client, "friends_leaderboard", { period: "month", city_slug: "istanbul" }) as J;
    const eB = (lbB?.entries ?? []) as J[];
    out.leaderboard_b_sees_only_friends = ok(eB.length === 2 && !eB.some((x) => x.username === C.name), eB);
    const lbBad = await rpc(A.client, "friends_leaderboard", { period: "day" }) as J;
    out.leaderboard_bad_period = ok(lbBad?.error === "invalid_input", lbBad);
    const fr = await rpc(B.client, "my_friends") as J;
    const frA = ((fr?.friends ?? []) as J[]).find((x) => x.username === A.name);
    out.friend_stats = ok(frA?.total_places === 4 && (frA?.badges as number) >= 3, frA);

    // KVKK dışa aktarım
    const exp = await rpc(A.client, "export_my_data") as J;
    out.export_friendships = ok(((exp?.friendships ?? []) as unknown[]).length === 2 &&
      ((exp?.visits ?? []) as unknown[]).length === 4, { f: (exp?.friendships as unknown[])?.length });

    // Çıkarma
    const rm = await rpc(A.client, "remove_friend", { username: B.name }) as J;
    const rm2 = await rpc(A.client, "remove_friend", { username: B.name }) as J;
    out.remove_friend = ok(rm?.ok === true && rm2?.error === "not_friends", { rm, rm2 });
    const lbA2 = await rpc(A.client, "friends_leaderboard", { period: "all" }) as J;
    out.leaderboard_after_remove = ok(((lbA2?.entries ?? []) as J[]).length === 2, lbA2);
    const dec = await rpc(B.client, "send_friend_request", { username: C.name }) as J;
    const decl = await rpc(C.client, "respond_friend_request", { username: B.name, accept: false }) as J;
    out.decline = ok(dec?.status === "pending" && decl?.status === "declined", { dec, decl });
  } catch (e) {
    out.error = String(e);
  } finally {
    for (const id of ids) await admin.auth.admin.deleteUser(id);
    const { count: v } = await admin.from("visits").select("*", { count: "exact", head: true }).in("user_id", ids);
    const { count: f1 } = await admin.from("friendships").select("*", { count: "exact", head: true }).in("requester_id", ids);
    const { count: f2 } = await admin.from("friendships").select("*", { count: "exact", head: true }).in("addressee_id", ids);
    out.cleanup = ok((v ?? 0) + (f1 ?? 0) + (f2 ?? 0) === 0, { visits: v, friendships: (f1 ?? 0) + (f2 ?? 0) });
    out.cleanup_users = ids.length;
  }
  const failed = Object.entries(out).filter(([k, v]) => k === "error" || (typeof v === "object" && v !== null && "HATA" in v));
  return new Response(JSON.stringify({ summary: failed.length ? `HATA: ${failed.map(([k]) => k).join(", ")}` : "hepsi geçti", ...out }, null, 1),
    { headers: { "content-type": "application/json" } });
});
