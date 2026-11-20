import React from 'react';
import {Alert, Linking, Platform, StyleSheet, Text, View} from 'react-native';
import MapView, {Marker,Polyline} from 'react-native-maps';
import {Check, ChevronRight, Clock, Footprints, Route, Ship, TrainFront, Car} from 'lucide-react-native';
import {client,lang,t} from './client';
import {Photo, eyebrow, heading, km, muted, upper} from './PlaceUI';
import {Action,Feedback,ui,useQuery} from './ScreenUI';
import {Press,Reveal} from './Motion';
import {sampleRoute} from './guestPreview';
import {c,radius,shadow,space,type} from './theme';

const modes = {
  walking:[Footprints,t('Yürüyüş','Walking')], mixed:[TrainFront,t('Yürüyüş + toplu taşıma','Walk + transit')],
  ferry:[Ship,t('Vapur','Ferry')], driving:[Car,t('Araç','Driving')],
};
function duration(minutes) {
  const hours = Math.floor(minutes/60);
  return [hours && hours+' '+t('sa','hr'),minutes%60 && minutes%60+' '+t('dk','min')].filter(Boolean).join(' ');
}
function RouteCard({route, featured, onPress}) {
  const [Icon,mode] = modes[route.travel_mode] || modes.walking;
  const count = route.visited_count == null || route.visited_count === 0
    ? route.stop_count : route.visited_count+' / '+route.stop_count;
  const timing = duration(route.est_minutes);
  const distance = km(route.distance_m);
  return <Press accessibilityRole="button" onPress={onPress} style={featured ? styles.coverCard : styles.listRow}>
    <Photo place={{name:route.title,thumbnail:route.thumb_url,kind:route.kind}} credit
      style={featured ? styles.cover : styles.thumb}/>
    <View style={featured ? styles.coverCopy : styles.rowCopy}>
      <View style={styles.meta}><Icon size={15} color={c.primary}/><Text style={eyebrow}>{upper(mode)}</Text></View>
      <Text style={featured ? styles.title : styles.name}>{route.title}</Text>
      {featured && !!route.summary && <Text numberOfLines={2} style={muted}>{route.summary}</Text>}
      <View style={styles.meta}><Route size={15} color={c.inkMuted}/>
        <Text style={styles.caption}>{count} {t('durak','stops')}</Text>
        {!!timing && <><Clock size={14} color={c.inkMuted}/><Text style={styles.caption}>{timing}</Text></>}
        {!!distance && <Text style={styles.caption}>· ~{distance}</Text>}
      </View>
      {route.completed && <View style={styles.meta}><Check size={15} color={c.primary}/>
        <Text style={styles.complete}>{t('Tamamlandı','Completed')}</Text></View>}
    </View>
    {!featured && <ChevronRight size={18} color={c.primary}/>}
  </Press>;
}
export function Routes({city,userId,visitRevision,onRoute}) {
  const query = useQuery('list_routes',{city_slug:city,lang},[userId,visitRevision]);
  if (!userId && !query.data?.length) return <>
    {!!query.error && <Feedback query={query}/>}
    {query.data && <Text style={muted}>{t('Bu şehirde henüz rota yok.','No routes in this city yet.')}</Text>}
    <Text style={heading}>{t('Örnek rota · İstanbul','Sample route · Istanbul')}</Text>
    <RouteCard featured route={sampleRoute} onPress={()=>onRoute(sampleRoute.slug)}/>
  </>;
  if (!client) return <Text style={muted}>{t('Rotaları görmek için bağlantı gerekli.','Connect to view routes.')}</Text>;
  if (!query.data) return <Feedback query={query}/>;
  if (!query.data.length) return <Text style={muted}>{t('Bu şehirde henüz rota yok.','No routes in this city yet.')}</Text>;
  const routes=query.data;
  const featured=routes.find(r=>r.visited_count>0 && !r.completed) || routes[0];
  const others=routes.filter(r=>r.slug!==featured.slug);
  return <>
    {featured.visited_count>0 && !featured.completed && <Text style={heading}>{t('Kaldığın yerden','Continue your route')}</Text>}
    <Reveal><RouteCard featured route={featured} onPress={()=>onRoute(featured.slug)}/></Reveal>
    {!!others.length && <View><Text style={heading}>{t('Diğer rotalar','More routes')}</Text>
      {others.map((r,index)=>{
        const card=<RouteCard key={r.slug} route={r} onPress={()=>onRoute(r.slug)}/>;
        return index<5 ? <Reveal key={r.slug} delay={(index+1)*40}>{card}</Reveal> : card;
      })}
    </View>}
  </>;
}

const styles = StyleSheet.create({
  coverCard:{backgroundColor:c.surfaceRaised,borderRadius:radius.lg,...shadow.card},
  cover:{width:'100%',height:174,borderTopLeftRadius:radius.lg,borderTopRightRadius:radius.lg},
  coverCopy:{padding:space[4],gap:space[2]},
  rowCopy:{flex:1,gap:space[1]},
  title:{...type.title,color:c.ink}, name:{...type.cardTitle,color:c.ink},
  listRow:{flexDirection:'row',alignItems:'center',gap:space[3],paddingVertical:space[4],borderBottomColor:c.line,borderBottomWidth:1},
  thumb:{width:76,height:80,borderRadius:radius.md},
  meta:{flexDirection:'row',alignItems:'center',flexWrap:'wrap',columnGap:6,rowGap:4},
  caption:{...type.caption,color:c.inkMuted},complete:{...type.caption,color:c.primary},
});
function directions(stop) {
  const coords = stop.latitude+','+stop.longitude;
  const url = Platform.OS === 'ios' ? 'https://maps.apple.com/?daddr='+coords : 'https://www.google.com/maps/dir/?api=1&destination='+coords;
  Linking.openURL(url).catch(() => Alert.alert(t('Haritalar açılamadı.','Could not open Maps.')));
}
export function RouteDetail({slug,revision,onPlace}) {
  const preview=slug === sampleRoute.slug;
  const query = useQuery(preview ? null : 'route_detail',{route_slug:slug,lang},revision);
  const route = preview ? sampleRoute : query.data;
  const openStop = preview ? stop=>Alert.alert(stop.name,stop.description) : onPlace;
  if (!route) return <><Feedback query={query}/>{!query.loading && !query.error && <Text>{t('Rota bulunamadı.','Route not found.')}</Text>}</>;
  const stops = [...route.stops].sort((a,b) => a.position-b.position);
  const points = stops.map(p => ({latitude:p.latitude,longitude:p.longitude}));
  const next = stops.find(p => !p.visited);
  return <>{preview && <Text style={eyebrow}>{t('Örnek rota · İstanbul','Sample route · Istanbul')}</Text>}<Text style={ui.title}>{route.title}</Text><Text>{route.summary}</Text>
    {!!points.length && <RouteMap key={slug} stops={stops} points={points} onPlace={openStop}/>}
    {next && <Action onPress={() => directions(next)}>{t('Yol tarifi','Directions')} · {next.name}</Action>}
    {stops.map(p => <Action key={p.position} onPress={() => openStop(p)}>{p.position}. {p.name}{p.visited ? ' ✓' : ''}</Action>)}</>;
}
function RouteMap({stops,points,onPlace}) {
  const map = React.useRef(null);
  const offsets=points.map((p,i)=>{const cluster=points.map((point,index)=>({point,index})).filter(({point})=>Math.hypot((point.latitude-p.latitude)*111000,(point.longitude-p.longitude)*84000)<55);const pos=cluster.findIndex(({index})=>index===i);const angle=2*Math.PI*pos/cluster.length;return cluster.length>1?{x:18*Math.cos(angle),y:18*Math.sin(angle)}:{x:0,y:0};});
  return <MapView ref={map} style={ui.map} initialRegion={{...points[0],latitudeDelta:0.025,longitudeDelta:0.025}}
    onMapReady={() => points.length > 1 && map.current?.fitToCoordinates(points,{edgePadding:{top:35,left:35,bottom:35,right:35},animated:false})}>
    {points.length > 1 && <Polyline coordinates={points} strokeColor={c.accent} strokeWidth={3}/>}
    {stops.map((p,i) => <Marker key={p.position} coordinate={points[i]} centerOffset={offsets[i]} anchor={{x:.5-offsets[i].x/40,y:.5-offsets[i].y/40}} title={p.name} onPress={() => onPlace(p)}>
      <View style={{borderRadius:15,padding:6,minWidth:28,backgroundColor:p.visited ? c.primary : c.accent}}>
        <Text style={{color:c.surfaceRaised,fontWeight:'700',textAlign:'center'}}>{p.position}</Text></View></Marker>)}</MapView>;
}
