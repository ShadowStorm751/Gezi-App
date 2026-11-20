// photo-cleanup Edge Function — 'user-photos' bucket'ındaki gereksiz dosyaları siler.
// Silinenler: reddedilen gönderimlerin dosyaları ve 24 saattir hiçbir gönderime bağlanmamış
// (yüklenip gönderilmemiş ya da gönderimi silinmiş) dosyalar. Onaylı ve bekleyen dosyalara dokunmaz.
// Gizli anahtar gerektirmez: yalnızca bu kurala uyan dosyaları siler, çağıran ne gönderirse göndersin.
// Tetikleyen: .github/workflows/photo-cleanup.yml (günde bir) ya da elle.
import { createClient } from "jsr:@supabase/supabase-js@2";

Deno.serve(async (req) => {
  if (req.method !== "POST") return new Response("method not allowed", { status: 405 });
  const admin = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!, {
    auth: { persistSession: false, autoRefreshToken: false },
  });

  // 1. Reddedilenler
  const { data: rejected, error: re } = await admin.from("photo_submissions")
    .select("id, storage_path").eq("status", "rejected").is("files_deleted_at", null).limit(500);
  if (re) return Response.json({ ok: false, error: re.message }, { status: 500 });
  let removedRejected = 0;
  if (rejected && rejected.length > 0) {
    const { error } = await admin.storage.from("user-photos").remove(rejected.map((r) => r.storage_path));
    if (error) return Response.json({ ok: false, error: error.message }, { status: 500 });
    await admin.from("photo_submissions").update({ files_deleted_at: new Date().toISOString() })
      .in("id", rejected.map((r) => r.id));
    removedRejected = rejected.length;
  }

  // 2. Sahipsiz dosyalar (24 saatten eski, gönderimi olmayan)
  const cutoff = Date.now() - 24 * 3600_000;
  const orphans: string[] = [];
  const { data: folders, error: fe } = await admin.storage.from("user-photos").list("", { limit: 1000 });
  if (fe) return Response.json({ ok: false, error: fe.message }, { status: 500 });
  for (const folder of folders ?? []) {
    if (folder.id) continue; // klasör değil, kökte dosya (olmamalı)
    const { data: files } = await admin.storage.from("user-photos").list(folder.name, { limit: 1000 });
    const paths = (files ?? []).filter((f) => f.id && Date.parse(f.created_at ?? "") < cutoff)
      .map((f) => `${folder.name}/${f.name}`);
    if (paths.length === 0) continue;
    const { data: known } = await admin.from("photo_submissions").select("storage_path").in("storage_path", paths);
    const keep = new Set((known ?? []).map((k) => k.storage_path));
    orphans.push(...paths.filter((p) => !keep.has(p)));
  }
  if (orphans.length > 0) {
    const { error } = await admin.storage.from("user-photos").remove(orphans);
    if (error) return Response.json({ ok: false, error: error.message }, { status: 500 });
  }
  return Response.json({ ok: true, removed_rejected: removedRejected, removed_orphans: orphans.length });
});
