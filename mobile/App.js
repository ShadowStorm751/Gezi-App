import React, {useEffect, useRef, useState} from 'react';
import {
  ActivityIndicator, Alert, Linking, Modal, Platform, Pressable, SafeAreaView,
  ScrollView, StatusBar, StyleSheet, Text, View
} from 'react-native';
import MapView, {Marker} from 'react-native-maps';
import * as Location from 'expo-location';
import sample from './places.json';
import {AsyncStorage, client, demo, lang, project, t} from './client';
import {loadCity, loadDetail, loadNearby, mapPlace} from './catalog';
import DiscoveryCamera from './DiscoveryCamera';
import {PlaceGallery, PlaceThumbnail} from './PlaceMedia';
import Badges, {BadgeArt} from './Badges';
import CheckIn from './CheckInPanel';
import useVisits from './useVisits';
import {distanceMeters} from './geo';

const paper = '#FAF7F0';
const ink = '#143C38';
const red = '#B44721';
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
  const [celebration,setCelebration] = useState(null);
  const award = celebration?.userId === visits.userId ? celebration?.awards[0] : null;
  const [origin, setOrigin] = useState(null);
  const [loading, setLoading] = useState(false);
  const [detail, setDetail] = useState(null);
  const [cameraOpen, setCameraOpen] = useState(false);
  const [badgesOpen, setBadgesOpen] = useState(false);
  const [trackedId, setTrackedId] = useState(null);
  const [locationMessage, setLocationMessage] = useState('');
  const [packPlaces,setPlaces] = useState(demo ? demoPlaces : []);
  const [nearbyResponse,setNearbyResponse] = useState(null);
  const serverNearby = nearbyResponse?.places ?? null;
  const [catalogState,setCatalogState] = useState(demo ? 'demo' : 'loading');
  const [refresh,setRefresh] = useState(0);
  const [detailState,setDetailState] = useState('');
  const detailToken = useRef(0);
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
    }).then(pack => {
      if (active) { setPlaces(pack.places.map(row => mapPlace(row,lang))); setCatalogState('ready'); }
    }).catch(() => { if (active) setCatalogState(hasCache ? 'offline' : 'error'); });
    return () => { active = false; };
  }, [refresh]);
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
    ...place, distance: distanceMeters(origin ?? pilot, place.coordinate)
  })).sort((a,b) => a.distance - b.distance);
  const listPlaces = serverNearby?.map(p => byId.get(p.id)) ?? nearby.filter(p => p.distance <= 2000);

  async function useLocation() {
    setLoading(true);
    setNearbyResponse(null);
    try {
      const permission = await Location.requestForegroundPermissionsAsync();
      if (!permission.granted) {
        setOrigin(null);
        setLocationMessage(t("Konum izni kapalı. Örnek konumu kullanıyorsun.","Location access is off. Using the sample location."));
        return;
      }
      const fix = await Location.getCurrentPositionAsync({accuracy:Location.Accuracy.Balanced});
      setOrigin(fix.coords);
      map.current?.animateCamera({center:{latitude:fix.coords.latitude,longitude:fix.coords.longitude}}, {duration:300});
      setLocationMessage('');
      if (client) {
        const userId = visits.owner.current;
        try { setNearbyResponse({userId,places:await loadNearby(rpc,fix.coords,lang)}); }
        catch { setLocationMessage(t('Yakındaki yerler güncellenemedi. Mevcut katalog kullanılıyor.',
          'Nearby places could not be refreshed. Using the current catalog.')); }
      }
    } catch {
      setOrigin(null);
      setLocationMessage(t("Konum alınamadı. Örnek konumu kullanıyorsun.","Location unavailable. Using the sample location."));
    } finally {
      setLoading(false);
    }
  }

  function closeDetail() {
    detailToken.current++;
    setCelebration(null);
    setDetail(null);
  }

  function nextAward() {
    setCelebration(current => current?.awards.length > 1 ? {...current,awards:current.awards.slice(1)} : null);
  }
  async function openPlace(place) {
    const token = ++detailToken.current;
    if (!cameraOpen) map.current?.animateCamera({center:place.coordinate}, {duration:300});
    setDetail(place);
    setDetailState('');
    if (demo || !client) return;
    setDetailState('loading');
    try {
      const info = await loadDetail(rpc,place.id,lang);
      if (detailToken.current !== token) return;
      if (info) setDetail({...place,...info,category:place.category,categoryLabel:info.category});
      setDetailState(info ? '' : 'missing');
    } catch { if (detailToken.current === token) setDetailState('error'); }
  }

  function openOfficialPage(url) {
    Linking.openURL(url).catch(() => Alert.alert(t("Ziyaret sayfası açılamadı","Could not open visitor information"), t("Bağlantını kontrol edip tekrar dene.","Check your connection and try again.")));
  }

  return (
    <SafeAreaView style={styles.page}>
      <StatusBar barStyle="dark-content" backgroundColor={paper}/>
      {cameraOpen ? <DiscoveryCamera places={places} trackedId={trackedId}
        onStopTracking={() => setTrackedId(null)} onSelect={openPlace}
        onBack={() => { setCameraOpen(false); setTrackedId(null); }}/> : <>
      <View style={styles.header}>
        <Text style={styles.eyebrow}>{demo ? 'İSTANBUL / GALATA' : 'İSTANBUL'}</Text>
        <View style={styles.titleRow}><Text accessibilityRole="header" style={styles.title}>{t("Keşfet","Explore")}</Text>
          <Pressable accessibilityRole="button" style={styles.close} onPress={() => setBadgesOpen(true)}>
            <Text style={styles.distance}>{t('Rozetler','Badges')}</Text>
          </Pressable>
        </View>
        <Pressable accessibilityRole="button" disabled={!places.length} style={styles.action} onPress={() => setCameraOpen(true)}>
          <Text style={styles.actionLabel}>{t("Kamerayla keşfet","Explore with camera")}</Text>
        </Pressable>
      </View>
      <MapView ref={map} style={styles.map} initialRegion={region} showsUserLocation={!!origin}
        toolbarEnabled={false} showsMyLocationButton={false}>
        {nearby.map(place => (
          <Marker key={place.id} coordinate={place.coordinate} title={place.name + (wasVisited(place.id) ? ' ✓' : '')}
            accessibilityLabel={place.name + (wasVisited(place.id) ? t(', gezildi',', visited') : '')}
            pinColor={wasVisited(place.id) ? ink : red} onPress={() => openPlace(place)}/>
        ))}
      </MapView>
      <ScrollView style={styles.sheet} contentContainerStyle={styles.content}>
        <Text style={styles.heading} accessibilityRole="header">{t('Yakındaki yerler','Nearby places')}</Text>
        {catalogState !== 'ready' && <Text style={styles.muted}>{{
          demo:t('Galata örnek kataloğu','Galata sample catalog'),
          loading:t('İstanbul paketi yükleniyor…','Loading Istanbul…'),
          cached:t('Kayıtlı paket güncelleniyor…','Refreshing the saved catalog…'),
          offline:t('Kayıtlı İstanbul paketi gösteriliyor.','Showing the saved Istanbul catalog.'),
          error:t('İstanbul paketi alınamadı.','Could not load the Istanbul catalog.'),
          config:t('Supabase bağlantı ayarları eksik veya geçersiz.','Supabase configuration is incomplete or invalid.')
        }[catalogState]}</Text>}
        {['error','offline'].includes(catalogState) && <Pressable accessibilityRole="button" style={styles.close} onPress={() => setRefresh(n => n+1)}>
          <Text style={styles.distance}>{t("Tekrar dene","Try again")}</Text></Pressable>}
        {catalogState === 'ready' && !places.length && <Text style={styles.muted}>{t('İstanbul için yayımlanmış yer yok.','No published places in Istanbul yet.')}</Text>}
        <Text style={styles.muted}>{origin ? t("Konumundan kuş uçuşu uzaklık","Straight-line distance from your location") : t("Örnek konumdan kuş uçuşu uzaklık","Straight-line distance from the sample location")}</Text>
        {(places.length > 0 || serverNearby !== null) && !listPlaces.length &&
          <Text style={styles.muted}>{t('2 km içinde yer bulunamadı.', 'No places within 2 km.')}</Text>}
        {listPlaces.map(place => (
          <Pressable key={place.id} accessibilityRole="button" style={styles.row} onPress={() => openPlace(place)}>
            <PlaceThumbnail place={place}/>
            <View style={styles.rowMain}>
              <Text style={styles.eyebrow}>{(place.categoryLabel || place.category).toLocaleUpperCase(lang)}</Text>
              <Text style={styles.place}>{place.name}{wasVisited(place.id) ? ' ✓' : ''}</Text>
            </View>
            <Text style={styles.distance}>{formatDistance(place.distance)}  ›</Text>
          </Pressable>
        ))}
        <Pressable accessibilityRole="button" disabled={loading} onPress={useLocation} style={styles.action}>
          {loading ? <ActivityIndicator color={paper}/> : <Text style={styles.actionLabel}>{origin ? t("Konumumu güncelle","Update my location") : t("Konumumu kullan","Use my location")}</Text>}
        </Pressable>
        {!!locationMessage && <Text accessibilityLiveRegion="polite" style={styles.muted}>{locationMessage}</Text>}
      </ScrollView>
      </>}
      {badgesOpen && <Badges visitRevision={visits.revision} onClose={() => setBadgesOpen(false)}/>}
      <Modal visible={!!detail} transparent animationType="slide" onRequestClose={award ? nextAward : closeDetail}>
        {detail && <View style={styles.overlay}>
          <Pressable accessibilityLabel={t("Yer detayını kapat","Close place details")} accessibilityRole="button" style={styles.backdrop} onPress={closeDetail}/>
          <SafeAreaView style={styles.card} accessibilityElementsHidden={!!award} importantForAccessibility={award ? 'no-hide-descendants' : 'auto'}>
            <ScrollView contentContainerStyle={styles.detail} keyboardShouldPersistTaps="handled">
              <Text style={styles.eyebrow}>{(detail.period || detail.categoryLabel || detail.category).toLocaleUpperCase(lang)}{detail.hasArea ? '' : '  ·  '+formatDistance(detail.distance)}</Text>
              <Text style={styles.title} accessibilityRole="header">{detail.name}</Text>
              {detailState !== 'loading' && <PlaceGallery place={detail}/>}
              <Text style={styles.story}>{detail.description}</Text>
              {!demo && detailState !== 'missing' && <CheckIn key={detail.id} place={detail} origin={origin} visits={visits}
                visited={wasVisited(detail.id)} onMissing={() => setRefresh(n => n+1)}
                onAwards={(awards,userId) => setCelebration({awards,userId})}/>}
              {!!detail.bestTime && <Text style={styles.muted}>{t('Önerilen zaman','Best time')} · {detail.bestTime}</Text>}
              {detailState === 'loading' && <ActivityIndicator color={ink}/>}
              {detailState === 'missing' && <Text>{t('Bu yer artık yayında değil.','This place is no longer published.')}</Text>}
              {detailState === 'error' && <Pressable accessibilityRole="button" style={styles.close} onPress={() => openPlace(detail)}>
                <Text>{t('Detay yüklenemedi. Tekrar dene.','Details unavailable. Try again.')}</Text></Pressable>}
              <Pressable accessibilityRole="button" disabled={detailState === 'missing'} style={styles.action} onPress={() => {
                setTrackedId(detail.id);
                closeDetail();
                setCameraOpen(true);
              }}>
                <Text style={styles.actionLabel}>{t("Kamerada takip et","Track in camera")}</Text>
              </Pressable>
              {!!detail.source && <Pressable accessibilityRole="link" style={styles.action} onPress={() => openOfficialPage(detail.source)}>
                <Text style={styles.actionLabel}>{t("Resmî ziyaret bilgileri ↗","Official visitor information ↗")}</Text>
              </Pressable>}
              <Pressable accessibilityRole="button" style={styles.close} onPress={closeDetail}>
                <Text style={styles.distance}>{cameraOpen ? t("Kameraya dön","Back to camera") : t("Haritaya dön","Back to map")}</Text>
              </Pressable>
            </ScrollView>
          </SafeAreaView>
          {award && <SafeAreaView accessibilityViewIsModal style={styles.celebration}>
            <Text style={styles.eyebrow}>{t('YENİ ROZET','NEW BADGE')}</Text>
            <BadgeArt key={award.slug} badge={{...award,earned_at:true}}/>
            <Text accessibilityRole="header" style={styles.title}>{award.name}</Text>
            {!!award.description && <Text style={styles.story}>{award.description}</Text>}
            <Pressable accessibilityRole="button" style={styles.action} onPress={nextAward}><Text style={styles.actionLabel}>
              {celebration.awards.length > 1 ? t('Sıradaki rozet','Next badge') : t('Yer kartına dön','Back to place')}
            </Text></Pressable>
          </SafeAreaView>}
        </View>}
      </Modal>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  page:{flex:1, backgroundColor:paper, paddingTop:Platform.OS === 'android' ? StatusBar.currentHeight : 0},
  header:{paddingHorizontal:22, paddingTop:12, paddingBottom:12},
  titleRow:{flexDirection:'row',alignItems:'center',justifyContent:'space-between'},
  eyebrow:{fontSize:11, letterSpacing:1.7, fontWeight:'700', color:'#526D64'},
  title:{fontFamily:serif, fontSize:40, color:ink, marginTop:4},
  map:{flex:1.1}, sheet:{flex:1}, content:{padding:22, gap:8},
  heading:{fontFamily:serif, fontSize:27, color:ink}, muted:{color:'#56635E', fontSize:14},
  row:{flexDirection:'row', alignItems:'center', borderBottomColor:'#D9D8CC', borderBottomWidth:1, paddingVertical:13, gap:10},
  rowMain:{flex:1, gap:5}, place:{fontFamily:serif, fontSize:22, color:ink},
  distance:{fontSize:15, fontWeight:'600', color:ink},
  action:{padding:14, borderRadius:13, backgroundColor:ink, alignItems:'center', marginTop:8, minHeight:48},
  actionLabel:{fontSize:16, fontWeight:'600', color:paper},
  overlay:{flex:1, justifyContent:'flex-end'}, backdrop:{...StyleSheet.absoluteFillObject, backgroundColor:'#11262166'},
  celebration:{...StyleSheet.absoluteFillObject,backgroundColor:paper,justifyContent:'center',alignItems:'center',gap:18,padding:28},
  card:{maxHeight:'85%', backgroundColor:paper, borderTopLeftRadius:24, borderTopRightRadius:24},
  detail:{padding:24, gap:12}, story:{fontSize:17, lineHeight:26, color:'#304A43'},
  close:{padding:14, alignItems:'center'}
});
