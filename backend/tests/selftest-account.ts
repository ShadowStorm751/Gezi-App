// Geçici uçtan uca test: avatar, bildirim/öneri ve hesap silme.
// Kullanım: 'selftest-account' adıyla (verify_jwt=false) Edge Function olarak yükle,
// data-pipeline/selftest-account-request.txt'yi değiştirip push'la (.github/workflows/selftest-account.yml),
// sonucu data-pipeline/results/selftest-account.json'da oku, sonra fonksiyonu 410 dönen taslakla değiştir.
// functions/ klasöründe değil: toplu deploy ile kazara yayına çıkmasın.
import { createClient } from "npm:@supabase/supabase-js@2";

const PNG = Uint8Array.from(atob(
  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
), (c) => c.charCodeAt(0));

Deno.serve(async () => {
  const url = Deno.env.get("SUPABASE_URL")!;
  const anon = Deno.env.get("SUPABASE_ANON_KEY")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
  const out: Record<string, unknown> = {};
  const email = `selftest-${crypto.randomUUID()}@example.com`;
  const password = crypto.randomUUID() + "Aa1!";
  let userId: string | null = null;
  const submissionIds: string[] = [];
  try {
    const { data: created, error: ce } = await admin.auth.admin.createUser({ email, password, email_confirm: true });
    if (ce) throw new Error("createUser: " + ce.message);
    userId = created.user.id;
    const anonClient = createClient(url, anon, { auth: { persistSession: false } });
    const { data: s, error: se } = await anonClient.auth.signInWithPassword({ email, password });
    if (se) throw new Error("signIn: " + se.message);
    const token = s.session!.access_token;
    const user = createClient(url, anon, {
      auth: { persistSession: false },
      global: { headers: { Authorization: `Bearer ${token}` } },
    });

    // Avatar
    const up = await user.storage.from("avatars").upload(`${userId}/a.png`, PNG, { contentType: "image/png", upsert: true });
    out.avatar_own_folder = up.error ? `HATA: ${up.error.message}` : "ok";
    const other = await user.storage.from("avatars").upload(`00000000-0000-0000-0000-000000000000/x.png`, PNG, { contentType: "image/png" });
    out.avatar_other_folder_blocked = other.error ? "ok (engellendi)" : "HATA: yüklendi";
    const txt = await user.storage.from("avatars").upload(`${userId}/x.txt`, new TextEncoder().encode("x"), { contentType: "text/plain" });
    out.avatar_wrong_type_blocked = txt.error ? "ok (engellendi)" : "HATA: yüklendi";
    const prof = await user.rpc("update_profile", { avatar_path: `${userId}/a.png` });
    out.update_profile_own_path = prof.error ? `HATA: ${prof.error.message}` : prof.data;
    const prof2 = await user.rpc("update_profile", { avatar_path: `00000000-0000-0000-0000-000000000000/x.png` });
    out.update_profile_other_path_blocked = prof2.error ? "ok (engellendi)" : "HATA: kabul edildi";

    // Bildirim ve öneri
    const { data: galata } = await admin.from("places").select("id").eq("slug", "galata-kulesi").single();
    const r1 = await user.rpc("report_place", { place_id: galata!.id, kind: "wrong_info", note: "selftest" });
    out.report_place = r1.error ?? r1.data;
    if ((r1.data as { id?: string })?.id) submissionIds.push((r1.data as { id: string }).id);
    const r2 = await user.rpc("report_place", { place_id: galata!.id, kind: "wrong_info", note: "selftest" });
    out.report_place_again = r2.error ?? r2.data;
    const s1 = await user.rpc("suggest_place", { name: "Selftest Yeri", category: "viewpoint", lat: 41.0257, lng: 28.9743, note: "selftest" });
    out.suggest_place = s1.error ?? s1.data;
    if ((s1.data as { id?: string })?.id) submissionIds.push((s1.data as { id: string }).id);
    const s2 = await user.rpc("suggest_place", { name: "Ankara Kalesi", category: "fortress", lat: 39.94, lng: 32.86 });
    out.suggest_outside = s2.error ?? s2.data;
    const mine = await user.rpc("my_submissions", { lang: "tr" });
    out.my_submissions_count = mine.error ? `HATA: ${mine.error.message}` : (mine.data as unknown[]).length;
    const adm = await user.rpc("admin_submissions", {});
    out.admin_list_blocked_for_user = adm.error ? `ok (${adm.error.code})` : "HATA: kullanıcı yönetici listesini gördü";
    const res = await user.rpc("admin_resolve_submission", { submission_id: submissionIds[0], accept: true });
    out.admin_resolve_blocked_for_user = res.error ? `ok (${res.error.code})` : "HATA: kullanıcı karar verebildi";
    const ins = await user.from("place_submissions").insert({ kind: "closed", place_id: galata!.id });
    out.direct_insert_blocked = ins.error ? "ok (engellendi)" : "HATA: doğrudan yazıldı";

    // Hesap silme
    const call = async (body: unknown) => {
      const r = await fetch(`${url}/functions/v1/delete-account`, {
        method: "POST",
        headers: { "content-type": "application/json", apikey: anon, authorization: `Bearer ${token}` },
        body: JSON.stringify(body),
      });
      let j: unknown = null; try { j = await r.json(); } catch { /* */ }
      return { status: r.status, body: j };
    };
    out.delete_without_confirm = await call({});
    out.delete_with_confirm = await call({ confirm: "DELETE" });

    const { data: after, error: ae } = await admin.auth.admin.getUserById(userId);
    out.user_gone = ae || !after?.user ? "ok" : "HATA: kullanıcı duruyor";
    if (ae || !after?.user) userId = null;
    const { data: left } = await admin.storage.from("avatars").list(created.user.id);
    out.avatar_files_left = (left ?? []).length;
    const { data: subs } = await admin.from("place_submissions").select("id, user_id").in("id", submissionIds);
    out.submissions_kept_anonymous = (subs ?? []).map((x) => x.user_id === null);
    const { count: prof3 } = await admin.from("profiles").select("*", { count: "exact", head: true }).eq("id", created.user.id);
    out.profile_rows_left = prof3;
  } catch (e) {
    out.error = String(e);
  } finally {
    if (submissionIds.length) await admin.from("place_submissions").delete().in("id", submissionIds);
    if (userId) {
      await admin.storage.from("avatars").remove([`${userId}/a.png`]);
      await admin.auth.admin.deleteUser(userId);
      out.cleanup_user = "silindi (test sonunda)";
    }
    out.cleanup_submissions = submissionIds.length;
  }
  return new Response(JSON.stringify(out, null, 1), { headers: { "content-type": "application/json" } });
});
