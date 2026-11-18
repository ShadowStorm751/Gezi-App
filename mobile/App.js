import React, {useRef, useState} from 'react';
import {
  ActivityIndicator, Alert, Linking, Modal, Platform, Pressable, SafeAreaView,
  ScrollView, StatusBar, StyleSheet, Text, View
} from 'react-native';
import MapView, {Marker} from 'react-native-maps';
import * as Location from 'expo-location';
import places from './places.json';
import DiscoveryCamera from './DiscoveryCamera';
import {distanceMeters} from './geo';

const paper = '#FAF7F0';
const ink = '#143C38';
const red = '#B44721';
const serif = Platform.select({ios:'Georgia', android:'serif'});
const pilot = {latitude:41.0266, longitude:28.9736};
const region = {...pilot, latitudeDelta:0.009, longitudeDelta:0.009};

function formatDistance(meters) {
  return meters < 1000 ? Math.round(meters) + ' m' :
    (meters / 1000).toLocaleString('tr-TR', {maximumFractionDigits:1}) + ' km';
}

export default function App() {
  const map = useRef(null);
  const [origin, setOrigin] = useState(null);
  const [loading, setLoading] = useState(false);
  const [detail, setDetail] = useState(null);
  const [cameraOpen, setCameraOpen] = useState(false);
  const [trackedId, setTrackedId] = useState(null);
  const [locationMessage, setLocationMessage] = useState('');
  const nearby = places.map(place => ({
    ...place, distance: distanceMeters(origin ?? pilot, place.coordinate)
  })).sort((a,b) => a.distance - b.distance);

  async function useLocation() {
    setLoading(true);
    try {
      const permission = await Location.requestForegroundPermissionsAsync();
      if (!permission.granted) {
        setOrigin(null);
        setLocationMessage('Konum izni kapalı. Örnek konumu kullanıyorsun.');
        return;
      }
      const fix = await Location.getCurrentPositionAsync({accuracy:Location.Accuracy.Balanced});
      setOrigin(fix.coords);
      setLocationMessage('');
    } catch {
      setOrigin(null);
      setLocationMessage('Konum alınamadı. Örnek konumu kullanıyorsun.');
    } finally {
      setLoading(false);
    }
  }

  function openPlace(place) {
    map.current?.animateCamera({center:place.coordinate}, {duration:300});
    setDetail(place);
  }

  function openOfficialPage(url) {
    Linking.openURL(url).catch(() => Alert.alert('Ziyaret sayfası açılamadı', 'Bağlantını kontrol edip tekrar dene.'));
  }

  return (
    <SafeAreaView style={styles.page}>
      <StatusBar barStyle="dark-content" backgroundColor={paper}/>
      {cameraOpen ? <DiscoveryCamera places={places} trackedId={trackedId}
        onStopTracking={() => setTrackedId(null)} onSelect={setDetail}
        onBack={() => { setCameraOpen(false); setTrackedId(null); }}/> : <>
      <View style={styles.header}>
        <Text style={styles.eyebrow}>İSTANBUL  /  BEYOĞLU</Text>
        <Text accessibilityRole="header" style={styles.title}>Keşfet</Text>
        <Pressable accessibilityRole="button" style={styles.action} onPress={() => setCameraOpen(true)}>
          <Text style={styles.actionLabel}>Kamerayla keşfet</Text>
        </Pressable>
      </View>
      <MapView ref={map} style={styles.map} initialRegion={region} showsUserLocation={!!origin}
        toolbarEnabled={false} showsMyLocationButton={false}>
        {nearby.map(place => (
          <Marker key={place.id} coordinate={place.coordinate} title={place.name}
            accessibilityLabel={place.name} pinColor={red} onPress={() => openPlace(place)}/>
        ))}
      </MapView>
      <ScrollView style={styles.sheet} contentContainerStyle={styles.content}>
        <Text style={styles.heading} accessibilityRole="header">Galata çevresinde</Text>
        <Text style={styles.muted}>{origin ? 'Konumundan kuş uçuşu uzaklık' : 'Örnek konumdan kuş uçuşu uzaklık'}</Text>
        {nearby.map(place => (
          <Pressable key={place.id} accessibilityRole="button" style={styles.row} onPress={() => openPlace(place)}>
            <View style={styles.rowMain}>
              <Text style={styles.eyebrow}>{place.category.toLocaleUpperCase('tr-TR')}</Text>
              <Text style={styles.place}>{place.name}</Text>
            </View>
            <Text style={styles.distance}>{formatDistance(place.distance)}  ›</Text>
          </Pressable>
        ))}
        <Pressable accessibilityRole="button" disabled={loading} onPress={useLocation} style={styles.action}>
          {loading ? <ActivityIndicator color={paper}/> : <Text style={styles.actionLabel}>{origin ? 'Konumumu güncelle' : 'Konumumu kullan'}</Text>}
        </Pressable>
        {!!locationMessage && <Text accessibilityLiveRegion="polite" style={styles.muted}>{locationMessage}</Text>}
      </ScrollView>
      </>}
      <Modal visible={!!detail} transparent animationType="slide" onRequestClose={() => setDetail(null)}>
        {detail && <View style={styles.overlay}>
          <Pressable accessibilityLabel="Yer detayını kapat" accessibilityRole="button" style={styles.backdrop} onPress={() => setDetail(null)}/>
          <SafeAreaView style={styles.card}>
            <ScrollView contentContainerStyle={styles.detail}>
              <Text style={styles.eyebrow}>{detail.period.toLocaleUpperCase('tr-TR')}  ·  {formatDistance(detail.distance)}</Text>
              <Text style={styles.title} accessibilityRole="header">{detail.name}</Text>
              <Text style={styles.story}>{detail.description}</Text>
              <Pressable accessibilityRole="button" style={styles.action} onPress={() => {
                setTrackedId(detail.id);
                setDetail(null);
                setCameraOpen(true);
              }}>
                <Text style={styles.actionLabel}>Kamerada takip et</Text>
              </Pressable>
              <Pressable accessibilityRole="link" style={styles.action} onPress={() => openOfficialPage(detail.source)}>
                <Text style={styles.actionLabel}>Resmî ziyaret bilgileri ↗</Text>
              </Pressable>
              <Pressable accessibilityRole="button" style={styles.close} onPress={() => setDetail(null)}>
                <Text style={styles.distance}>{cameraOpen ? 'Kameraya dön' : 'Haritaya dön'}</Text>
              </Pressable>
            </ScrollView>
          </SafeAreaView>
        </View>}
      </Modal>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  page:{flex:1, backgroundColor:paper, paddingTop:Platform.OS === 'android' ? StatusBar.currentHeight : 0},
  header:{paddingHorizontal:22, paddingTop:12, paddingBottom:12},
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
  card:{maxHeight:'85%', backgroundColor:paper, borderTopLeftRadius:24, borderTopRightRadius:24},
  detail:{padding:24, gap:12}, story:{fontSize:17, lineHeight:26, color:'#304A43'},
  close:{padding:14, alignItems:'center'}
});
