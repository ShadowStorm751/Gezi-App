import 'react-native-url-polyfill/auto';
import AsyncStorage from '@react-native-async-storage/async-storage';
import {createClient} from '@supabase/supabase-js';
import {getLocales} from 'expo-localization';
import type {Lang} from './catalog';

export const lang:Lang = getLocales()[0]?.languageCode === 'en' ? 'en' : 'tr';
export const t = (tr:string,en:string) => lang === 'en' ? en : tr;
export const project = process.env.EXPO_PUBLIC_SUPABASE_URL || '';
const key = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '';
export const demo = !project && !key;
function connect() {
  if (!project || !key) return null;
  try {
    return createClient(project,key,{auth:{storage:AsyncStorage,autoRefreshToken:true,persistSession:true,detectSessionInUrl:false}});
  } catch { return null; }
}
export const client = connect();
export {AsyncStorage};
