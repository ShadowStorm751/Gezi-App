const radians = degrees => degrees * Math.PI / 180;

function distanceMeters(from, to) {
  const latitudeChange = radians(to.latitude - from.latitude);
  const longitudeChange = radians(to.longitude - from.longitude);
  const a = Math.sin(latitudeChange / 2) ** 2 +
    Math.cos(radians(from.latitude)) * Math.cos(radians(to.latitude)) *
    Math.sin(longitudeChange / 2) ** 2;
  return 6371000 * 2 * Math.asin(Math.sqrt(Math.min(1, a)));
}

function bearingDegrees(from, to) {
  const longitudeChange = radians(to.longitude - from.longitude);
  const start = radians(from.latitude);
  const end = radians(to.latitude);
  const east = Math.sin(longitudeChange) * Math.cos(end);
  const north = Math.cos(start) * Math.sin(end) -
    Math.sin(start) * Math.cos(end) * Math.cos(longitudeChange);
  return (Math.atan2(east, north) * 180 / Math.PI + 360) % 360;
}

function relativeDirection(bearing, heading) {
  return ((bearing - heading + 540) % 360) - 180;
}

// Fraction of the portrait camera width, using a provisional horizontal lens angle.
function cameraTargets(places, origin, heading, radius = 2000, fieldOfView = 60) {
  if (!origin || !Number.isFinite(heading)) return [];
  return places.map(place => {
    const distance = distanceMeters(origin, place.coordinate);
    const angle = relativeDirection(bearingDegrees(origin, place.coordinate), heading);
    const visible = Math.abs(angle) <= fieldOfView / 2;
    const fraction = visible
      ? 0.5 + Math.tan(radians(angle)) / (2 * Math.tan(radians(fieldOfView / 2)))
      : null;
    return {...place, distance, angle, fraction, visible};
  }).filter(place => place.distance <= radius).sort((a, b) => a.distance - b.distance);
}

// Free exploration shows every visible place. A tracked place keeps its own
// marker at the nearest screen edge when the user looks away.
function cameraMarkers(targets, trackedId) {
  return targets.flatMap(target => {
    const tracked = target.id === trackedId;
    if (trackedId && !tracked) return [];
    if (target.visible) return [{...target, edge: null}];
    if (!tracked) return [];
    const left = target.angle < 0;
    return [{...target, edge: left ? 'left' : 'right', fraction: left ? 0 : 1}];
  });
}

module.exports = { distanceMeters, bearingDegrees, relativeDirection, cameraTargets, cameraMarkers };
