import React,{useEffect,useState} from 'react';
import {ScrollView,Text,View} from 'react-native';
import {Camera} from 'lucide-react-native';
import {client,lang,t} from './client';
import {Action,Feedback,useQuery} from './ScreenUI';
import {categoryNames,mapPlace} from './catalog';
import {Press,Reveal,Skeleton} from './Motion';
import {Chips,Circle,PlaceCard,PlaceRow,SearchBox,eyebrow,heading,muted,row,upper} from './PlaceUI';
import {c,type} from './theme';

export function matches(place,q) {
  const fold=s=>(s||'').toLocaleLowerCase(lang).normalize('NFD').replace(/[\u0300-\u036f]/g,'').replace(/ı/g,'i');
  return fold([place.name,place.categoryLabel,place.district,place.description].filter(Boolean).join(' ')).includes(fold(q.trim()));
}
export default function Explore({places,nearby,city,cities,onCity,origin,permission,onLocation,onDemo,onCamera,onPlace,onRoute,visited,revision,userId,state,onRetry,message,loading}) {
  const [term,setTerm]=useState(''),[q,setQ]=useState(''),[category,setCategory]=useState('all'),[all,setAll]=useState(false);
  useEffect(()=>{const timer=setTimeout(()=>setQ(term.trim()),220);return ()=>clearTimeout(timer);},[term]);
  const feed=useQuery('recommendations',{lang,max_results:20,...(origin?{lat:origin.latitude,lng:origin.longitude}:{})},[city.slug,userId,revision]);
  const search=useQuery(q.length>=2?'search_places':null,{q,lang,max_results:60},city.slug);
  const routes=useQuery(q?'list_routes':null,{city_slug:city.slug,lang},userId);
  const byId=new Map(places.map(p=>[p.id,p]));
  const accept=p=>category==='all'||p.category===category||p.kind===category;
  const local=places.filter(p=>matches(p,q));
  const results=new Map((search.data||[]).filter(p=>byId.has(p.id)).map(p=>[p.id,byId.get(p.id)]));
  local.forEach(p=>results.set(p.id,p));
  const recs=(feed.data?.places||[]).filter(p=>byId.has(p.place_id)).map(p=>({...byId.get(p.place_id),distance:p.distance_m}));
  const cards=(client?recs:places).filter(accept);
  const visible=(q?[...results.values()]:nearby).filter(accept);
  const categories=[['all',t('Tümü','All')],['mosque',t('Camiler','Mosques')],['palace',t('Saraylar','Palaces')],['museum',t('Müzeler','Museums')],['nature',t('Doğa','Nature')]];
  for(const p of places) if(p.category && !categories.some(([id])=>id===p.category)) categories.push([p.category,p.categoryLabel||p.category]);
  const caption={demo:t('Galata örnek kataloğu','Galata sample catalog'),cached:t('Kayıtlı katalog güncelleniyor.','Refreshing saved places.'),offline:t('Kayıtlı katalog gösteriliyor.','Showing saved places.'),error:t('Şehir kataloğu alınamadı.','City catalog unavailable.'),config:t('Supabase bağlantısı yapılandırılmalı.','Supabase connection required.')};
  return <ScrollView keyboardShouldPersistTaps="handled" contentContainerStyle={{padding:20,gap:16,paddingBottom:32}}>
    <View style={[row,{justifyContent:'space-between'}]}><View><Text style={eyebrow}>{upper([city.name,origin&&nearby[0]?.district].filter(Boolean).join(' · '))}</Text><Text style={{...type.display,color:c.ink}}>{t('Keşfet','Explore')}</Text></View><Circle accent size={52} icon={Camera} label={t('Kamerayla keşfet','Explore with camera')} onPress={onCamera}/></View>
    <Feedback query={cities}/>{cities.data?.length>1 && <Chips items={cities.data.map(p=>[p.slug,p.name])} value={city.slug} onChange={slug=>onCity(cities.data.find(p=>p.slug===slug))}/>}
    <SearchBox label={t('Yer, semt ya da rota ara','Search places, districts or routes')} value={term} onChangeText={setTerm}/>
    <Chips items={categories} value={category} onChange={setCategory}/>
    {!q && <><Feedback query={feed}/>{cards.length>0 && <><View style={[row,{justifyContent:'space-between'}]}><Text style={heading}>{t('Sana önerilenler','Recommended for you')}</Text><Press accessibilityRole="button" onPress={()=>setAll(!all)}><Text style={{...type.label,color:c.primary}}>{all?t('Daha az','Show less'):t('Tümü','See all')}</Text></Press></View>
    {all?cards.map(p=><PlaceRow key={p.id} place={p} visited={visited(p.id)} onPress={()=>onPlace(p)}/>):<ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={{gap:12,paddingBottom:8}}>{cards.map(p=><PlaceCard key={p.id} place={p} onPress={()=>onPlace(p)}/>)}</ScrollView>}</>}</>}
    <View style={[row,{justifyContent:'space-between'}]}><Text style={heading}>{q?t('Arama sonuçları','Search results'):t('Yakındakiler','Nearby')}</Text>{!q && <Text style={{...type.caption,color:c.inkMuted}}>{origin?t('Kuş uçuşu','Straight-line'):t('Şehir merkezinden','From city center')}</Text>}</View>
    {permission!==true && <Action selected disabled={loading} onPress={onLocation}>{t('Konumumu kullan','Use my location')}</Action>}
    {!!message && <Text style={muted}>{message}</Text>}
    {state==='loading' && <Skeleton/>}{!!caption[state] && <Text style={muted}>{caption[state]}</Text>}
    {['error','offline'].includes(state) && <Action onPress={onRetry}>{t('Tekrar dene','Retry')}</Action>}
    {q.length>=2 && <Feedback query={search}/>}
    <View>{visible.map((p,i)=><Reveal key={p.id} delay={i<6?i*40:0}><PlaceRow place={p} visited={visited(p.id)} onPress={()=>onPlace(p)}/></Reveal>)}</View>
    {!visible.length && !search.loading && state!=='loading' && <Text style={muted}>{q?t('Eşleşen yer yok.','No matching places.'):t('Bu filtreyle 2 km içinde yer bulunamadı.','No matching places within 2 km.')}</Text>}
    {q && (routes.data||[]).filter(r=>matches({name:r.title,description:r.summary},q)).map(r=><Action key={r.slug} onPress={()=>onRoute(r.slug)}>{r.title}</Action>) || null}
    {!q && (feed.data?.continue_routes||[]).map(r=><Action key={r.slug} onPress={()=>onRoute(r.slug)}>{r.title} · {r.visited_count}/{r.stop_count}</Action>)}
    {!q && (feed.data?.almost_badges||[]).map(b=><Text key={b.slug} style={muted}>{b.name} · {b.progress}/{b.target}</Text>)}
    {permission===false && <Action onPress={onDemo}>{t("Galata’yı evden dene",'Try Galata from home')}</Action>}
  </ScrollView>;
}
