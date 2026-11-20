import React, {useEffect, useRef, useState} from 'react';
import {ActivityIndicator, Alert, Image, Linking, Modal, Platform, Pressable, StyleSheet, Text, View} from 'react-native';
import {SafeAreaView} from 'react-native-safe-area-context';
import Svg, {Circle, Path, Rect} from 'react-native-svg';
import * as ImagePicker from 'expo-image-picker';
import * as MediaLibrary from 'expo-media-library';
import {t} from './client';

export default function CameraPhotos({camera, ready, onMediaOpen}) {
  const [photo, setPhoto] = useState(null);
  const [busy, setBusy] = useState(false);
  const [lastShot, setLastShot] = useState(null);
  const lock = useRef(false);
  const mounted = useRef(true);
  useEffect(() => {
    mounted.current = true;
    return () => { mounted.current = false; };
  }, []);

  async function run(action, failure) {
    if (lock.current) return;
    lock.current = true;
    setBusy(true);
    try { await action(); }
    catch { if (mounted.current) Alert.alert(failure); }
    finally {
      lock.current = false;
      if (mounted.current) setBusy(false);
    }
  }

  function closePreview() {
    if (lock.current) return;
    setPhoto(null);
    onMediaOpen(false);
  }

  function takePhoto() {
    if (!ready || !camera.current) return;
    run(async () => {
      const shot = await camera.current.takePictureAsync({quality:0.9});
      if (!shot?.uri) throw new Error('capture');
      if (!mounted.current) return;
      setPhoto({uri:shot.uri, captured:true});
      onMediaOpen(true);
    }, t('Fotoğraf çekilemedi. Tekrar dene.', 'Could not take the photo. Try again.'));
  }

  function openGallery() {
    run(async () => {
      onMediaOpen(true);
      let selected = false;
      try {
        const result = await ImagePicker.launchImageLibraryAsync({mediaTypes:['images'], allowsEditing:false});
        const uri = result.assets?.[0]?.uri;
        if (!result.canceled && uri && mounted.current) {
          selected = true;
          setPhoto({uri, captured:false});
        }
      } finally {
        if (!selected && mounted.current) onMediaOpen(false);
      }
    }, t('Galeri açılamadı. Tekrar dene.', 'Could not open the gallery. Try again.'));
  }

  function savePhoto() {
    if (!photo?.captured) return;
    run(async () => {
      if (Platform.OS === 'ios' || Number(Platform.Version) < 33) {
        const access = await MediaLibrary.requestPermissionsAsync(true, []);
        if (!mounted.current) return;
        if (!access.granted) {
          const buttons = [{text:t('Tamam','OK')}];
          if (!access.canAskAgain) buttons.push({text:t('Ayarları aç','Open settings'),onPress:() => Linking.openSettings()});
          Alert.alert(t('Kaydetme izni gerekli','Permission needed to save'),
            t('Fotoğrafı galeriye eklemek için izin ver.','Allow Gezi to add this photo to your library.'), buttons);
          return;
        }
      }
      await MediaLibrary.Asset.create(photo.uri);
      if (!mounted.current) return;
      setLastShot(photo.uri);
      setPhoto(null);
      onMediaOpen(false);
      Alert.alert(t('Fotoğraf galeriye kaydedildi.','Photo saved to your gallery.'));
    }, t('Fotoğraf kaydedilemedi. Tekrar dene.', 'Could not save the photo. Try again.'));
  }

  return <>
    <View style={styles.controls} pointerEvents="box-none">
      <Pressable accessibilityRole="button" accessibilityLabel={t('Galeriyi aç','Open gallery')}
        disabled={busy} onPress={openGallery} style={styles.gallery}>
        {lastShot ? <Image source={{uri:lastShot}} style={styles.thumbnail}/> :
          <Svg width={26} height={26} viewBox="0 0 24 24" fill="none" stroke="#FAF7F0" strokeWidth={1.7}>
            <Rect x={2} y={3} width={20} height={18} rx={3}/><Circle cx={8} cy={9} r={1.5}/><Path d="m3 18 6-6 4 4 3-3 5 5"/>
          </Svg>}
      </Pressable>
      <Pressable accessibilityRole="button" accessibilityLabel={t('Fotoğraf çek','Take photo')}
        accessibilityState={{disabled:!ready || busy}} disabled={!ready || busy} onPress={takePhoto}
        style={[styles.shutter, (!ready || busy) && {opacity:0.55}]}>
        {busy ? <ActivityIndicator color="white"/> : <View style={styles.disc}/>}
      </Pressable>
    </View>
    <Modal visible={!!photo} animationType="fade" onRequestClose={closePreview}>
      {photo && <SafeAreaView style={styles.preview}>
        <Image source={{uri:photo.uri}} style={styles.image} resizeMode="contain" accessibilityLabel={t('Fotoğraf önizlemesi','Photo preview')}/>
        <View style={styles.actions}>
          <Pressable accessibilityRole="button" disabled={busy} onPress={closePreview} style={styles.button}>
            <Text style={styles.label}>{t('Kameraya dön','Back to camera')}</Text>
          </Pressable>
          {photo.captured && <Pressable accessibilityRole="button" disabled={busy} onPress={savePhoto} style={styles.save}>
            {busy ? <ActivityIndicator color="#143C38"/> : <Text style={styles.saveLabel}>{t('Galeriye kaydet','Save to gallery')}</Text>}
          </Pressable>}
        </View>
      </SafeAreaView>}
    </Modal>
  </>;
}

const styles = StyleSheet.create({
  controls:{position:'absolute',bottom:16,left:18,right:18,height:72,alignItems:'center',justifyContent:'center'},
  shutter:{width:70,height:70,borderRadius:35,borderWidth:3,borderColor:'#FAF7F0',alignItems:'center',justifyContent:'center',backgroundColor:'#143C3899'},
  disc:{width:54,height:54,borderRadius:27,backgroundColor:'#FAF7F0'},
  gallery:{position:'absolute',left:0,width:50,height:50,borderRadius:13,overflow:'hidden',backgroundColor:'#143C38',alignItems:'center',justifyContent:'center'},
  thumbnail:{width:'100%',height:'100%'}, preview:{flex:1,backgroundColor:'#101716'}, image:{flex:1,width:'100%'},
  actions:{flexDirection:'row',flexWrap:'wrap',alignItems:'center',justifyContent:'center',gap:12,padding:16},
  button:{padding:14}, save:{padding:14,borderRadius:16,backgroundColor:'#FAF7F0'}, label:{color:'#FAF7F0',fontWeight:'600'},
  saveLabel:{color:'#143C38',fontWeight:'700'}
});
