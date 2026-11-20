import {c} from './theme';
import React, {useState} from 'react';
import {Alert, Image, Linking, StyleSheet, Text, View} from 'react-native';
import {webUrl} from './catalog';
import {client, t} from './client';

const symbols = {
  mosque:'🕌', church:'⛪', synagogue:'🕍', tomb:'🏛', palace:'🏰', museum:'🏛', fortress:'🏰',
  tower:'🗼', cistern:'💧', monument:'🗿', archaeological_site:'🏺', viewpoint:'🌄',
  hill:'⛰', forest:'🌲', park:'🌳', beach:'🏖', island:'🏝', waterfall:'💧',
};

function Placeholder({place, compact}) {
  return <View style={[styles.placeholder, compact ? styles.small : styles.large]}>
    <Text accessible={false} style={{fontSize:compact ? 24 : 38}}>{symbols[place.category] || '📍'}</Text>
    {!compact && <Text style={styles.credit}>{place.categoryLabel || place.category}</Text>}
  </View>;
}

export function PlaceThumbnail({place}) {
  const [failed,setFailed] = useState(null);
  if (!place.thumbnail || failed === place.thumbnail) return <Placeholder compact place={place}/>;
  return <View style={styles.thumb}>
    <Image source={{uri:place.thumbnail}} style={styles.small} onError={() => setFailed(place.thumbnail)}/>
    <Text numberOfLines={1} adjustsFontSizeToFit style={styles.smallCredit}>{t('Foto: Wikimedia Commons','Photo: Wikimedia Commons')}</Text>
  </View>;
}

function CreditLink({url, children}) {
  if (!webUrl(url)) return <Text>{children}</Text>;
  return <Text accessibilityRole="link" style={styles.link} onPress={() => Linking.openURL(url).catch(() =>
    Alert.alert(t('Bağlantı açılamadı','Could not open link')))}>{children}</Text>;
}

function DetailPhoto({photo, place}) {
  const storageUrl = photo.storage_path && client?.storage.from('place-photos').getPublicUrl(photo.storage_path).data.publicUrl;
  const sources = [...new Set([webUrl(photo.url), webUrl(photo.thumb_url), storageUrl].filter(Boolean))];
  const [attempt,setAttempt] = useState(0);
  const uri = sources[attempt];
  if (!uri) return <Placeholder place={place}/>;
  return <View style={styles.figure}>
    <Image key={uri} source={{uri}} accessibilityLabel={place.name} style={styles.large}
      onError={() => setAttempt(attempt + 1)}/>
    <Text style={styles.credit}>{t('Foto: ','Photo: ')}
      <CreditLink url={photo.source_url}>{photo.author}</CreditLink>{' · '}
      <CreditLink url={photo.license_url}>{photo.license}</CreditLink>
    </Text>
  </View>;
}

export function PlaceGallery({place}) {
  if (!place.photos?.length) return <Placeholder place={place}/>;
  return place.photos.map((photo,i) => <DetailPhoto key={place.id + ':' + (photo.url || photo.storage_path || photo.thumb_url) + ':' + i}
    photo={photo} place={place}/>);
}

const styles = StyleSheet.create({
  figure:{gap:5}, thumb:{width:82,gap:3}, small:{width:82,height:58,borderRadius:8},
  smallCredit:{fontSize:10,lineHeight:12,color:c.inkMuted}, credit:{fontSize:13,color:c.inkMuted},
  large:{width:'100%',height:190,borderRadius:12,backgroundColor:c.surfaceSunken},
  placeholder:{alignItems:'center',justifyContent:'center',backgroundColor:c.surfaceSunken,gap:6},
  link:{textDecorationLine:'underline',color:c.primary}
});
