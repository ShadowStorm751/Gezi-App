import {c} from './theme';
import {lang,t} from './client';
import React, {useCallback, useEffect, useRef, useState} from 'react';
import {AppState, BackHandler, Linking, Pressable, StyleSheet, Text, View} from 'react-native';
import {CameraView, useCameraPermissions} from 'expo-camera';
import {DeviceMotion} from 'expo-sensors';
import * as Location from 'expo-location';
import {cameraMarkers, cameraTargets, rearCameraPitch, edgeHints, edgeArrows} from './geo';
import CameraPhotos from './CameraPhotos';
import CameraCompass from './CameraCompass';

function Control({children, onPress}) {
  return <Pressable accessibilityRole="button" onPress={onPress} style={styles.control}>
    <Text style={styles.light}>{children}</Text>
  </Pressable>;
}

export default function DiscoveryCamera({places, trackedId, onStopTracking, onSelect, onBack, previewOrigin, onTryDemo}) {
  const [permission, requestCamera] = useCameraPermissions();
  const [foreground, setActive] = useState(AppState.currentState !== 'background');
  const [photosOpen, setPhotosOpen] = useState(false);
  const active = foreground && !photosOpen;
  const camera = useRef(null);
  const [ready, setReady] = useState(false);
  const attachCamera = useCallback(view => {
    camera.current = view;
    if (!view) setReady(false);
  }, []);
  const [gpsCoords, setCoords] = useState(null);
  const coords = previewOrigin ?? gpsCoords;
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
      if (!access.granted) { setIssue(t("Baloncukların yönü için konum iznini aç.","Enable location to see nearby places.")); return; }
      if (!previewOrigin) {
        const position = await Location.watchPositionAsync(
          {accuracy:Location.Accuracy.High, distanceInterval:3, timeInterval:1500},
          fix => { if (!cancelled) setCoords(fix.coords); }
        );
        keep(position);
      }
      if (cancelled) return;
      keep(await Location.watchHeadingAsync(reading => {
        if (cancelled) return;
        const degrees = reading.trueHeading >= 0 ? reading.trueHeading : reading.magHeading;
        setHeading(reading.accuracy > 0 && degrees >= 0 ? degrees : null);
      }));
    }
    start().catch(() => { if (!cancelled) setIssue(t("Konum veya pusula okunamadı. Cihaz ayarlarını kontrol et.","Location or compass unavailable. Check device settings.")); });
    return () => { cancelled = true; subscriptions.forEach(sub => sub.remove()); };
  }, [active, permission?.granted, retry, previewOrigin]);

  const targets = cameraTargets(places, coords, heading);
  const aspect = height > 0 ? width / height : 0.6;
  const visible = cameraMarkers(targets, trackedId, pitch ?? 0, aspect);
  const directions = lang === 'tr' ? edgeHints : {left:'turn left',right:'turn right',top:'tilt up',bottom:'tilt down'};
  const trackedPlace = places.find(place => place.id === trackedId);
  const closest = targets[0];
  let hint = t("Baloncuğa dokunarak yerin hikâyesini aç.","Tap a marker to read its story.");
  if (!active) hint = '';
  else if (issue) hint = issue;
  else if (!coords) hint = t("Konum bekleniyor…","Waiting for location…");
  else if (heading === null) hint = t("Pusula bekleniyor. Telefonu dik tutup yavaşça çevir.","Waiting for compass. Hold your phone upright and turn slowly.");
  else if (trackedPlace && !visible.length) hint = trackedPlace.name + t(" 2 km’lik keşif alanının dışında."," is outside the 2 km discovery area.");
  else if (visible[0]?.edge) hint = t('Hedefi görmek için ', 'To see the place, ') + directions[visible[0].edge] + '.';
  else if (!closest) hint = t('2 km içinde yer bulunamadı.', 'No places within 2 km.');
  else if (!visible.length) {
    const [guide] = cameraMarkers(targets, closest.id, pitch ?? 0, aspect);
    hint = closest.name + ' · ' + directions[guide.edge] + '.';
  }
  const bubbleWidth = Math.min(208, Math.max(0, width - 24));
  return <View style={styles.screen} onLayout={e => setSize(e.nativeEvent.layout)}>
    {active && permission?.granted && !lensError &&
      <CameraView ref={attachCamera} style={StyleSheet.absoluteFill} facing="back" onCameraReady={() => setReady(true)}
        onMountError={() => setLensError(true)}/>}
    <View style={styles.top}>
      <View style={styles.side}><Control onPress={onBack}>{t("Keşfet’e dön","Back to Explore")}</Control></View>
      {active && permission?.granted && !lensError && <CameraCompass heading={heading}/>}
      <View style={styles.side}/>
    </View>
    {!permission?.granted || lensError ? <View style={styles.center}>
      <Text style={styles.title}>{t("Kamerayla keşfet","Explore with camera")}</Text>
      <Text style={styles.light}>{lensError ? t("Arka kamera açılamadı.","Could not open the rear camera.") : t("Tarihi yerlerin yönünü canlı görüntü üzerinde görmek için kameraya izin ver.","Allow camera access to see nearby places in the live view.")}</Text>
      <Control onPress={() => lensError ? setLensError(false) : permission?.canAskAgain === false ? Linking.openSettings() : requestCamera()}>
        {lensError ? t("Tekrar dene","Try again") : permission?.canAskAgain === false ? t("Ayarları aç","Open settings") : t("Kamera izni ver","Allow camera")}
      </Control>
    </View> : <>
      {width > 0 && visible.slice(0,3).map((place, i) => {
        const left = Math.max(8, Math.min(width - bubbleWidth - 8, width * place.fraction - bubbleWidth / 2));
        return <Pressable accessibilityRole="button" key={place.id} onPress={() => onSelect(place)}
          style={[styles.bubble, {left, width:bubbleWidth,
            top: (17 + 43 * place.vertical + (visible.length > 1 ? i * 13 : 0)) + '%'}]}>
          <Text style={styles.place}>{place.edge ? edgeArrows[place.edge] + ' ' : ''}{place.name}</Text>
          <Text style={styles.light}>{Math.round(place.distance)} m</Text>
        </Pressable>;
      })}
      <View style={styles.bottom}>
        {previewOrigin && <Text style={styles.place}>{t('Galata denemesi · Örnek konum','Galata demo · Sample location')}</Text>}
        <Text style={styles.light}>{hint}</Text>
        {!previewOrigin && coords && heading !== null && !closest && <Control onPress={onTryDemo}>{t('Galata’yı evden dene','Try Galata from home')}</Control>}
        {pitch === null && !!coords && <Text style={styles.light}>{t("Eğim verisi yok · Yatay takip açık","Tilt unavailable · Horizontal tracking active")}</Text>}
        {!!trackedId && <Control onPress={onStopTracking}>{t("Takibi bırak","Stop tracking")}</Control>}
        {!!issue && <Control onPress={() => setRetry(n => n + 1)}>{t("Yeniden dene","Retry")}</Control>}
        {!!issue && <Control onPress={() => Linking.openSettings()}>{t("Ayarları aç","Open settings")}</Control>}
      </View>
    </>}
    <CameraPhotos camera={camera} ready={active && ready && !!permission?.granted && !lensError}
      onMediaOpen={setPhotosOpen}/>
  </View>;
}
const styles = StyleSheet.create({
  screen:{flex:1,backgroundColor:c.cameraBackground}, top:{flexDirection:'row',alignItems:'flex-start',paddingHorizontal:12,paddingTop:6},
  side:{flex:1,alignItems:'flex-start',paddingTop:6},
  control:{paddingVertical:12,paddingHorizontal:16,backgroundColor:c.cameraPanel,borderRadius:24},
  center:{margin:24,marginTop:'25%',gap:14}, title:{fontSize:30,color:c.surfaceRaised,fontFamily:'serif'},
  light:{fontSize:16,color:c.surface}, bubble:{position:'absolute',backgroundColor:c.cameraPanel,borderWidth:1.5,borderColor:c.primarySoft,borderRadius:26,paddingVertical:9,paddingHorizontal:16},
  place:{color:c.surface,fontSize:17,fontWeight:'600'}, bottom:{position:'absolute',bottom:100,left:16,right:16,gap:6,backgroundColor:c.cameraPanel,borderRadius:16,padding:15}
});
