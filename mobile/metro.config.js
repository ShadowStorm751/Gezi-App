const {getDefaultConfig} = require('expo/metro-config');

const config = getDefaultConfig(__dirname);
config.resolver.resolveRequest = (context, name, platform) => {
  // Supabase uses the device WebSocket. Its Node-only fallback still enters Metro's graph.
  if (name === 'ws' && (platform === 'ios' || platform === 'android')) {
    const options = {...context, unstable_conditionNames:[...(context.unstable_conditionNames || []), 'browser']};
    return context.resolveRequest(options, name, platform);
  }
  return context.resolveRequest(context, name, platform);
};
module.exports = config;
