import React from 'react';
import {registerRootComponent} from 'expo';
import {SafeAreaProvider} from 'react-native-safe-area-context';
import App from './App';
import {useFonts} from 'expo-font';
import {Fraunces_600SemiBold} from '@expo-google-fonts/fraunces/600SemiBold';
import {DMSans_400Regular} from '@expo-google-fonts/dm-sans/400Regular';
import {DMSans_500Medium} from '@expo-google-fonts/dm-sans/500Medium';
import {DMSans_600SemiBold} from '@expo-google-fonts/dm-sans/600SemiBold';
import {DMSans_700Bold} from '@expo-google-fonts/dm-sans/700Bold';
import {ActivityIndicator,View} from 'react-native';
import {c} from './theme';

function Root() {
  const [loaded,error] = useFonts({Fraunces_600SemiBold,DMSans_400Regular,DMSans_500Medium,DMSans_600SemiBold,DMSans_700Bold});
  if (!loaded && !error) return <View style={{flex:1,justifyContent:'center',backgroundColor:c.surface}}><ActivityIndicator color={c.primary}/></View>;
  return <SafeAreaProvider><App/></SafeAreaProvider>;
}

registerRootComponent(Root);
