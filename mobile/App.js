import PlaceDetail from './PlaceDetail';
import Explore from './Explore';
import {c,type,shadow} from './theme';
import {Camera} from 'lucide-react-native';
import MainTabs from './MainTabs';
import {Press} from './Motion';
import React, {useEffect, useRef, useState} from 'react';
import {
  ActivityIndicator, Alert, Linking, Modal, Platform, Pressable,
  ScrollView, StatusBar, StyleSheet, Text, View
} from 'react-native';
import MapView, {Marker} from 'react-native-maps';
import {SafeAreaView} from 'react-native-safe-area-context';
import * as Location from 'expo-location';
import sample from './places.json';
import {AsyncStorage, client, demo, lang, project, t} from './client';
import {loadCity, loadDetail, loadNearby, mapPlace} from './catalog';
import DiscoveryCamera from './DiscoveryCamera';
import {PlaceGallery, PlaceThumbnail} from './PlaceMedia';
import {Collection,BadgeArt, Login} from './Badges';
import {Action,Feedback,ui,useQuery} from './ScreenUI';
import Friends from './Friends';
import Profile from './Profile';
import {ContributionForm} from './Contributions';
import {Recommendations,Routes,RouteDetail} from './Trips';
import CheckIn from './CheckInPanel';
import useVisits from './useVisits';
import {distanceMeters,galataPreviewOrigin} from './geo';

const paper = c.surface;
const ink = c.ink;
const red = c.accent;
const serif = Platform.select({ios:'Georgia', android:'serif'});
const pilot = {latitude:41.0266, longitude:28.9736};
const region = {...pilot, latitudeDelta:0.009, longitudeDelta:0.009};
const demoPlaces = lang === 'tr' ? sample : sample.map((p,i) => ({...p,
  name:i ? 'Galata Mevlevi Museum' : 'Galata Tower',category:i ? 'Museum' : 'Tower',
  period:i ? 'Ottoman period' : 'Genoese period',
  description:i ? 'Explore the Mevlevi heritage of Beyoğlu on Galip Dede Street.' : 'Built by the Genoese in the 14th century, the tower once formed part of the Galata walls.'}));
const rpc = (name, args) => client.rpc(name, args);

function formatDistance(meters) {
  return meters < 1000 ? Math.round(meters) + ' m' :
    (meters / 1000).toLocaleString(lang, {maximumFractionDigits:1}) + ' km';
}

export default function App() {
  const map = useRef(null);
  const visits = useVisits();
  const [citySlug,setCitySlug] = useState('istanbul');
  const cities = useQuery(client ? 'list_cities' : null,{lang},visits.userId);
  const city = cities.data?.find(item => item.slug === citySlug);
  const center = city?.center ? {latitude:city.center.lat,longitude:city.center.lng} : pilot;
  const [screen,setScreen] = useState('home');
  const [routeSlug,setRouteSlug] = useState(null);
  const [routeBack,setRouteBack] = useState('routes');
  const [suggestPin,setSuggestPin] = useState(null);
  const [reporting,setReporting] = useState(false);
  const locationRequest = useRef(0);
  const [celebration,setCelebration] = useState(null);
  const award = celebration?.userId === visits.userId ? celebration?.awards[0] : null;
  const [origin, setOrigin] = useState(null);
  const [loading, setLoading] = useState(false);
  const [detail, setDetail] = useState(null);
  const [cameraMode, setCameraMode] = useState(null);
  const cameraOpen = !!cameraMode;
  const galataPreview = cameraMode === 'galata';
  const tab=useRef('explore');
  const [permission,setPermission]=useState(null);
  useEffect(()=>{Location.getForegroundPermissionsAsync().then(access=>{setPermission(access.granted);if(access.granted) useLocation(false);}).catch(()=>{});},[]);
  const [trackedId, setTrackedId] = useState(null);
  const [trackedPlace,setTrackedPlace] = useState(null);
  const [locationMessage, setLocationMessage] = useState('');
  const [packPlaces,setPlaces] = useState(demo ? demoPlaces : []);
  const [nearbyResponse,setNearbyResponse] = useState(null);
  const serverNearby = nearbyResponse?.places ?? null;
  const [catalogState,setCatalogState] = useState(demo ? 'demo' : 'loading');
  const [refresh,setRefresh] = useState(0);
  const [detailState,setDetailState] = useState('');
  const detailToken = useRef(0);
  useEffect(() => {
    if (cities.data?.length && !cities.data.some(c => c.slug === citySlug)) chooseCity(cities.data[0]);
  },[cities.data,citySlug]);
  useEffect(() => {
    if (demo) return;
    if (!client) { setCatalogState('config'); return; }
    let active = true;
    let hasCache = false;
    setCatalogState('loading');
    loadCity(rpc,AsyncStorage,project,lang,pack => {
      if (!active) return;
      hasCache = true;
      setPlaces(pack.places.map(row => mapPlace(row,lang)));
      setCatalogState('cached');
    },citySlug).then(pack => {
      if (active) { setPlaces(pack.places.map(row => mapPlace(row,lang))); setCatalogState('ready'); }
    }).catch(() => { if (active) setCatalogState(hasCache ? 'offline' : 'error'); });
    return () => { active = false; };
  }, [refresh,citySlug]);
  const byId = new Map(packPlaces.map(p => [p.id,p]));
  serverNearby?.forEach(p => {
    const packed = byId.get(p.id);
    byId.set(p.id,{...p,thumbnail:p.thumbnail ?? packed?.thumbnail, radius:packed?.radius,hasArea:packed?.hasArea});
  });
  function wasVisited(id) {
    return !!visits.userId && (Object.prototype.hasOwnProperty.call(visits.dates,id) ||
      (nearbyResponse?.userId === visits.userId && byId.get(id)?.visited === true));
  }
  const places = Array.from(byId.values());
  const nearby = places.map(place => ({
    ...place, distance: distanceMeters(origin ?? center, place.coordinate)
  })).sort((a,b) => a.distance - b.distance);
  const listPlaces = serverNearby?.map(p => byId.get(p.id)) ?? nearby.filter(p => p.distance <= 2000);

  async function useLocation(ask=true) {
    const request = ++locationRequest.current;
    setLoading(true);
    setNearbyResponse(null);
    try {
      const permission = ask ? await Location.requestForegroundPermissionsAsync() : await Location.getForegroundPermissionsAsync();
      if (request !== locationRequest.current) return;
      setPermission(permission.granted);
      if (!permission.granted) {
        setOrigin(null);
        setLocationMessage(t("Konum izni kapalı. Örnek konumu kullanıyorsun.","Location access is off. Using the sample location."));
        return;
      }
      const fix = await Location.getCurrentPositionAsync({accuracy:Location.Accuracy.Balanced});
      if (request !== locationRequest.current) return;
      setOrigin(fix.coords);
      map.current?.animateCamera({center:{latitude:fix.coords.latitude,longitude:fix.coords.longitude}}, {duration:300});
      setLocationMessage('');
      if (client) {
        const userId = visits.owner.current;
        try {
          const found = await loadNearby(rpc,fix.coords,lang);
          if (request === locationRequest.current) setNearbyResponse({userId,places:found});
        }
        catch { if (request === locationRequest.current) setLocationMessage(t('Yakındaki yerler güncellenemedi. Mevcut katalog kullanılıyor.',
          'Nearby places could not be refreshed. Using the current catalog.')); }
      }
    } catch {
      if (request !== locationRequest.current) return;
      setOrigin(null);
      setLocationMessage(t("Konum alınamadı. Örnek konumu kullanıyorsun.","Location unavailable. Using the sample location."));
    } finally {
      if (request === locationRequest.current) setLoading(false);
    }
  }

  function closeDetail() {
    setReporting(false);
    detailToken.current++;
    setCelebration(null);
    setDetail(null);
  }

  function nextAward() {
    setCelebration(current => current?.awards.length > 1 ? {...current,awards:current.awards.slice(1)} : null);
  }
  async function openPlace(place) {
    setReporting(false);
    const token = ++detailToken.current;
    if (!cameraOpen) map.current?.animateCamera({center:place.coordinate}, {duration:300});
    setDetail(place);
    setDetailState('');
    if (galataPreview || demo || !client) return;
    setDetailState('loading');
    try {
      const detailUser = visits.owner.current;
      const info = await loadDetail(rpc,place.id,lang);
      if (detailToken.current !== token) return;
      if (info) setDetail({...place,...info,detailUser,category:place.category,categoryLabel:info.category});
      setDetailState(info ? '' : 'missing');
    } catch { if (detailToken.current === token) setDetailState('error'); }
  }

  function openOfficialPage(url) {
    Linking.openURL(url).catch(() => Alert.alert(t("Ziyaret sayfası açılamadı","Could not open visitor information"), t("Bağlantını kontrol edip tekrar dene.","Check your connection and try again.")));
  }

  function showStop(row) {
    const place = byId.get(row.place_id) || mapPlace({...row,id:row.place_id},lang);
    openPlace({...place,distance:distanceMeters(origin ?? center,place.coordinate)});
  }
  function tryGalata() {
    setTrackedId('galata-kulesi');
    setCameraMode('galata');
  }
  function openRoute(slug,back) {
    setRouteSlug(slug);
    setRouteBack(back);
    setScreen('route');
  }
  function chooseCity(next) {
    if (next.slug === citySlug) return;
    locationRequest.current++;
    setLoading(false);
    setLocationMessage('');
    setOrigin(null);
    setNearbyResponse(null);
    setPlaces([]);
    setTrackedId(null);
    setCitySlug(next.slug);
  }
  function suggest(pin) {
    setSuggestPin(pin);
    setScreen('suggest');
  }
  const pageTitle = {profile:t('Profil','Profile'),friends:t('Arkadaşlar','Friends'),routes:t('Rotalar','Routes'),
    route:t('Rota','Route'),suggest:t('Yer öner','Suggest a place')};

  return (
    <SafeAreaView style={styles.page}>
      <StatusBar barStyle="dark-content"/>
      {cameraOpen ? <DiscoveryCamera key={cameraMode} previewOrigin={galataPreview ? galataPreviewOrigin : null} onTryDemo={tryGalata}
        places={galataPreview ? demoPlaces : trackedPlace?.id === trackedId && !byId.has(trackedId) ? [...places,trackedPlace] : places} trackedId={trackedId}
        onStopTracking={() => setTrackedId(null)} onSelect={openPlace}
        onBack={() => { setCameraMode(null); setTrackedId(null); }}/> : screen !== 'home' ? <>
      <View style={{paddingHorizontal:16,paddingTop:8}}><Action onPress={()=>setScreen('home')}>{t('‹ Geri','‹ Back')}</Action></View>
      <ScrollView key={screen+':'+(visits.userId || '')} contentContainerStyle={ui.content} keyboardShouldPersistTaps="handled">
        {screen==='route' && <RouteDetail slug={routeSlug} revision={[visits.userId,visits.revision]} onPlace={showStop}/>}
        {screen==='friends' && (visits.userId?<Friends onProfile={()=>setScreen('home')}/>:<Login/>)}
        {screen==='suggest' && <ContributionForm coordinate={suggestPin} userId={visits.userId} onClose={()=>setScreen('home')}/>}
      </ScrollView></> : <MainTabs initial={tab.current} onTab={name=>{tab.current=name;}} pages={{
        explore:<Explore places={nearby.map(p=>({...p,distance:origin?p.distance:null}))} nearby={listPlaces} city={city||{slug:citySlug,name:citySlug==='istanbul'?'İstanbul':citySlug}} cities={cities} onCity={chooseCity} origin={origin} permission={permission} onLocation={()=>useLocation()} onDemo={tryGalata} onCamera={()=>setCameraMode('live')} onPlace={openPlace} onRoute={slug=>openRoute(slug,'home')} visited={wasVisited} revision={visits.revision} userId={visits.userId} state={catalogState} onRetry={()=>setRefresh(n=>n+1)} message={locationMessage} loading={loading}/>,
        map: <>      <MapView key={citySlug+':'+center.latitude+':'+center.longitude} ref={map} style={styles.map} initialRegion={{...region,...center}} showsUserLocation={!!origin}
        onLongPress={client ? e => suggest(e.nativeEvent.coordinate) : undefined}
        toolbarEnabled={false} showsMyLocationButton={false}>
        {nearby.map(place => (
          <Marker key={place.id} coordinate={place.coordinate} title={place.name + (wasVisited(place.id) ? ' ✓' : '')}
            accessibilityLabel={place.name + (wasVisited(place.id) ? t(', gezildi',', visited') : '')}
            pinColor={wasVisited(place.id) ? ink : red} onPress={() => openPlace(place)}/>
        ))}
      </MapView>
      <Text accessibilityRole="link" style={{color:ink,paddingHorizontal:12,paddingVertical:4}}
        onPress={() => openOfficialPage('https://www.openstreetmap.org/copyright')}>{t('© OpenStreetMap katkıcıları','© OpenStreetMap contributors')}</Text>
</>,
        routes: <ScrollView contentContainerStyle={ui.content}><Text style={ui.title}>{t('Rotalar','Routes')}</Text><Routes city={citySlug} revision={[visits.userId,visits.revision]} onRoute={slug=>openRoute(slug,'routes')}/></ScrollView>,
        badges: <ScrollView contentContainerStyle={ui.content}><Text style={ui.title}>{t('Rozetler','Badges')}</Text>{client ? visits.userId ? <Collection key={visits.userId} userId={visits.userId} visitRevision={visits.revision}/> : <Login/> : <Text>{t('Bağlantı gerekli.','Connection required.')}</Text>}</ScrollView>,
        profile: <ScrollView contentContainerStyle={ui.content}><Text style={ui.title}>{t('Profil','Profile')}</Text>{!!client && <Action onPress={()=>suggest(origin ?? center)}>{t('Yer öner','Suggest a place')}</Action>}
      {!client ? <Text>{t('Profil için bağlantı gerekli.','Connect to view your profile.')}</Text> : visits.userId ? <Profile key={visits.userId} visits={visits} onSocial={()=>setScreen('friends')} onClose={()=>setScreen('home')}/> : <Login/>}</ScrollView>
      }}/>}
      <Modal visible={!!detail} animationType="none" onRequestClose={award ? nextAward : closeDetail}>
        {detail && <View style={{flex:1}}><PlaceDetail key={detail.id} place={detail} userId={visits.userId} revision={visits.revision} live={!!client&&!galataPreview&&!demo}
          distance={origin&&!galataPreview?distanceMeters(origin,detail.coordinate):null} onBack={closeDetail} onTrack={()=>{setTrackedId(detail.id);setTrackedPlace(detail);closeDetail();setCameraMode(galataPreview?'galata':'live');}}
          footer={!demo&&!galataPreview&&detailState!=='missing'?<CheckIn place={detail} origin={origin} onFix={setOrigin} visits={visits} cities={cities.data}
            visited={wasVisited(detail.id)||!!(detail.visitedAt && detail.detailUser===visits.userId)} onMissing={()=>setRefresh(n=>n+1)} onAwards={(awards,userId)=>setCelebration({awards,userId})}/>:<Text style={ui.muted}>{t('Önizleme','Preview')}</Text>}>
          {detailState==='loading' && <ActivityIndicator color={c.primary}/>}
          {detailState==='missing' && <Text>{t('Bu yer artık yayında değil.','This place is no longer published.')}</Text>}
          {detailState==='error' && <Action onPress={()=>openPlace(detail)}>{t('Detayı tekrar yükle','Reload details')}</Action>}
          {!!detail.source && <Action onPress={()=>openOfficialPage(detail.source)}>{t('Resmî ziyaret bilgileri','Official visitor information')}</Action>}
          {!!client && !galataPreview && detailState!=='missing' && (reporting?<ContributionForm key={detail.id+':'+visits.userId} place={detail} coordinate={detail.coordinate} userId={visits.userId} onClose={()=>setReporting(false)}/>:<Action onPress={()=>setReporting(true)}>{t('Bir sorun mu var?','Report a problem')}</Action>)}
        </PlaceDetail>
        {award && <SafeAreaView accessibilityViewIsModal style={styles.celebration}><BadgeArt badge={{...award,earned_at:true}}/><Text style={ui.title}>{award.name}</Text><Text>{award.description}</Text><Action onPress={nextAward}>{t('Devam et','Continue')}</Action></SafeAreaView>}
        </View>}
      </Modal>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  page:{flex:1, backgroundColor:paper},
  header:{paddingHorizontal:22, paddingTop:12, paddingBottom:12},
  titleRow:{flexDirection:'row',alignItems:'center',justifyContent:'space-between'},
  eyebrow:{fontSize:11, letterSpacing:1.7, fontWeight:'700', color:c.inkMuted},
  title:{fontFamily:serif, fontSize:40, color:ink, marginTop:4},
  map:{flex:1.1}, sheet:{flex:1}, content:{padding:22, gap:8},
  heading:{fontFamily:serif, fontSize:27, color:ink}, muted:{color:c.inkMuted, fontSize:14},
  row:{flexDirection:'row', alignItems:'center', borderBottomColor:c.line, borderBottomWidth:1, paddingVertical:13, gap:10},
  rowMain:{flex:1, gap:5}, place:{fontFamily:serif, fontSize:22, color:ink},
  distance:{fontSize:15, fontWeight:'600', color:ink},
  action:{padding:14, borderRadius:13, backgroundColor:ink, alignItems:'center', marginTop:8, minHeight:48},
  actionLabel:{fontSize:16, fontWeight:'600', color:paper},
  overlay:{flex:1, justifyContent:'flex-end'}, backdrop:{...StyleSheet.absoluteFillObject, backgroundColor:c.scrim},
  celebration:{...StyleSheet.absoluteFillObject,backgroundColor:paper,justifyContent:'center',alignItems:'center',gap:18,padding:28},
  card:{maxHeight:'85%', backgroundColor:paper, borderTopLeftRadius:24, borderTopRightRadius:24},
  detail:{padding:24, gap:12}, story:{fontSize:17, lineHeight:26, color:c.ink},
  close:{padding:14, alignItems:'center'}
});
