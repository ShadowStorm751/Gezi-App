// content-apply Edge Function — onaylı İÇERİK migration'larını (ör. uzun açıklamalar) canlıya uygular.
// Gizli anahtar gerektirmez: yalnızca aşağıdaki listede adı ve SHA-256'sı birebir eşleşen dosya çalışır.
// Listede olmayan ya da içeriği değişmiş dosya 403 döner. Zaten uygulanmış sürüm atlanır (tekrar çalışmaz).
// Dosya tek işlemde (transaction) uygulanır ve supabase_migrations.schema_migrations'a kaydedilir.
// Yalnızca veri/içerik migration'ları için; şema değişiklikleri Claude tarafından elle uygulanır.
// Kullanan: .github/workflows/content-apply.yml
import postgres from "npm:postgres@3.4.5";

const ALLOWED: Record<string, string> = {
  "20261120050000_istanbul_long_desc_1.sql": "3ca2cea0562cd4be2c1011a098ea97bb4a70ee6790969df337cff3972aaa368d",
  "20261120060000_istanbul_long_desc_2.sql": "cae7d68adb1090e90bdb5bed04ad846b6f390248e9310ecab3816e6a2eb6268e",
};

async function sha256Hex(text: string): Promise<string> {
  const d = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return Array.from(new Uint8Array(d)).map((b) => b.toString(16).padStart(2, "0")).join("");
}

Deno.serve(async (req) => {
  if (req.method !== "POST") return new Response("method not allowed", { status: 405 });
  const name = new URL(req.url).searchParams.get("name") ?? "";
  const expected = ALLOWED[name];
  if (!expected) return Response.json({ ok: false, error: "unknown file" }, { status: 403 });
  const body = await req.text();
  if (body.length > 1_000_000) return Response.json({ ok: false, error: "too large" }, { status: 413 });
  if ((await sha256Hex(body)) !== expected) {
    return Response.json({ ok: false, error: "content mismatch" }, { status: 403 });
  }
  const m = name.match(/^(\d{14})_([a-z0-9_]+)\.sql$/);
  if (!m) return Response.json({ ok: false, error: "bad name" }, { status: 400 });
  const [, version, migName] = m;

  const sql = postgres(Deno.env.get("SUPABASE_DB_URL")!, { prepare: false, max: 1 });
  try {
    const done = await sql`select 1 from supabase_migrations.schema_migrations where version = ${version}`;
    if (done.length > 0) return Response.json({ ok: true, skipped: true, name });
    await sql.begin(async (tx) => {
      await tx.unsafe(body);
      await tx`insert into supabase_migrations.schema_migrations (version, name) values (${version}, ${migName})`;
    });
    return Response.json({ ok: true, applied: name });
  } catch (e) {
    return Response.json({ ok: false, error: String(e) }, { status: 500 });
  } finally {
    await sql.end();
  }
});
