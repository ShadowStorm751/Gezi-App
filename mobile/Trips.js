import {c} from './theme';
import React from 'react';
import {Alert, Linking, Platform, Pressable, ScrollView, Text, View} from 'react-native';
import MapView, {Marker,Polyline} from 'react-native-maps';
import {lang,t} from './client';
import {PlaceThumbnail} from './PlaceMedia';
import {BadgeArt} from './Badges';
import {Action,Feedback,ui,useQuery} from './ScreenUI';

const modes = {walking:['🚶 Yürüyüş','🚶 Walking'],mixed:['🚶 Yürüyüş + toplu taşıma','🚶 Walk + transit'],ferry:['⛴ Vapur','⛴ Ferry'],driving:['🚗 Araç','🚗 Driving']};
function distance(m) {
  if (!Number.isFinite(m)) return '';
  return m < 1000 ? Math.round(m)+' m' : (m/1000).toLocaleString(lang,{maximumFractionDigits:1})+' km';
}
function duration(minutes) {
  const hours = Math.floor(minutes/60);
  return [hours && hours+' '+t('sa','hr'),minutes%60 && minutes%60+' '+t('dk','min')].filter(Boolean).join(' ');
}
function nextReason(row) {
  switch (row.reason) {
    case 'route': return t(row.reason_detail+' rotanın sıradaki durağı','Next stop on '+row.reason_detail);
    case 'badge': return t(row.reason_detail+' rozetine bir adım','One step towards '+row.reason_detail);
    case 'similar': return t('Sevdiğin türden bir yer','Similar to places you enjoy');
    case 'nearby': return t('Hemen yakınında','Near you');
    default: return t('Çok ziyaret edilen','Popular with explorers');
  }
}
function Thumb({row}) {
  return <PlaceThumbnail place={{thumbnail:row.thumb_url,category:row.category}}/>;
}
export function Recommendations({origin,userId,revision,onPlace,onRoute}) {
  const args = origin ? {lat:origin.latitude,lng:origin.longitude,lang,max_results:10} : {lang,max_results:10};
  const query = useQuery('recommendations',args,[userId,revision]);
  const feed = query.data;
  return <><Feedback query={query}/>
    {!!feed?.places.length && <><Text style={ui.heading}>{feed.personalized ? t('Sana önerilenler','Recommended for you') : t('Popüler yerler','Popular places')}</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={{gap:8}}>
        {feed.places.map(p => <Pressable key={p.place_id} accessibilityRole="button" onPress={() => onPlace(p)} style={[ui.card,{width:190}]}>
          <Thumb row={p}/><Text style={ui.label}>{p.name}</Text><Text>{nextReason(p)}</Text>
          {p.distance_m != null && <Text>{distance(p.distance_m)}</Text>}</Pressable>)}</ScrollView></>}
    {!!feed?.continue_routes.length && <><Text style={ui.heading}>{t('Yarım kalan rotaların','Continue your routes')}</Text>
      {feed.continue_routes.map(r => <Pressable key={r.slug} accessibilityRole="button" style={ui.card} onPress={() => onRoute(r.slug)}>
        <Text style={ui.label}>{r.title} · {r.visited_count}/{r.stop_count}</Text>
        {r.next_stop && <Text>{t('Sıradaki','Next')} · {r.next_stop.name} {distance(r.next_stop.distance_m)}</Text>}</Pressable>)}</>}
    {!!feed?.almost_badges.length && <><Text style={ui.heading}>{t('Rozete az kaldı','Badges within reach')}</Text>
      <ScrollView horizontal contentContainerStyle={{gap:8}}>{feed.almost_badges.map(b => <View style={[ui.card,{width:160}]} key={b.slug}>
        <BadgeArt badge={b}/><Text style={ui.label}>{b.name} · {b.progress}/{b.target}</Text>
        <View style={{height:5,backgroundColor:c.line}}><View style={{height:5,backgroundColor:c.primary,width:Math.min(100,100*b.progress/Math.max(1,b.target))+'%'}}/></View>
      </View>)}</ScrollView></>}
  </>;
}

export function Routes({city,revision,onRoute}) {
  const query = useQuery('list_routes',{city_slug:city,lang},revision);
  return <><Feedback query={query}/>{query.data?.length === 0 && <Text>{t('Bu şehirde henüz rota yok.','No routes in this city yet.')}</Text>}
    {query.data?.map(r => <Pressable style={ui.card} accessibilityRole="button" key={r.slug} onPress={() => onRoute(r.slug)}>
      <Thumb row={r}/><Text style={ui.heading}>{r.title}{r.completed ? ' ✓' : ''}</Text>
      <Text>{t(...(modes[r.travel_mode] || modes.walking))} · {duration(r.est_minutes)} · ~{distance(r.distance_m)}</Text>
      <Text>{r.visited_count != null ? r.visited_count+'/' : ''}{r.stop_count} {t('durak','stops')}</Text></Pressable>)}</>;
}
function directions(stop) {
  const coords = stop.latitude+','+stop.longitude;
  const url = Platform.OS === 'ios' ? 'https://maps.apple.com/?daddr='+coords : 'https://www.google.com/maps/dir/?api=1&destination='+coords;
  Linking.openURL(url).catch(() => Alert.alert(t('Haritalar açılamadı.','Could not open Maps.')));
}
export function RouteDetail({slug,revision,onPlace}) {
  const query = useQuery('route_detail',{route_slug:slug,lang},revision);
  const route = query.data;
  if (!route) return <><Feedback query={query}/>{!query.loading && !query.error && <Text>{t('Rota bulunamadı.','Route not found.')}</Text>}</>;
  const stops = [...route.stops].sort((a,b) => a.position-b.position);
  const points = stops.map(p => ({latitude:p.latitude,longitude:p.longitude}));
  const next = stops.find(p => !p.visited);
  return <><Text style={ui.title}>{route.title}</Text><Text>{route.summary}</Text>
    {!!points.length && <RouteMap key={slug} stops={stops} points={points} onPlace={onPlace}/>}
    {next && <Action onPress={() => directions(next)}>{t('Yol tarifi','Directions')} · {next.name}</Action>}
    {stops.map(p => <Action key={p.position} onPress={() => onPlace(p)}>{p.position}. {p.name}{p.visited ? ' ✓' : ''}</Action>)}</>;
}
function RouteMap({stops,points,onPlace}) {
  const map = React.useRef(null);
  return <MapView ref={map} style={ui.map} initialRegion={{...points[0],latitudeDelta:0.025,longitudeDelta:0.025}}
    onMapReady={() => points.length > 1 && map.current?.fitToCoordinates(points,{edgePadding:{top:35,left:35,bottom:35,right:35},animated:false})}>
    {points.length > 1 && <Polyline coordinates={points} strokeColor={c.accent} strokeWidth={3}/>}
    {stops.map((p,i) => <Marker key={p.position} coordinate={points[i]} title={p.name} onPress={() => onPlace(p)}>
      <View style={{borderRadius:15,padding:6,minWidth:28,backgroundColor:p.visited ? c.primary : c.accent}}>
        <Text style={{color:c.surfaceRaised,fontWeight:'700',textAlign:'center'}}>{p.position}</Text></View></Marker>)}</MapView>;
}
