import React, {useState} from 'react';
import {Alert, Image, Switch, Text, TextInput, View} from 'react-native';
import * as ImagePicker from 'expo-image-picker';
import {ImageManipulator, SaveFormat} from 'expo-image-manipulator';
import {client,t} from './client';
import {Action,Feedback,rpc,ui,useAction,useQuery} from './ScreenUI';
import {Submissions} from './Contributions';
import {deleteConfirmedAccount} from './communityLogic';

export function Avatar({path,size=48}) {
  if (!path) return null;
  return <Image source={{uri:client.storage.from('avatars').getPublicUrl(path).data.publicUrl}}
    style={{width:size,height:size,borderRadius:size/2}}/>;
}

export default function Profile({visits,onSocial,onClose}) {
  const account = useQuery('update_profile',{},visits.userId);
  const [edited,setEdited] = useState(null);
  const [username,setUsername] = useState(null);
  const action = useAction();
  const profile = edited ?? account.data;
  const currentName = username ?? profile?.username ?? '';
  async function save(change) {
    const updated = await rpc('update_profile',change);
    if (!updated?.id) throw new Error('profile');
    setEdited(updated);
    setUsername(null);
  }
  function photo() {
    action.run(async () => {
      const picked = await ImagePicker.launchImageLibraryAsync({mediaTypes:['images'],allowsEditing:true,aspect:[1,1]});
      if (picked.canceled) return;
      const asset = picked.assets[0];
      const edge = Math.min(asset.width,asset.height);
      const context = ImageManipulator.manipulate(asset.uri);
      context.crop({originX:Math.floor((asset.width-edge)/2),originY:Math.floor((asset.height-edge)/2),width:edge,height:edge});
      context.resize({width:512,height:512});
      const rendering = await context.renderAsync();
      const jpg = await rendering.saveAsync({format:SaveFormat.JPEG,compress:0.82,base64:true});
      const bytes = Uint8Array.from(atob(jpg.base64),c => c.charCodeAt(0));
      const path = visits.userId+'/avatar-'+Date.now()+'.jpg';
      if (visits.owner.current !== visits.userId) return;
      const bucket = client.storage.from('avatars');
      const upload = await bucket.upload(path,bytes.buffer,{contentType:'image/jpeg'});
      if (upload.error) throw upload.error;
      await save({avatar_path:path});
    });
  }
  function confirmDelete() {
    Alert.alert(t('Hesabını silmek istiyor musun?','Delete your account?'),
      t('Profilin, fotoğrafın, rozetlerin ve ziyaretlerin kalıcı olarak silinecek. Bu işlem geri alınamaz.',
        'Your profile, avatar, badges and visits will be permanently deleted. This cannot be undone.'),
      [{text:t('Vazgeç','Cancel'),style:'cancel'},{text:t('Hesabımı sil','Delete my account'),style:'destructive',onPress:() => action.run(async () => {
        await deleteConfirmedAccount(client,visits.userId,visits.clearLocal,() => visits.owner.current);
        onClose();
        Alert.alert(t('Hesabın silindi.','Your account was deleted.'));
      })}]);
  }
  return <><Feedback query={account}/>
    {profile && <View style={ui.card}><Avatar path={profile.avatar_path} size={84}/>
      <Action disabled={action.busy} onPress={photo}>{t('Profil fotoğrafı seç','Choose profile photo')}</Action>
      <Text>{t('Kullanıcı adı (3–20 küçük harf, rakam veya alt çizgi)','Username (3–20 lowercase letters, numbers or underscores)')}</Text>
      <TextInput value={currentName} onChangeText={setUsername} style={ui.input} autoCapitalize="none" autoCorrect={false} maxLength={20}/>
      <Action disabled={action.busy || !/^[a-z0-9_]{3,20}$/.test(currentName) || currentName === profile.username}
        onPress={() => action.run(() => save({username:currentName}))}>{t('Kullanıcı adını kaydet','Save username')}</Action>
      <View style={ui.row}><Switch accessibilityLabel={t('Profilim herkese açık','Public profile')} value={!!profile.is_public} disabled={action.busy}
        onValueChange={value => action.run(() => save({is_public:value}))}/><Text>{t('Profilim herkese açık','Public profile')}</Text></View>
      <Text style={ui.muted}>{t('Kapalıysa seni yalnızca tam kullanıcı adınla bulabilirler.','When off, people can only find you by your exact username.')}</Text>
    </View>}
    <Action onPress={onSocial}>{t('Arkadaşlar ve sıralama','Friends and rankings')}</Action>
    <Submissions userId={visits.userId}/>
    {!!action.message && <Text accessibilityLiveRegion="polite">{action.message}</Text>}
    <Action danger disabled={action.busy} onPress={confirmDelete}>{t('Hesabımı sil','Delete my account')}</Action>
  </>;
}
