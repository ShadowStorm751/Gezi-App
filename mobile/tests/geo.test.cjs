const test = require('node:test');
const assert = require('node:assert/strict');
const {distanceMeters, bearingDegrees, relativeDirection} = require('../geo');
const tower = require('../places.json')[0].coordinate;
const {cameraMarkers, cameraTargets, rearCameraPitch, galataPreviewOrigin} = require('../geo');
const places = require('../places.json');

test('Arka kamera dik tutulduğunda ufka, ekran yukarı bakarken yere yönelir', () => {
  assert.ok(Math.abs(rearCameraPitch({beta:Math.PI / 2, gamma:0})) < 1e-8);
  assert.equal(rearCameraPitch({beta:0, gamma:0}), -90);
  assert.equal(rearCameraPitch({beta:0, gamma:Math.PI}), 90);
  assert.equal(rearCameraPitch(null), null);
  assert.equal(rearCameraPitch({beta:NaN, gamma:0}), null);
});

test('Eğim, yön ve mesafe sabitken baloncuğu kaydırır ve dikey kenar takibini korur', () => {
  const origin = {latitude:tower.latitude - 0.009, longitude:tower.longitude};
  const targets = cameraTargets(places, origin, 0);
  const at = pitch => cameraMarkers(targets, places[0].id, pitch, 0.55)[0];
  assert.ok(at(-15).vertical < at(0).vertical && at(15).vertical > at(0).vertical);
  assert.equal(at(0).vertical, 0.5);
  assert.equal(at(80).edge, 'bottom');
  assert.equal(at(-80).edge, 'top');
  assert.equal(at(80).distance, at(0).distance);
  assert.deepEqual(cameraMarkers(targets, null, 80, 0.55), []);
  assert.equal(at(0).edge, null);
});

test('Takip edilen ikinci yer kadraj dışındayken doğru kenarda kalır', () => {
  const street = {latitude:tower.latitude - 0.009, longitude:tower.longitude};
  const tracked = places[1].id;
  const markers = heading => cameraMarkers(cameraTargets(places, street, heading), tracked);
  assert.equal(markers(90)[0].edge, 'left');
  assert.equal(markers(270)[0].edge, 'right');
  assert.equal(markers(0)[0].edge, null);
  assert.equal(markers(90)[0].id, tracked);
  assert.equal(markers(90)[0].distance, markers(0)[0].distance);
  assert.deepEqual(cameraMarkers(cameraTargets(places, street, 90), null), []);
  assert.deepEqual(cameraMarkers([], tracked), []);
});

test('Dar sokak demosunda iki yer görünür, dönünce kadrajdan çıkar', () => {
  const street = galataPreviewOrigin;
  const north = cameraTargets(places, street, 0);
  assert.equal(north.length, 2);
  assert.ok(north.every(p => p.visible));
  assert.equal(north[0].fraction, 0.5);
  assert.ok(cameraTargets(places, street, 350)[0].fraction > 0.5);
  assert.ok(cameraTargets(places, street, 10)[0].fraction < 0.5);
  const south = cameraTargets(places, street, 180);
  assert.ok(south.every(p => !p.visible && p.fraction === null));
  assert.equal(south[0].distance, north[0].distance);
  assert.equal(cameraTargets(places, street, 0, 900).length, 0);
  assert.deepEqual(cameraTargets(places, street, null), []);
});

test('Kule güneydeki örnek konumdan yaklaşık 1 km uzakta ve kuzey yönünde', () => {
  const street = galataPreviewOrigin;
  assert.ok(Math.abs(distanceMeters(street, tower) - 1000) < 2);
  assert.equal(bearingDegrees(street, tower), 0);
  assert.equal(relativeDirection(0, 350), 10);
  assert.equal(relativeDirection(0, 10), -10);
  assert.equal(distanceMeters(tower, tower), 0);
});

test('Aynı konumda dönünce mesafe sabit, hedefin ekrandaki yönü değişir', () => {
  const street = {latitude:tower.latitude, longitude:tower.longitude - 0.012};
  const bearing = bearingDegrees(street, tower);
  assert.ok(Math.abs(bearing - 90) < 0.1);
  assert.ok(relativeDirection(bearing, 60) > 29);
  assert.ok(Math.abs(relativeDirection(bearing, 90)) < 0.1);
  assert.ok(Math.abs(distanceMeters(street, tower) - 1007) < 5);
});
