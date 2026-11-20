import {Reviews,MyReviews} from './PlaceReviews';
import {AddPhoto,MyPhotos} from './VisitPhotos';
import {VisitSheet,Ceremony} from './Celebrations';
import PlaceMap from './PlaceMap';
import PlaceDetail from './PlaceDetail';
import Explore from './Explore';
import {c} from './theme';
import TabPage from './TabPage';
import MainTabs from './MainTabs';
import React, {useEffect, useRef, useState} from 'react';
import {
  ActivityIndicator, Alert, Linking, Modal,
  ScrollView, StatusBar, Text, View
} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import * as Location from 'expo-location';
import sample from './places.json';
import {AsyncStorage, client, demo, lang, project, t} from './client';
import {loadCity, loadDetail, loadNearby, mapPlace, mergeNearbyPlace} from './catalog';
import DiscoveryCamera from './DiscoveryCamera';
import {GuestBadges,Collection,Login} from './Badges';
import {Action,ui,useQuery} from './ScreenUI';
import Friends from './Friends';
import Profile,{GuestProfile} from './Profile';
import {ContributionForm} from './Contributions';
import {Routes,RouteDetail} from './Trips';
import CheckIn from './CheckInPanel';
import useVisits from './useVisits';
import {distanceMeters,galataPreviewOrigin} from './geo';

const pilot = {latitude:41.0266, longitude:28.9736};
const demoPlaces = lang === 'tr' ? sample : sample.map((p,i) => ({...p,
  name:i ? 'Galata Mevlevi Museum' : 'Galata Tower',category:i ? 'Museum' : 'Tower',
  period:i ? 'Ottoman period' : 'Genoese period',
  description:i ? 'Explore the Mevlevi heritage of Beyoğlu on Galip Dede Street.' : 'Built by the Genoese in the 14th century, the tower once formed part of the Galata walls.'}));
const rpc = (name, args) => client.rpc(name, args);

export default function App() {
  const map = useRef(null);
  const visits = useVisits();
  const [citySlug,setCitySlug] = useState('istanbul');
  const cities = useQuery(client ? 'list_cities' : null,{lang},visits.userId);
  const city = cities.data?.find(item => item.slug === citySlug);
  const center = city?.center ? {latitude:city.center.lat,longitude:city.center.lng} : pilot;
  const [screen,setScreen] = useState('home');
  const [routeSlug,setRouteSlug] = useState(null);
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
  const tab=useRef('explore'), navigation=useRef(null);
  const [profileReview,setProfileReview]=useState(null),[reviewVersion,setReviewVersion]=useState(0);
  const [subpage,setSubpage]=useState(null);
  const [result,setResult]=useState(null);
  const activeResult=result && result.userId===visits.userId?result:null;
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
    byId.set(p.id,mergeNearbyPlace(p,packed));
  });
  function wasVisited(id) {
    return !!visits.userId && (Object.prototype.hasOwnProperty.call(visits.dates,id) ||
      (nearbyResponse?.userId === visits.userId && byId.get(id)?.visited === true));
  }
  const places = Array.from(byId.values());
  const nearby = places.map(place => ({
    ...place, distance: distanceMeters(origin ?? center, place.coordinate)
  })).sort((a,b) => a.distance - b.distance);
  const listPlaces = nearby.filter(p => p.distance <= 2000);

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
    setSubpage(null);
    setResult(null);
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

  const canAddPhoto=!!detail && !!visits.userId && !galataPreview && !demo && (wasVisited(detail.id)||!!(detail.visitedAt && detail.detailUser===visits.userId));
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
  function openRoute(slug) {
    setRouteSlug(slug);
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

  return (
    <SafeAreaView style={{flex:1,backgroundColor:c.surface}}>
      <StatusBar barStyle="dark-content"/>
      {cameraOpen ? <DiscoveryCamera key={cameraMode} previewOrigin={galataPreview ? galataPreviewOrigin : null} onTryDemo={tryGalata}
        places={galataPreview ? demoPlaces : trackedPlace?.id === trackedId && !byId.has(trackedId) ? [...places,trackedPlace] : places} trackedId={trackedId}
        onStopTracking={() => setTrackedId(null)} onSelect={openPlace}
        onBack={() => { setCameraMode(null); setTrackedId(null); }}/> : screen !== 'home' ? <>
      <View style={{paddingHorizontal:16,paddingTop:8}}><Action onPress={()=>setScreen('home')}>{t('‹ Geri','‹ Back')}</Action></View>
      <ScrollView key={screen+':'+(visits.userId || '')} contentContainerStyle={ui.content} keyboardShouldPersistTaps="handled">
        {screen==='route' && <RouteDetail slug={routeSlug} revision={[visits.userId,visits.revision]} onPlace={showStop}/>}
        {screen==='friends' && (visits.userId?<Friends userId={visits.userId} onBadges={()=>{tab.current='badges';setScreen('home');}} onProfile={()=>setScreen('home')}/>:<Login/>)}
        {screen==='reviews' && visits.userId && <MyReviews visits={visits} revision={reviewVersion} onSelect={setProfileReview}/>}
        {screen==='photos' && visits.userId && <MyPhotos visits={visits}/>}
        {screen==='suggest' && <ContributionForm coordinate={suggestPin} userId={visits.userId} onClose={()=>setScreen('home')}/>}
      </ScrollView></> : <MainTabs navigationRef={navigation} initial={tab.current} onTab={name=>{tab.current=name;}} pages={{
        explore:<Explore places={nearby.map(p=>({...p,distance:origin?p.distance:null}))} nearby={listPlaces} city={city||{slug:citySlug,name:citySlug==='istanbul'?'İstanbul':citySlug}} cities={cities} onCity={chooseCity} origin={origin} permission={permission} onLocation={()=>useLocation()} onDemo={tryGalata} onCamera={()=>setCameraMode('live')} onPlace={openPlace} onRoute={slug=>openRoute(slug)} visited={wasVisited} revision={visits.revision} userId={visits.userId} state={catalogState} onRetry={()=>setRefresh(n=>n+1)} message={locationMessage} loading={loading}/>,
        map:<PlaceMap key={citySlug} places={nearby} mapRef={map} center={center} origin={origin} visited={wasVisited} onLocation={()=>useLocation()} onSuggest={client?suggest:null} onOpen={openPlace} message={locationMessage}/>,
        routes: <TabPage title={t('Rotalar','Routes')} location={city?.name || (citySlug==='istanbul'?'İstanbul':citySlug)}>
          <Routes city={citySlug} userId={visits.userId} visitRevision={visits.revision} onRoute={openRoute}/>
        </TabPage>,
        badges: <TabPage title={t('Rozetler','Badges')}>
          {client && visits.userId
            ? <Collection key={visits.userId} userId={visits.userId} visitRevision={visits.revision}/>
            : <GuestBadges/>}
        </TabPage>,
        profile: <TabPage title={t('Profil','Profile')}>
          {client && visits.userId ? <Profile key={visits.userId} visits={visits}
                onPhotos={()=>setScreen('photos')} onReviews={()=>setScreen('reviews')}
                onSocial={()=>setScreen('friends')} onSuggest={()=>suggest(origin ?? center)}
                onClose={()=>setScreen('home')}/>
            : <GuestProfile onSuggest={client ? ()=>suggest(origin ?? center) : null}/>}
        </TabPage>
      }}/>}
      <Modal visible={!!profileReview && !!visits.userId} onRequestClose={()=>setProfileReview(null)}>{profileReview && visits.userId && <Reviews place={profileReview} visits={visits} onBack={()=>setProfileReview(null)} onChanged={()=>setReviewVersion(n=>n+1)}/>}</Modal>
      <Modal visible={!!detail} animationType="none" onRequestClose={subpage?()=>setSubpage(null):award?nextAward:activeResult?()=>setResult(null):closeDetail}>
        {detail && <View style={{flex:1}}><View style={{flex:1}} accessibilityElementsHidden={!!(subpage||activeResult||award)} importantForAccessibility={subpage||activeResult||award?'no-hide-descendants':'auto'}><PlaceDetail key={detail.id} place={detail} onReviews={detailState==='missing'?undefined:()=>setSubpage('reviews')} userId={visits.userId} revision={visits.revision} live={!!client&&!galataPreview&&!demo}
          distance={origin&&!galataPreview?distanceMeters(origin,detail.coordinate):null} onBack={closeDetail} onTrack={()=>{setTrackedId(detail.id);setTrackedPlace(detail);closeDetail();setCameraMode(galataPreview?'galata':'live');}}
          footer={previousBadges=>!demo&&!galataPreview&&detailState!=='missing'?<CheckIn place={detail} origin={origin} onFix={coords=>{setPermission(true);setOrigin(coords);}} visits={visits} cities={cities.data}
            visited={wasVisited(detail.id)||!!(detail.visitedAt && detail.detailUser===visits.userId)} onMissing={()=>setRefresh(n=>n+1)} onResult={outcome=>setResult({...outcome,previousBadges,cityName:cities.data?.find(item=>item.slug===outcome.progress?.city)?.name})}/>:<Text style={ui.muted}>{t('Önizleme','Preview')}</Text>}>
          {detailState==='loading' && <ActivityIndicator color={c.primary}/>}
          {detailState==='missing' && <Text>{t('Bu yer artık yayında değil.','This place is no longer published.')}</Text>}
          {detailState==='error' && <Action onPress={()=>openPlace(detail)}>{t('Detayı tekrar yükle','Reload details')}</Action>}
          {!!client && !galataPreview && !demo && detailState!=='missing' && <Action onPress={()=>setSubpage('reviews')}>{t('Değerlendirmeleri gör','Read reviews')}</Action>}
          {canAddPhoto && <Action onPress={()=>setSubpage('photo')}>{t('Fotoğraf ekle','Add a photo')}</Action>}
          {!!detail.source && <Action onPress={()=>openOfficialPage(detail.source)}>{t('Resmî ziyaret bilgileri','Official visitor information')}</Action>}
          {!!client && !galataPreview && detailState!=='missing' && (reporting?<ContributionForm key={detail.id+':'+visits.userId} place={detail} coordinate={detail.coordinate} userId={visits.userId} onClose={()=>setReporting(false)}/>:<Action onPress={()=>setReporting(true)}>{t('Bir sorun mu var?','Report a problem')}</Action>)}
        </PlaceDetail></View>
        {activeResult && !subpage && <VisitSheet onPhoto={canAddPhoto?()=>setSubpage('photo'):null} result={activeResult} place={detail} onClose={()=>setResult(null)} onAward={()=>{setCelebration({awards:activeResult.awards,userId:visits.userId});setResult(null);}}/>}
        {subpage==='reviews' && <Reviews place={detail} visits={visits} onBack={()=>setSubpage(null)} onChanged={rating=>{setReviewVersion(n=>n+1);if(rating)setDetail(d=>d?{...d,rating}:d);else openPlace(detail);}}/>}
        {subpage==='photo' && canAddPhoto && <AddPhoto key={detail.id+visits.userId} place={detail} visits={visits} onBack={()=>setSubpage(null)}/>}
        {award && <Ceremony key={award.slug} badge={award} userId={visits.userId} onClose={()=>setCelebration(null)} onNext={nextAward} onBadges={()=>{tab.current='badges';setScreen('home');setCameraMode(null);navigation.current?.navigate('badges');closeDetail();}}/>}
        </View>}
      </Modal>
    </SafeAreaView>
  );
}
