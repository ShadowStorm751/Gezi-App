// Geçici uçtan uca test: kullanıcı fotoğrafları (yükleme, gönderme, yönetici onayı/reddi,
// yerde görünme, rozet, silme, photo-cleanup, hesap silmede dosyaların gitmesi).
// Kullanım: 'selftest-photos' adıyla (verify_jwt=false) Edge Function olarak yükle,
// data-pipeline/selftest-photos-request.txt'yi değiştirip push'la (.github/workflows/selftest-photos.yml),
// sonucu data-pipeline/results/selftest-photos.json'da oku, sonra fonksiyonu 410 dönen taslakla değiştir.
import { createClient, type SupabaseClient } from "npm:@supabase/supabase-js@2";

type J = Record<string, unknown>;
const JPEG = Uint8Array.from(atob("/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAwAEADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC5RRRXxx9mFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQB//9k="), (c) => c.charCodeAt(0));

Deno.serve(async () => {
  const url = Deno.env.get("SUPABASE_URL")!;
  const anonKey = Deno.env.get("SUPABASE_ANON_KEY")!;
  const admin = createClient(url, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, { auth: { persistSession: false } });
  const out: J = {};
  const ids: string[] = [];
  const tag = crypto.randomUUID().replace(/-/g, "").slice(0, 8);
  const ok = (cond: boolean, detail: unknown) => (cond ? "ok" : { HATA: detail });
  const rnd = () => crypto.randomUUID().replace(/-/g, "").slice(0, 16);

  async function newUser(name: string, isAdmin = false) {
    const email = `selftest-${crypto.randomUUID()}@example.com`;
    const password = crypto.randomUUID() + "Aa1!";
    const { data, error } = await admin.auth.admin.createUser({
      email, password, email_confirm: true, app_metadata: isAdmin ? { role: "admin" } : {} });
    if (error) throw new Error("createUser: " + error.message);
    ids.push(data.user.id);
    const login = createClient(url, anonKey, { auth: { persistSession: false } });
    const { data: s, error: se } = await login.auth.signInWithPassword({ email, password });
    if (se) throw new Error("signIn: " + se.message);
    const token = s.session!.access_token;
    const client = createClient(url, anonKey, {
      auth: { persistSession: false }, global: { headers: { Authorization: `Bearer ${token}` } } });
    await client.rpc("update_profile", { username: name });
    return { id: data.user.id, token, client, name };
  }
  const rpc = async (c: SupabaseClient, fn: string, args: J = {}) => {
    const r = await c.rpc(fn, args);
    return r.error ? { rpc_error: r.error.message, code: r.error.code } : r.data;
  };
  const upload = (c: SupabaseClient, path: string, type = "image/jpeg", body: Uint8Array = JPEG) =>
    c.storage.from("user-photos").upload(path, body, { contentType: type, upsert: false });
  const publicUrl = (path: string) => `${url}/storage/v1/object/public/user-photos/${path}`;

  try {
    const A = await newUser(`spa${tag}`);
    const B = await newUser(`spb${tag}`);
    const M = await newUser(`spm${tag}`, true);
    const { data: place } = await admin.from("places").select("id").eq("slug", "aydos-ormani").single();
    const placeId = place!.id as string;

    // Yükleme izinleri
    const p1 = `${A.id}/${rnd()}.jpg`;
    const up1 = await upload(A.client, p1);
    out.upload_own_folder = ok(!up1.error, up1.error?.message);
    const upOther = await upload(A.client, `${B.id}/${rnd()}.jpg`);
    out.upload_other_folder_blocked = ok(!!upOther.error, "yüklendi");
    const upText = await upload(A.client, `${A.id}/${rnd()}.jpg`, "text/plain", new TextEncoder().encode("merhaba"));
    out.upload_wrong_type_blocked = ok(!!upText.error, "yüklendi");
    const upAnon = await createClient(url, anonKey, { auth: { persistSession: false } })
      .storage.from("user-photos").upload(`${A.id}/${rnd()}.jpg`, JPEG, { contentType: "image/jpeg" });
    out.upload_anon_blocked = ok(!!upAnon.error, "yüklendi");

    // Gönderme
    const notVisited = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: p1 }) as J;
    out.submit_requires_visit = ok(notVisited?.error === "not_visited", notVisited);
    await admin.rpc("record_visit", { p_user: A.id, p_place: placeId, p_distance_m: 5, p_accuracy_m: 5, p_flagged: false });
    const bad = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: `${B.id}/abcdefgh12.jpg` }) as J;
    out.submit_foreign_path = ok(bad?.error === "invalid_input", bad);
    const nofile = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: `${A.id}/${rnd()}.jpg` }) as J;
    out.submit_missing_file = ok(nofile?.error === "file_not_found", nofile);
    const sub1 = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: p1, caption: "Orman yolu" }) as J;
    out.submit_ok = ok(sub1?.ok === true && sub1?.status === "pending", sub1);
    const dup = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: p1 }) as J;
    out.submit_duplicate = ok(dup?.error === "already_submitted", dup);

    // Yetki
    const userResolve = await rpc(A.client, "admin_resolve_photo", { photo_id: sub1.id, accept: true }) as J;
    out.user_cannot_resolve = ok(userResolve?.code === "42501", userResolve);
    const userList = await rpc(A.client, "admin_photo_submissions") as J;
    out.user_cannot_list = ok(userList?.code === "42501", userList);
    const bSees = await B.client.from("photo_submissions").select("id");
    out.other_user_sees_nothing = ok((bSees.data ?? []).length === 0, bSees.data);
    const detailBefore = await rpc(B.client, "place_detail", { place_id: placeId, lang: "tr" }) as J;
    out.pending_not_on_place = ok(!JSON.stringify(detailBefore?.photos ?? []).includes(p1), "görünüyor");

    // Yönetici onayı
    const mList = await rpc(M.client, "admin_photo_submissions") as J[];
    out.admin_list = ok(Array.isArray(mList) && mList.some((x) => x.id === sub1.id), mList);
    const appr = await rpc(M.client, "admin_resolve_photo", { photo_id: sub1.id, accept: true }) as J;
    out.admin_approve = ok(appr?.status === "approved", appr);
    const detail = await rpc(B.client, "place_detail", { place_id: placeId, lang: "tr" }) as J;
    const ph = ((detail?.photos ?? []) as J[]).find((x) => String(x.url ?? "").includes(p1));
    out.approved_on_place = ok(!!ph && ph.author === `@${A.name}`, detail?.photos);
    const pub = await fetch(publicUrl(p1));
    await pub.arrayBuffer();
    out.public_url_works = ok(pub.status === 200, pub.status);
    const pack = await rpc(createClient(url, anonKey, { auth: { persistSession: false } }), "city_pack",
      { city_slug: "istanbul", lang: "tr" }) as J;
    const aydos = ((pack?.places ?? []) as J[]).find((x) => x.slug === "aydos-ormani");
    out.city_pack_thumb = ok(String(aydos?.thumb_url ?? "").includes(p1), aydos?.thumb_url);
    const ach = await A.client.rpc("my_achievements", { lang: "tr" });
    out.photographer_badge = ok(((ach.data ?? []) as J[]).some((x) => x.slug === "photographer" && x.earned_at), ach.error);
    const mine = await rpc(A.client, "my_photos") as J[];
    out.my_photos = ok(Array.isArray(mine) && mine[0]?.status === "approved", mine);

    // Ret + temizlik
    const p2 = `${A.id}/${rnd()}.jpg`;
    await upload(A.client, p2);
    const sub2 = await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: p2 }) as J;
    const rej = await rpc(M.client, "admin_resolve_photo", { photo_id: sub2.id, accept: false, admin_note: "bulanık" }) as J;
    out.admin_reject = ok(rej?.status === "rejected", rej);
    const cl = await fetch(`${url}/functions/v1/photo-cleanup`, { method: "POST", headers: { apikey: anonKey } });
    const clBody = await cl.json() as J;
    out.cleanup_rejected = ok(cl.status === 200 && (clBody.removed_rejected as number) >= 1, clBody);
    const gone = await fetch(publicUrl(p2));
    await gone.arrayBuffer();
    out.rejected_file_deleted = ok(gone.status >= 400, gone.status);
    const still = await fetch(publicUrl(p1));
    await still.arrayBuffer();
    out.approved_file_kept = ok(still.status === 200, still.status);

    // KVKK dışa aktarım
    const exp = await rpc(A.client, "export_my_data") as J;
    out.export_photos = ok(((exp?.photos ?? []) as unknown[]).length === 2, (exp?.photos as unknown[])?.length);

    // Kullanıcının kendi silmesi
    const del = await rpc(A.client, "delete_my_photo", { photo_id: sub1.id }) as J;
    await A.client.storage.from("user-photos").remove([p1]);
    const detailAfter = await rpc(B.client, "place_detail", { place_id: placeId, lang: "tr" }) as J;
    out.user_delete = ok(del?.ok === true && !JSON.stringify(detailAfter?.photos ?? []).includes(p1), del);

    // Hesap silme dosyaları da siler
    const p3 = `${A.id}/${rnd()}.jpg`;
    await upload(A.client, p3);
    await rpc(A.client, "submit_place_photo", { place_id: placeId, storage_path: p3 });
    const da = await fetch(`${url}/functions/v1/delete-account`, {
      method: "POST", headers: { "content-type": "application/json", apikey: anonKey, authorization: `Bearer ${A.token}` },
      body: JSON.stringify({ confirm: "DELETE" }) });
    await da.text();
    const left = await admin.storage.from("user-photos").list(A.id);
    const { count: subs } = await admin.from("photo_submissions").select("*", { count: "exact", head: true }).eq("user_id", A.id);
    out.delete_account_removes_photos = ok(da.status === 200 && (left.data ?? []).length === 0 && subs === 0,
      { status: da.status, files: (left.data ?? []).length, subs });
  } catch (e) {
    out.error = String(e);
  } finally {
    for (const id of ids) {
      const { data: files } = await admin.storage.from("user-photos").list(id);
      if (files?.length) await admin.storage.from("user-photos").remove(files.map((f) => `${id}/${f.name}`));
      await admin.auth.admin.deleteUser(id);
    }
    const { count: v } = await admin.from("visits").select("*", { count: "exact", head: true }).in("user_id", ids);
    const { count: s } = await admin.from("photo_submissions").select("*", { count: "exact", head: true }).in("user_id", ids);
    const { count: pp } = await admin.from("place_photos").select("*", { count: "exact", head: true }).not("submission_id", "is", null);
    out.cleanup = ok((v ?? 0) + (s ?? 0) + (pp ?? 0) === 0, { visits: v, submissions: s, user_place_photos: pp });
  }
  const failed = Object.entries(out).filter(([k, v]) => k === "error" || (typeof v === "object" && v !== null && "HATA" in v));
  return new Response(JSON.stringify({ summary: failed.length ? `HATA: ${failed.map(([k]) => k).join(", ")}` : "hepsi geçti", ...out }, null, 1),
    { headers: { "content-type": "application/json" } });
});
