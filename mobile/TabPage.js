import React from 'react';
import {ScrollView, StyleSheet, Text, View} from 'react-native';
import {c, radius, space, type} from './theme';
import {eyebrow, upper} from './PlaceUI';

export default function TabPage({title, location, children}) {
  return <ScrollView style={styles.page} contentContainerStyle={styles.content}
    keyboardShouldPersistTaps="handled">
    <View style={styles.header}>
      {!!location && <Text style={eyebrow}>{upper(location)}</Text>}
      <Text accessibilityRole="header" style={styles.title}>{title}</Text>
    </View>
    {children}
  </ScrollView>;
}

export const panel = {
  padding:space[4], gap:space[3], borderRadius:radius.lg,
  backgroundColor:c.surfaceRaised, borderColor:c.line, borderWidth:1,
};
const styles = StyleSheet.create({
  page:{flex:1, backgroundColor:c.surface},
  content:{padding:space[5], paddingBottom:space[8], gap:space[4]},
  header:{gap:space[1]},
  title:{...type.display, color:c.ink},
});
