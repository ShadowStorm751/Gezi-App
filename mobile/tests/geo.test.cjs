const test = require('node:test');
const assert = require('node:assert/strict');
const {distanceMeters, bearingDegrees, relativeDirection} = require('../geo');
const tower = require('../places.json')[0].coordinate;
const {cameraMarkers, cameraTargets} = require('../geo');
const places = require('../places.json');

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
  const street = {latitude:tower.latitude - 0.009, longitude:tower.longitude};
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
  const street = {latitude: tower.latitude - 0.009, longitude: tower.longitude};
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
