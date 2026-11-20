// mobile/theme.js — Gezi tasarım sistemi (docs/TASARIM.md). Ekranlarda çıplak renk kodu kullanma.
export const colors = {
  light: {
    surface: '#FAF6EE',
    surfaceRaised: '#FFFFFF',
    surfaceSunken: '#F1EBDD',
    line: '#E2DACA',
    ink: '#16302B',
    inkMuted: '#56665F',
    primary: '#1F5A4F',
    onPrimary: '#FFFFFF',
    primarySoft: '#DCEBE4',
    primaryInk: '#1F5A4F',
    accent: '#B9502A',
    onAccent: '#FFFFFF',
    accentSoft: '#F6E0D3',
    accentInk: '#8E3A1B',
    gold: '#C9973A',
    goldSoft: '#F5E8CC',
    goldInk: '#7A5414',
    sea: '#2D6A88',
    seaSoft: '#DCEAF1',
    danger: '#B3261E',
    scrim: '#0B1A1766',
  },
  dark: {
    surface: '#111E1B',
    surfaceRaised: '#192A26',
    surfaceSunken: '#21342F',
    line: '#2D433D',
    ink: '#F2EDE2',
    inkMuted: '#A7B5AF',
    primary: '#7FC4B2',
    onPrimary: '#0D1D19',
    primarySoft: '#1C3A33',
    primaryInk: '#9AD6C6',
    accent: '#EE8B5E',
    onAccent: '#1C0D06',
    accentSoft: '#3B2418',
    accentInk: '#F4A983',
    gold: '#E1B865',
    goldSoft: '#3A2E16',
    goldInk: '#EBC77E',
    sea: '#8CC3DD',
    seaSoft: '#17303B',
    danger: '#F2B8B5',
    scrim: '#00000099',
  },
};
export const fonts = {
  display: 'Fraunces_600SemiBold',
  regular: 'DMSans_400Regular',
  medium: 'DMSans_500Medium',
  semibold: 'DMSans_600SemiBold',
  bold: 'DMSans_700Bold',
};
export const type = {
  display:   {fontFamily: fonts.display,  fontSize: 34, lineHeight: 38, letterSpacing: -0.5},
  title:     {fontFamily: fonts.display,  fontSize: 26, lineHeight: 30},
  heading:   {fontFamily: fonts.display,  fontSize: 20, lineHeight: 26},
  cardTitle: {fontFamily: fonts.display,  fontSize: 18, lineHeight: 23},
  bodyLg:    {fontFamily: fonts.regular,  fontSize: 17, lineHeight: 26},
  body:      {fontFamily: fonts.regular,  fontSize: 15, lineHeight: 22},
  label:     {fontFamily: fonts.semibold, fontSize: 14, lineHeight: 18},
  caption:   {fontFamily: fonts.medium,   fontSize: 12, lineHeight: 16},
  eyebrow:   {fontFamily: fonts.bold,     fontSize: 11, lineHeight: 14, letterSpacing: 1.2}, // metni toLocaleUpperCase(lang) ile çevir
};
export const space = {1: 4, 2: 8, 3: 12, 4: 16, 5: 20, 6: 24, 8: 32, 12: 48};
export const radius = {sm: 8, md: 14, lg: 20, xl: 28, pill: 999};
export const shadow = {
  card: {shadowColor: '#16302B', shadowOpacity: 0.08, shadowRadius: 12, shadowOffset: {width: 0, height: 6}, elevation: 3},
  sheet: {shadowColor: '#16302B', shadowOpacity: 0.12, shadowRadius: 16, shadowOffset: {width: 0, height: -4}, elevation: 6},
  pin: {shadowColor: '#16302B', shadowOpacity: 0.2, shadowRadius: 3, shadowOffset: {width: 0, height: 2}, elevation: 2},
};
export const c = {...colors.light, cameraPanel:'#173B39ED', cameraBackground:'#112B2C', north:'#FF8773', celebrationText:'#C9D3CE', ring:colors.dark.gold, clear:'transparent'};
