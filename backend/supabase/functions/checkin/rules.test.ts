// Check-in kurallarının testleri.
// Çalıştırma: node --experimental-strip-types --test backend/supabase/functions/checkin/rules.test.ts
// (Node 22.6+). Deno ile de çalışır: deno test backend/supabase/functions/checkin/

import { test } from "node:test";
import assert from "node:assert/strict";
import {
  allowedDistanceM,
  type CheckinContext,
  type CheckinInput,
  decideCheckin,
  impliedSpeedKmh,
  parseCheckinInput,
} from "./rules.ts";

const PLACE = "3f2a9c1e-5b7d-4e8a-9c21-7d4e5f6a8b90";
const now = new Date("2027-06-01T12:00:00Z");

const input = (over: Partial<CheckinInput> = {}): CheckinInput => ({
  place_id: PLACE,
  lat: 41.0086,
  lng: 28.9802,
  accuracy_m: 10,
  lang: "tr",
  ...over,
});

const ctx = (over: Partial<CheckinContext> = {}): CheckinContext => ({
  found: true,
  city_slug: "istanbul",
  radius_m: 75,
  distance_m: 40,
  inside_area: false,
  already_visited: false,
  recent_count: 0,
  previous: null,
  ...over,
});

test("girdi: geçerli istek kabul edilir, dil varsayılanı tr", () => {
  const parsed = parseCheckinInput({ place_id: PLACE, lat: 41, lng: 29, accuracy_m: 12 });
  assert.deepEqual(parsed, { place_id: PLACE, lat: 41, lng: 29, accuracy_m: 12, lang: "tr" });
  assert.equal(parseCheckinInput({ place_id: PLACE, lat: 41, lng: 29, accuracy_m: 1, lang: "en" })?.lang, "en");
});

test("girdi: bozuk istekler reddedilir", () => {
  assert.equal(parseCheckinInput(null), null);
  assert.equal(parseCheckinInput({ place_id: "abc", lat: 41, lng: 29, accuracy_m: 5 }), null);
  assert.equal(parseCheckinInput({ place_id: PLACE, lat: 91, lng: 29, accuracy_m: 5 }), null);
  assert.equal(parseCheckinInput({ place_id: PLACE, lat: 41, lng: "29", accuracy_m: 5 }), null);
  assert.equal(parseCheckinInput({ place_id: PLACE, lat: 41, lng: 29, accuracy_m: -1 }), null);
  assert.equal(parseCheckinInput({ place_id: PLACE, lat: NaN, lng: 29, accuracy_m: 5 }), null);
});

test("yakın ve doğru konum: kabul", () => {
  assert.deepEqual(decideCheckin(input(), ctx(), now), { ok: true, flagged: false, distance_m: 40 });
});

test("yer yok ya da yayında değil", () => {
  assert.deepEqual(decideCheckin(input(), { found: false }, now), { ok: false, error: "place_not_found" });
});

test("zaten gezilmiş", () => {
  const d = decideCheckin(input(), ctx({ already_visited: true }), now);
  assert.equal(d.ok, false);
  assert.equal(!d.ok && d.error, "already_visited");
});

test("dakikada 5 check-in sınırı", () => {
  const d = decideCheckin(input(), ctx({ recent_count: 5 }), now);
  assert.equal(!d.ok && d.error, "rate_limited");
  assert.equal(decideCheckin(input(), ctx({ recent_count: 4 }), now).ok, true);
});

test("GPS doğruluğu 50 m'den kötüyse ret", () => {
  const d = decideCheckin(input({ accuracy_m: 65 }), ctx(), now);
  assert.deepEqual(d, { ok: false, error: "low_accuracy", details: { accuracy_m: 65, max_accuracy_m: 50 } });
  assert.equal(decideCheckin(input({ accuracy_m: 50 }), ctx(), now).ok, true);
});

test("mesafe: yarıçap + doğruluk payı", () => {
  assert.equal(allowedDistanceM(75, 20), 95);
  assert.equal(decideCheckin(input({ accuracy_m: 20 }), ctx({ distance_m: 95 }), now).ok, true);
  const d = decideCheckin(input({ accuracy_m: 20 }), ctx({ distance_m: 96 }), now);
  assert.deepEqual(d, { ok: false, error: "too_far", details: { distance_m: 96, allowed_m: 95 } });
});

test("büyük alanın içindeyse merkeze uzaklık önemsiz", () => {
  const d = decideCheckin(input(), ctx({ distance_m: 2400, radius_m: 1500, inside_area: true }), now);
  assert.equal(d.ok, true);
});

test("hız: makul hız işaretlenmez", () => {
  // 10 km, 30 dakika önce -> 20 km/s
  const previous = { visited_at: "2027-06-01T11:30:00Z", distance_m: 10_000 };
  assert.equal(impliedSpeedKmh(previous, now), 20);
  assert.deepEqual(decideCheckin(input(), ctx({ previous }), now), { ok: true, flagged: false, distance_m: 40 });
});

test("hız: 150 km/s üstü işaretlenir ama kayıt kabul edilir", () => {
  // 20 km, 5 dakika önce -> 240 km/s
  const previous = { visited_at: "2027-06-01T11:55:00Z", distance_m: 20_000 };
  assert.deepEqual(decideCheckin(input(), ctx({ previous }), now), { ok: true, flagged: true, distance_m: 40 });
});

test("hız: 200 m'den yakın önceki yer GPS oynaması sayılır", () => {
  const previous = { visited_at: "2027-06-01T11:59:59Z", distance_m: 150 };
  assert.equal(impliedSpeedKmh(previous, now), 0);
});

test("hız: aynı anda iki uzak check-in işaretlenir", () => {
  const previous = { visited_at: "2027-06-01T12:00:00Z", distance_m: 5_000 };
  assert.equal(impliedSpeedKmh(previous, now), Number.POSITIVE_INFINITY);
});
