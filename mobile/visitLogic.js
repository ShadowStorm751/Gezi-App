const {distanceMeters} = require('./geo');

// A hint only. The Edge Function decides whether the fix qualifies for check-in.
function distanceHint(place, coords) {
  if (!coords || place.hasArea !== false || !Number.isFinite(place.radius)) return null;
  const distance = distanceMeters(coords, place.coordinate);
  const allowance = Math.min(Math.max(coords.accuracy ?? 50,0),50);
  return distance > place.radius + allowance ? Math.round(distance) : null;
}

async function sendCheckin(invoke, placeId, coords, lang) {
  try {
    const {data,error} = await invoke('checkin',{body:{
      place_id:placeId,lat:coords.latitude,lng:coords.longitude,accuracy_m:coords.accuracy ?? 999,lang
    }});
    if (!error) return data || {ok:false,error:'server_error'};
    let body;
    try { body = await error.context?.json(); } catch { /* A gateway response may have no JSON body. */ }
    if (error.context?.status === 401) return {ok:false,error:'not_authenticated'};
    return {ok:false,error:body?.error || 'server_error'};
  } catch { return {ok:false,error:'server_error'}; }
}

function checkinOutcome(data,lang) {
  const label = (tr,en) => lang === 'en' ? en : tr;
  if (data?.ok === true) return {action:'record',message:label('Kaydedildi! 🎉','Checked in! 🎉'),
    awards:Array.isArray(data.new_achievements) ? data.new_achievements : [],progress:data.city_progress};
  const distance = Number.isFinite(data?.distance_m) ? Math.round(data.distance_m) : null;
  const messages = {
    too_far:distance === null ? label('Biraz daha yaklaş.','Get a little closer.') :
      label('Biraz daha yaklaş (şu an '+distance+' m uzaktasın).',"Get a little closer (you're "+distance+" m away)."),
    low_accuracy:label('Konum net değil. Açık bir alana çıkıp tekrar dene.',"Location isn't precise. Step into an open area and try again."),
    already_visited:label('Burayı zaten gezdin.',"You've already visited this place."),
    rate_limited:label('Biraz yavaş! Bir dakika sonra tekrar dene.','Slow down! Try again in a minute.'),
    place_not_found:label('Bu yer bulunamadı.',"This place couldn't be found."),
    not_authenticated:label('Devam etmek için giriş yap.','Sign in to continue.')
  };
  const actions = {already_visited:'visited',place_not_found:'refresh',not_authenticated:'login'};
  return {action:actions[data?.error] || 'retry',
    message:messages[data?.error] || label('Bir sorun oldu, tekrar dene.','Something went wrong, try again.')};
}

async function fetchVisitDates(rpc,lang,isActive) {
  const dates = {};
  let before = null;
  while (isActive()) {
    const {data,error} = await rpc('my_visits',{page_size:100,before_time:before,lang});
    if (error || !Array.isArray(data)) throw new Error('my_visits');
    for (const visit of data) dates[visit.place_id] = visit.visited_at;
    if (data.length < 100) break;
    const next = data[data.length-1].visited_at;
    if (!next || next === before) throw new Error('my_visits cursor');
    before = next;
  }
  return dates;
}

module.exports = {distanceHint,sendCheckin,checkinOutcome,fetchVisitDates};
