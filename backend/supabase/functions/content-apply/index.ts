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
  "20261120070000_istanbul_long_desc_3.sql": "ce3c5ea3f29fc0a7908863cca6a511ddbcc0882f7e9a8b0e81a54dae2d789966",
  "20261120080000_istanbul_long_desc_4.sql": "74a07bd10eb8e10017a4bd46c52c2176bf834cb8fae0df3053ae708cb1390fa9",
  "20261120090000_istanbul_long_desc_5.sql": "ff9da126fd50b0bc81921dc93244d5d3c96dd80f9b7673a5d3a38ab2f669e66d",
  "20261120100000_istanbul_long_desc_6.sql": "89cc5637f2fe9b08da04ee08e6a8e017801b10b6c683d38c88b65c50b7530862",
  "20261120110000_istanbul_long_desc_7.sql": "916684154b059d10016121b82f7c34ba8c268ed8959370f7ade32dfae29eb563",
  "20261120120000_istanbul_long_desc_8.sql": "b8f3fe1b4102e1cf6b3b3108bd30e0fe422339c3e1c6c0efe8ec78c5105f1264",
  "20261120130000_istanbul_long_desc_9.sql": "a344af12a0ce8999585af13911665d2b99a18bc317905999e72ac3b76267a118",
  "20261120140000_istanbul_long_desc_10.sql": "dbbc36b2fb32e658e5006eb8dfb769ea3c4a75a0eaa790f92968e0167702e867",
  "20261120150000_istanbul_long_desc_11.sql": "6a039d7d3880c047144ca648241eacb6c67b5526186f5b5b370c657ad40806bc",
  "20261120160000_istanbul_long_desc_12.sql": "1068c2edc87493691d11d70e8789efcc05a8f11eaf088b703ac99c1678a8175c",
  "20261120170000_istanbul_long_desc_13.sql": "01bdeab858bf456a091cb7989f8091aeb3e6efce690b34c09ffa9393c36b434d",
  "20261120180000_istanbul_long_desc_14.sql": "d01939bf701500dacb6e736e4ad18db0162ca744f1c4cbb902dc7badb09eeef1",
  "20261120190000_istanbul_long_desc_15.sql": "5c101a16109413fa61f4b8521147e174a51fd2e1d043179c9fedc8acf533bc9d",
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
