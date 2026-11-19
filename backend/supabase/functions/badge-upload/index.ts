// Rozet görsellerini 'badges' bucket'ına yükler. Gizli anahtar gerektirmez:
// yalnızca aşağıdaki 26 dosya, içeriği birebir aynıysa (SHA-256) kabul edilir.
// Başka bir dosya veya değiştirilmiş içerik 403 döner. Kullanan: .github/workflows/badges.yml
import { createClient } from "npm:@supabase/supabase-js@2";

const ALLOWED: Record<string, string> = {
  "first-friend.webp": "2189fbbf248daa168267491005befe3926bb79bb1197e87482212998e9ce9ee5",
  "travel-crew.webp": "beed87cb6a7e74031fce997539cfdc16b1f30402b795734a89f8d61c4e5fcf5f",
  "route-first.webp": "348dfa7f5e2f463b974d8e4611fff29448a3b5ae17d95bad0aa2ffca50803713",
  "route-master.webp": "187e4f077695bdcdbd4439ea3c465350a16600ec84f9f4beae677cd399040ae5",
  "city-helper.webp": "6917bc8864ac26e16d02dd3cb4f0a891c7add2cdb659b785b6bfc42691409730",
  "byzantine-traveler.webp": "bd2bae140669533a0e512a3417928ee7af30a0132492953f5bdd34433bf71f9f",
  "explorer-10.webp": "4de6d2c8f52c80a7a05a88486feca1150c6af66756863599f894460c7c631b42",
  "explorer-25.webp": "4100ca331e04e957d7802e0adb5402e6b900b5ae9c19fd9dce1f3094d2d266a8",
  "explorer-50.webp": "2b93beab68ee9fb0d0fea217b60d57983dbf08d8d8abedc44f2ecafc82ed56f7",
  "first-step.webp": "882224d32cf19775bad84eed36c8c076e96ea174945ab80604563b423273ac41",
  "first-view.webp": "abf274bcb26f0798045c63560e4746df026e7e3f16e44b9905b9eabfdb040307",
  "forest-walker.webp": "e82abb111bdaf8e5326ef54d6448b2a89f018dec57d8331df5776a0b1e866892",
  "history-buff-10.webp": "8b6c0ec91c975dca7de650a022303fd3ee952da2150633c5ba87f66bd207f915",
  "islands-tour.webp": "0a8e65c00c8c638e87e8f2c186f15a18e07ec64a20a9a653d146051857032838",
  "istanbul-complete.webp": "bd9875a87a7432404c33b93a408e463bae8f0f1b721cd9c5e104170226c0b43d",
  "istanbul-history-complete.webp": "4d7b0e05e02fe5cc7d84ed2879d1da3a427bcbc96b18efb19c85dc441e6fca25",
  "mosque-wanderer.webp": "5acfc174de89acaff8d09fc553f96894c735d2500d86b400c9d08c803b602731",
  "museum-lover.webp": "9122d0e726017aaad68fc3fe0b46c65662848569d4b641e0a6af6f670b407f9a",
  "nature-explorer.webp": "8cf8802d9cccb507a5678a55eaa3021d9a7871a57dd54099b7bfc484075bd194",
  "ottoman-heritage.webp": "5049239a56d797aeaf5efd2d446e167f217e44cc2d39d796480bf3685e427938",
  "palace-life.webp": "ae7841a2967daab182be48dc7e13f480d08c1066a78d0daa4e40e2ebd01ed94b",
  "streak-4-weeks.webp": "a021a52b59edfe07ce0fdd6e21c2f04261553df0d35dc9c0f1a525d9878422df",
  "sultans-rest.webp": "17b58a50144215dc444902cbe2fee7631d7ba2a82f56382d73cb11fcc99d3a72",
  "sunset-collector.webp": "4ccbf2388673a3a592756a1fd08f0b39a9fd6be56db32c7f22d4f43d8030b698",
  "view-hunter.webp": "115c11df37cf0aa04be6afc424b9dca1e6468954d465df5b09326165c228c6df",
  "wall-keeper.webp": "99c1743686dc0d0ad8dae821d67d5896dffceb67fabd62074020df70c13ad2b5",
};

async function sha256Hex(buf: ArrayBuffer): Promise<string> {
  const d = await crypto.subtle.digest("SHA-256", buf);
  return Array.from(new Uint8Array(d)).map((b) => b.toString(16).padStart(2, "0")).join("");
}

Deno.serve(async (req) => {
  if (req.method !== "POST") return new Response("method not allowed", { status: 405 });
  const name = new URL(req.url).searchParams.get("name") ?? "";
  const expected = ALLOWED[name];
  if (!expected) return new Response("unknown file", { status: 403 });
  const body = await req.arrayBuffer();
  if (body.byteLength > 2_000_000) return new Response("too large", { status: 413 });
  if ((await sha256Hex(body)) !== expected) return new Response("content mismatch", { status: 403 });

  const supabase = createClient(Deno.env.get("SUPABASE_URL")!, Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
  const { error } = await supabase.storage.from("badges").upload(name, body, {
    contentType: "image/webp",
    upsert: true,
    cacheControl: "604800",
  });
  if (error) return new Response(`storage error: ${error.message}`, { status: 500 });
  return new Response(JSON.stringify({ ok: true, name }), { headers: { "content-type": "application/json" } });
});
