const radians = degrees => degrees * Math.PI / 180;
// A fixed viewpoint one kilometre south of Galata Tower, used only in the camera demo.
const galataPreviewOrigin = {latitude:41.0166556, longitude:28.9741556};

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
function rearCameraPitch(rotation) {
  if (!Number.isFinite(rotation?.beta) || !Number.isFinite(rotation?.gamma)) return null;
  // Rear lens looks along -Z. The vertical component is independent of yaw.
  const vertical = -Math.cos(rotation.beta) * Math.cos(rotation.gamma);
  return Math.asin(Math.max(-1, Math.min(1, vertical))) * 180 / Math.PI;
}

const edgeHints = {
  left: 'sola dön', right: 'sağa dön', top: 'telefonu yukarı kaldır', bottom: 'telefonu aşağı indir'
};
const edgeArrows = {left: '‹', right: '›', top: '↑', bottom: '↓'};

function cameraMarkers(targets, trackedId, pitch = 0, aspect = 0.6) {
  // Places have no altitude yet. Their directional anchors lie on the horizon.
  const tilt = radians(Math.max(-90, Math.min(90, pitch)));
  const scale = 2 * Math.tan(radians(30));
  const horizon = 0.5 + Math.tan(tilt) * aspect / scale;
  return targets.flatMap(target => {
    const tracked = target.id === trackedId;
    if (trackedId && !tracked) return [];
    let x = target.fraction;
    let edge = null;
    if (!target.visible) {
      edge = target.angle < 0 ? 'left' : 'right';
      x = target.angle < 0 ? 0 : 1;
    } else {
      x = 0.5 + (x - 0.5) / Math.max(0.0001, Math.cos(tilt));
      if (horizon < 0) edge = 'top';
      else if (horizon > 1) edge = 'bottom';
      else if (x < 0 || x > 1) edge = x < 0 ? 'left' : 'right';
    }
    if (edge && !tracked) return [];
    return [{...target, edge, fraction: Math.max(0, Math.min(1, x)),
      vertical: Math.max(0, Math.min(1, horizon))}];
  });
}

module.exports = { galataPreviewOrigin, distanceMeters, bearingDegrees, relativeDirection, cameraTargets, cameraMarkers,
  rearCameraPitch, edgeHints, edgeArrows };
