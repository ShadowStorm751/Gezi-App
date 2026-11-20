export type Lang = 'tr' | 'en';
type PackPlace = {
  id: string; slug: string; name: string; kind: 'historical' | 'nature'; category: string;
  district?: string; period?: string | null; period_code?: string | null;
  latitude: number; longitude: number; short_desc: string | null; checkin_radius_m?: number; has_area?: boolean; thumb_url?: string | null;
};
export type Pack = {city:string; name:string; version:string|null; places:PackPlace[]};
type Store = {getItem(key:string): Promise<string|null>; setItem(key:string,value:string):Promise<void>};
type Rpc = (name:string, args:Record<string,string|number|null>) => PromiseLike<{data:unknown; error:unknown}>;

function validPack(value: unknown, city:string): value is Pack {
  const p = value as Partial<Pack> | null;
  return p?.city === city && Array.isArray(p.places) &&
    (typeof p.version === 'string' || (p.version === null && !p.places.length)) &&
    p.places.every(row => row && typeof row.id === 'string' && typeof row.name === 'string' &&
      typeof row.category === 'string' && Number.isFinite(row.latitude) && Math.abs(row.latitude) <= 90 &&
      Number.isFinite(row.longitude) && Math.abs(row.longitude) <= 180);
}

export async function loadCity(rpc:Rpc, store:Store, project:string, lang:Lang, showCached:(p:Pack)=>void, city = 'istanbul') {
  const key = 'gezi:city:v1:' + project + ':' + city + ':' + lang;
  let cached: Pack | null = null;
  try {
    const stored = await store.getItem(key);
    const parsed = stored ? JSON.parse(stored) : null;
    if (validPack(parsed,city)) cached = parsed;
  } catch { /* An unreadable cache can be rebuilt from the service. */ }
  if (cached) showCached(cached);
  const {data,error} = await rpc('city_pack',{city_slug:city,lang});
  if (error || !validPack(data,city)) throw new Error('city_pack');
  if (!cached || cached.version !== data.version || JSON.stringify(cached.places) !== JSON.stringify(data.places)) {
    try { await store.setItem(key, JSON.stringify(data)); } catch { /* In-memory use still works. */ }
  }
  return data;
}

export const categoryNames:Record<string,[string,string]> = {
  mosque:['Cami','Mosque'], church:['Kilise','Church'], synagogue:['Sinagog','Synagogue'], tomb:['Türbe','Tomb'],
  palace:['Saray','Palace'], museum:['Müze','Museum'], fortress:['Kale','Fortress'], tower:['Kule','Tower'],
  cistern:['Sarnıç','Cistern'], monument:['Anıt','Monument'], archaeological_site:['Ören yeri','Archaeological site'],
  viewpoint:['Seyir noktası','Viewpoint'], hill:['Tepe','Hill'], forest:['Orman','Forest'], park:['Park','Park'],
  beach:['Plaj','Beach'], island:['Ada','Island'], waterfall:['Şelale','Waterfall']
};
export function mapPlace(row:PackPlace, lang:Lang) {
  const categoryLabel = categoryNames[row.category]?.[lang === 'en' ? 1 : 0] ?? row.category;
  return {id:row.id, name:row.name, kind:row.kind, category:row.category, categoryLabel, description:row.short_desc,
    district:row.district,period:row.period,periodCode:row.period_code,
    radius:row.checkin_radius_m, hasArea:row.has_area,
    thumbnail: webUrl(row.thumb_url), coordinate:{latitude:row.latitude,longitude:row.longitude}};
}

// Yakınlık sorgusu dönem ve check-in alanlarını içermeyebilir.
export function mergeNearbyPlace<T extends ReturnType<typeof mapPlace>>(nearby:T, packed?:ReturnType<typeof mapPlace>) {
  return {
    ...nearby,
    period: nearby.period === undefined ? packed?.period : nearby.period,
    periodCode: nearby.periodCode === undefined ? packed?.periodCode : nearby.periodCode,
    thumbnail: nearby.thumbnail ?? packed?.thumbnail,
    radius: packed?.radius ?? nearby.radius,
    hasArea: packed?.hasArea ?? nearby.hasArea,
  };
}

export function webUrl(value:unknown): string | null {
  return typeof value === 'string' && /^https?:\/\//i.test(value) ? value : null;
}

type PlacePhoto = {
  url?:string | null; thumb_url?:string | null; storage_path?:string | null;
  author:string; license:string; license_url?:string | null; source_url?:string | null;
};

function creditedPhoto(photo:PlacePhoto) {
  return photo && typeof photo.author === 'string' && photo.author.trim() &&
    typeof photo.license === 'string' && photo.license.trim() &&
    (webUrl(photo.url) || webUrl(photo.thumb_url) || photo.storage_path);
}

export async function loadNearby(rpc:Rpc, origin:{latitude:number;longitude:number}, lang:Lang) {
  const {data,error} = await rpc('nearby_places',{lat:origin.latitude,lng:origin.longitude,
    radius_m:2000,kinds:null,lang,max_results:100});
  if (error || !Array.isArray(data)) throw new Error('nearby_places');
  return data.map(row => {
    if (!row || typeof row.id !== 'string' || typeof row.name !== 'string' || typeof row.category !== 'string' ||
      !Number.isFinite(row.latitude) || !Number.isFinite(row.longitude) || !Number.isFinite(row.distance_m)) throw new Error('nearby_places');
    return {...mapPlace(row,lang), distance:row.distance_m, bearing:row.bearing_deg, visited:row.visited};
  });
}

export async function loadDetail(rpc:Rpc, id:string, lang:Lang) {
  const {data,error} = await rpc('place_detail',{place_id:id, lang});
  if (error) throw new Error('place_detail');
  if (data === null) return null;
  const d = data as {id:string; name:string; category_name:string; period:string|null;
    period_code?:string;built_year?:number;rating?:{average:number|null;count:number};visited_at?:string;has_area?:boolean;checkin_radius_m?:number;
    long_desc:string|null; short_desc:string|null; best_time:string|null; photos?:PlacePhoto[]};
  if (!d || d.id !== id || typeof d.name !== 'string' || typeof d.category_name !== 'string') throw new Error('place_detail');
  return {name:d.name,category:d.category_name,period:d.period,description:d.long_desc || d.short_desc,bestTime:d.best_time,
    periodCode:d.period_code,builtYear:d.built_year,rating:d.rating,visitedAt:d.visited_at,
    ...(d.has_area!=null?{hasArea:d.has_area}:{}),...(d.checkin_radius_m!=null?{radius:d.checkin_radius_m}:{}),
    photos:Array.isArray(d.photos) ? d.photos.filter(creditedPhoto) : []};
}
