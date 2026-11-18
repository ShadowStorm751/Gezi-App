import React, {useEffect, useState} from 'react';
import {AppState, BackHandler, Linking, Pressable, StyleSheet, Text, View} from 'react-native';
import {CameraView, useCameraPermissions} from 'expo-camera';
import {DeviceMotion} from 'expo-sensors';
import * as Location from 'expo-location';
import {cameraMarkers, cameraTargets, rearCameraPitch, edgeHints, edgeArrows} from './geo';

function Control({children, onPress}) {
  return <Pressable accessibilityRole="button" onPress={onPress} style={styles.control}>
    <Text style={styles.light}>{children}</Text>
  </Pressable>;
}

export default function DiscoveryCamera({places, trackedId, onStopTracking, onSelect, onBack}) {
  const [permission, requestCamera] = useCameraPermissions();
  const [active, setActive] = useState(AppState.currentState !== 'background');
  const [coords, setCoords] = useState(null);
  const [heading, setHeading] = useState(null);
  const [issue, setIssue] = useState('');
  const [lensError, setLensError] = useState(false);
  const [retry, setRetry] = useState(0);
  const [{width,height}, setSize] = useState({width:0,height:0});
  const [pitch, setPitch] = useState(null);
  const motionEnabled = active && permission?.granted && !!coords && !lensError;
  useEffect(() => {
    let closed = false;
    let subscription;
    setPitch(null);
    async function watchTilt() {
      if (!motionEnabled || !(await DeviceMotion.isAvailableAsync()) || closed) return;
      const access = await DeviceMotion.requestPermissionsAsync();
      if (closed || !access.granted) return;
      DeviceMotion.setUpdateInterval(80);
      subscription = DeviceMotion.addListener(({rotation}) => {
        if (!closed) setPitch(rearCameraPitch(rotation));
      });
    }
    watchTilt().catch(() => { if (!closed) setPitch(null); });
    return () => { closed = true; subscription?.remove(); };
  }, [motionEnabled]);

  useEffect(() => {
    const sub = AppState.addEventListener('change', state => setActive(state === 'active'));
    return () => sub.remove();
  }, []);
  useEffect(() => {
    const sub = BackHandler.addEventListener('hardwareBackPress', () => { onBack(); return true; });
    return () => sub.remove();
  }, [onBack]);

  useEffect(() => {
    if (!active || !permission?.granted) return;
    let cancelled = false;
    const subscriptions = [];
    function keep(subscription) {
      if (cancelled) subscription.remove();
      else subscriptions.push(subscription);
    }
    setCoords(null);
    setHeading(null);
    setIssue('');
    async function start() {
      const access = await Location.requestForegroundPermissionsAsync();
      if (cancelled) return;
      if (!access.granted) { setIssue('Baloncukların yönü için konum iznini aç.'); return; }
      const position = await Location.watchPositionAsync(
        {accuracy:Location.Accuracy.High, distanceInterval:3, timeInterval:1500},
        fix => { if (!cancelled) setCoords(fix.coords); }
      );
      keep(position);
      if (cancelled) return;
      keep(await Location.watchHeadingAsync(reading => {
        if (cancelled) return;
        const degrees = reading.trueHeading >= 0 ? reading.trueHeading : reading.magHeading;
        setHeading(reading.accuracy > 0 && degrees >= 0 ? degrees : null);
      }));
    }
    start().catch(() => { if (!cancelled) setIssue('Konum veya pusula okunamadı. Cihaz ayarlarını kontrol et.'); });
    return () => { cancelled = true; subscriptions.forEach(sub => sub.remove()); };
  }, [active, permission?.granted, retry]);

  const targets = cameraTargets(places, coords, heading);
  const aspect = height > 0 ? width / height : 0.6;
  const visible = cameraMarkers(targets, trackedId, pitch ?? 0, aspect);
  const trackedPlace = places.find(place => place.id === trackedId);
  const closest = targets[0];
  let hint = 'Baloncuğa dokunarak yerin hikâyesini aç.';
  if (!active) hint = '';
  else if (issue) hint = issue;
  else if (!coords) hint = 'Konum bekleniyor…';
  else if (heading === null) hint = 'Pusula bekleniyor. Telefonu dik tutup yavaşça çevir.';
  else if (trackedPlace && !visible.length) hint = trackedPlace.name + ' 2 km’lik keşif alanının dışında.';
  else if (visible[0]?.edge) hint = 'Hedefi görmek için ' + edgeHints[visible[0].edge] + '.';
  else if (!closest) hint = '2 km içinde pilot yer bulunamadı. İlk iki durak Galata’da.';
  else if (!visible.length) {
    const [guide] = cameraMarkers(targets, closest.id, pitch ?? 0, aspect);
    hint = closest.name + ' için ' + edgeHints[guide.edge] + '.';
  }
  const bubbleWidth = Math.min(208, Math.max(0, width - 24));
  return <View style={styles.screen} onLayout={e => setSize(e.nativeEvent.layout)}>
    {active && permission?.granted && !lensError &&
      <CameraView style={StyleSheet.absoluteFill} facing="back" onMountError={() => setLensError(true)}/>}
    <View style={styles.top}>
      <Control onPress={onBack}>Keşfet’e dön</Control>
      {heading !== null && permission?.granted && <Text style={styles.chip}>{Math.round(heading) % 360}°</Text>}
    </View>
    {!permission?.granted || lensError ? <View style={styles.center}>
      <Text style={styles.title}>Kamerayla keşfet</Text>
      <Text style={styles.light}>{lensError ? 'Arka kamera açılamadı.' : 'Tarihi yerlerin yönünü canlı görüntü üzerinde görmek için kameraya izin ver.'}</Text>
      <Control onPress={() => lensError ? setLensError(false) : permission?.canAskAgain === false ? Linking.openSettings() : requestCamera()}>
        {lensError ? 'Tekrar dene' : permission?.canAskAgain === false ? 'Ayarları aç' : 'Kamera izni ver'}
      </Control>
    </View> : <>
      {width > 0 && visible.map((place, i) => {
        const left = Math.max(8, Math.min(width - bubbleWidth - 8, width * place.fraction - bubbleWidth / 2));
        return <Pressable accessibilityRole="button" key={place.id} onPress={() => onSelect(place)}
          style={[styles.bubble, {left, width:bubbleWidth,
            top: (17 + 43 * place.vertical + (visible.length > 1 ? i * 13 : 0)) + '%'}]}>
          <Text style={styles.place}>{place.edge ? edgeArrows[place.edge] + ' ' : ''}{place.name}</Text>
          <Text style={styles.light}>{Math.round(place.distance)} m</Text>
        </Pressable>;
      })}
      <View style={styles.bottom}>
        <Text style={styles.light}>{hint}</Text>
        {pitch === null && !!coords && <Text style={styles.light}>Eğim verisi yok · Yatay takip açık</Text>}
        {!!trackedId && <Control onPress={onStopTracking}>Takibi bırak</Control>}
        {!!issue && <Control onPress={() => setRetry(n => n + 1)}>Yeniden dene</Control>}
        {!!issue && <Control onPress={() => Linking.openSettings()}>Ayarları aç</Control>}
      </View>
    </>}
  </View>;
}
const styles = StyleSheet.create({
  screen:{flex:1,backgroundColor:'#112b2c'}, top:{flexDirection:'row',alignItems:'center',justifyContent:'space-between',padding:16},
  control:{paddingVertical:12,paddingHorizontal:16,backgroundColor:'#173b39ed',borderRadius:24},
  chip:{backgroundColor:'#173b39dd',padding:10,borderRadius:12,color:'white'},
  center:{margin:24,marginTop:'25%',gap:14}, title:{fontSize:30,color:'white',fontFamily:'serif'},
  light:{fontSize:16,color:'#faf9ef'}, bubble:{position:'absolute',backgroundColor:'#113638ed',borderWidth:1.5,borderColor:'#92e8cb',borderRadius:26,paddingVertical:9,paddingHorizontal:16},
  place:{color:'#fff9e9',fontSize:17,fontWeight:'600'}, bottom:{position:'absolute',bottom:16,left:16,right:16,gap:6,backgroundColor:'#102b2ae8',borderRadius:16,padding:15}
});
