// Check-in karar kuralları. Saf fonksiyonlar: ağ ya da veritabanı erişimi yok,
// bu yüzden Node veya Deno ile doğrudan test edilebilir (rules.test.ts).

export const MAX_ACCURACY_M = 50; // GPS doğruluğu bundan kötüyse check-in reddedilir
export const MAX_SPEED_KMH = 150; // önceki check-in'e göre bundan hızlıysa ziyaret işaretlenir
export const MIN_DISTANCE_FOR_SPEED_M = 200; // yakın yerler arasında GPS oynamasını yok say
export const MAX_CHECKINS_PER_MINUTE = 5;

export type Lang = "tr" | "en";

export type CheckinErrorCode =
  | "invalid_input"
  | "not_authenticated"
  | "place_not_found"
  | "already_visited"
  | "rate_limited"
  | "low_accuracy"
  | "too_far"
  | "server_error";

export interface CheckinInput {
  place_id: string;
  lat: number;
  lng: number;
  accuracy_m: number;
  lang: Lang;
}

/** public.checkin_context SQL fonksiyonunun döndürdüğü ölçümler. */
export interface CheckinContext {
  found: boolean;
  city_slug?: string;
  radius_m?: number;
  distance_m?: number;
  inside_area?: boolean;
  already_visited?: boolean;
  recent_count?: number;
  previous?: { visited_at: string; distance_m: number } | null;
}

export type CheckinDecision =
  | { ok: true; flagged: boolean; distance_m: number }
  | { ok: false; error: CheckinErrorCode; details?: Record<string, number> };

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const isFiniteNumber = (v: unknown): v is number =>
  typeof v === "number" && Number.isFinite(v);

/** İstek gövdesini doğrular. Geçersizse null döner. */
export function parseCheckinInput(body: unknown): CheckinInput | null {
  if (typeof body !== "object" || body === null) return null;
  const b = body as Record<string, unknown>;

  if (typeof b.place_id !== "string" || !UUID_RE.test(b.place_id)) return null;
  if (!isFiniteNumber(b.lat) || b.lat < -90 || b.lat > 90) return null;
  if (!isFiniteNumber(b.lng) || b.lng < -180 || b.lng > 180) return null;
  if (!isFiniteNumber(b.accuracy_m) || b.accuracy_m < 0) return null;

  return {
    place_id: b.place_id.toLowerCase(),
    lat: b.lat,
    lng: b.lng,
    accuracy_m: b.accuracy_m,
    lang: b.lang === "en" ? "en" : "tr",
  };
}

/** Önceki check-in'den bu yana gereken hız (km/s). Önceki yoksa null. */
export function impliedSpeedKmh(
  previous: CheckinContext["previous"],
  now: Date,
): number | null {
  if (!previous) return null;
  if (previous.distance_m < MIN_DISTANCE_FOR_SPEED_M) return 0;
  const hours = (now.getTime() - Date.parse(previous.visited_at)) / 3_600_000;
  if (!(hours > 0)) return Number.POSITIVE_INFINITY;
  return previous.distance_m / 1000 / hours;
}

/** İzin verilen en büyük mesafe: yerin yarıçapı + GPS doğruluğu. */
export function allowedDistanceM(radiusM: number, accuracyM: number): number {
  return radiusM + Math.min(accuracyM, MAX_ACCURACY_M);
}

/**
 * Check-in kararı. Sıra önemlidir:
 * yer var mı -> zaten gezildi mi -> sıklık -> GPS doğruluğu -> mesafe/alan -> hız.
 * Hız kontrolüne takılan ziyaret reddedilmez, işaretlenir (flagged) ve rozetlere sayılmaz.
 */
export function decideCheckin(
  input: CheckinInput,
  ctx: CheckinContext,
  now: Date,
): CheckinDecision {
  if (!ctx.found) return { ok: false, error: "place_not_found" };
  if (ctx.already_visited) return { ok: false, error: "already_visited" };

  if ((ctx.recent_count ?? 0) >= MAX_CHECKINS_PER_MINUTE) {
    return { ok: false, error: "rate_limited" };
  }

  if (input.accuracy_m > MAX_ACCURACY_M) {
    return {
      ok: false,
      error: "low_accuracy",
      details: { accuracy_m: Math.round(input.accuracy_m), max_accuracy_m: MAX_ACCURACY_M },
    };
  }

  const distance = ctx.distance_m ?? Number.POSITIVE_INFINITY;
  const allowed = allowedDistanceM(ctx.radius_m ?? 0, input.accuracy_m);
  if (!ctx.inside_area && distance > allowed) {
    return {
      ok: false,
      error: "too_far",
      details: { distance_m: Math.round(distance), allowed_m: Math.round(allowed) },
    };
  }

  const speed = impliedSpeedKmh(ctx.previous, now);
  const flagged = speed !== null && speed > MAX_SPEED_KMH;

  return { ok: true, flagged, distance_m: Math.round(distance) };
}
