import React,{useEffect,useState} from 'react';
import {Linking,StyleSheet,Text,View} from 'react-native';
import MapView,{Marker} from 'react-native-maps';
import {Check,ChevronRight,LocateFixed,MapPin} from 'lucide-react-native';
import Animated,{useAnimatedStyle,useReducedMotion,useSharedValue,withSequence,withSpring} from 'react-native-reanimated';
import {lang,t} from './client';
import {Press,Reveal} from './Motion';
import {matches} from './Explore';
import {Circle,Chips,Photo,SearchBox,eyebrow,km,meta,muted,row,title} from './PlaceUI';
import {c,type,radius,shadow} from './theme';

function Pin({place,active,visited,onSelect}) {
  const p=useSharedValue(1),reduce=useReducedMotion();
  useEffect(()=>{p.value=active&&!reduce?withSequence(withSpring(1.25,{damping:12,stiffness:180}),withSpring(1,{damping:12,stiffness:180})):1;},[active,reduce,p]);
  const motion=useAnimatedStyle(()=>({transform:[{scale:p.value}]}));
  const size=active?42:visited?30:22;
  return <Marker coordinate={place.coordinate} zIndex={active?100:visited?2:1} anchor={{x:.5,y:.5}} accessibilityLabel={[place.name,visited?t('Gezildi','Visited'):''].filter(Boolean).join(', ')} onPress={e=>{e.stopPropagation();onSelect();}}>
    <View style={{width:54,height:54,alignItems:'center',justifyContent:'center'}}><Animated.View style={[{width:size,height:size,borderRadius:size/2,backgroundColor:visited&&!active?c.primary:c.accent,borderWidth:3,borderColor:c.surfaceRaised,justifyContent:'center',alignItems:'center',...shadow.pin},motion]}>
    {active?<MapPin size={20} color={c.onAccent}/>:visited?<Check size={16} color={c.onPrimary}/>:null}</Animated.View></View></Marker>;
}
export default function PlaceMap({places,mapRef,center,origin,visited,onLocation,onSuggest,onOpen,message}) {
  const [q,setQ]=useState(''),[filter,setFilter]=useState('all'),[id,setId]=useState(null);
  const items=places.filter(p=>matches(p,q)&&(filter==='all'||(filter==='new'?!visited(p.id):p.kind===filter)));
  const selected=items.find(p=>p.id===id);
  const chips=[['all',t('Tümü','All')],['new',t('Gezilmedi','Unvisited')],['historical',t('Tarihi','Historic')],['nature',t('Doğa','Nature')]];
  return <View style={{flex:1}}><MapView ref={mapRef} style={StyleSheet.absoluteFill} initialRegion={{...center,latitudeDelta:.028,longitudeDelta:.028}} showsUserLocation={!!origin} showsMyLocationButton={false} toolbarEnabled={false} onLongPress={onSuggest?e=>onSuggest(e.nativeEvent.coordinate):undefined} onPress={e=>{if(!e.nativeEvent.action)setId(null);}}>
    {items.map(p=><Pin key={p.id} place={p} active={p.id===id} visited={visited(p.id)} onSelect={()=>setId(p.id)}/>)}</MapView>
    <View style={{position:'absolute',top:12,left:16,right:16,gap:10}}><SearchBox floating value={q} onChangeText={v=>{setQ(v);const found=v.trim()&&places.find(p=>matches(p,v));if(found){setId(found.id);mapRef.current?.animateCamera({center:found.coordinate},{duration:250});}}} label={t('Haritada ara','Search map')}/><Chips items={chips} value={filter} onChange={setFilter}/></View>
    <View pointerEvents="box-none" style={{position:'absolute',bottom:14,left:12,right:12,gap:12}}>
      {!!message && <Text style={{...type.caption,color:c.ink,backgroundColor:c.surface}}>{message}</Text>}
      <View pointerEvents="box-none" style={[row,{alignItems:'flex-end',justifyContent:'space-between'}]}><Text accessibilityRole="link" onPress={()=>Linking.openURL('https://www.openstreetmap.org/copyright').catch(()=>{})} style={{...type.caption,color:c.inkMuted,backgroundColor:c.surface,borderRadius:5,paddingHorizontal:6}}>{t('© OpenStreetMap katkıcıları','© OpenStreetMap contributors')}</Text><Circle size={48} icon={LocateFixed} label={t('Konumuma git','Go to my location')} onPress={onLocation}/></View>
      {selected && <Reveal key={id} duration={320} offset={110}><Press accessibilityRole="button" onPress={()=>onOpen(selected)} style={[row,{padding:12,borderRadius:radius.lg,backgroundColor:c.surfaceRaised,...shadow.card}]}>
        <Photo place={selected} credit style={{width:76,height:76,borderRadius:12}}/><View style={{flex:1,gap:4}}><Text numberOfLines={1} style={eyebrow}>{[meta(selected),origin&&km(selected.distance)].filter(Boolean).join(' · ')}</Text><Text numberOfLines={2} style={title}>{selected.name}</Text><Text numberOfLines={1} style={muted}>{selected.description}</Text></View><ChevronRight color={c.primary} size={20}/></Press></Reveal>}
    </View></View>;
}
