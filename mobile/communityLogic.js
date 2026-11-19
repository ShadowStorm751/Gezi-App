export function contributionPayload({placeId, kind, name, category, pin, note, lang}) {
  const text = {note:note.trim() || null,lang};
  const coords = {lat:pin.latitude,lng:pin.longitude};
  if (!placeId) return {name:name.trim(),category,...coords,...text};
  return {place_id:placeId,kind,...(kind === 'wrong_location' ? coords : {}),...text};
}

export async function deleteConfirmedAccount(client, userId, clearLocal, currentOwner) {
  const {data:{session},error:authError} = await client.auth.getSession();
  if (authError || !session || session.user.id !== userId || currentOwner() !== userId)
    throw Object.assign(new Error('session'),{code:'not_authenticated'});
  // Bind this irreversible request to the account shown in the confirmation.
  const {data,error} = await client.functions.invoke('delete-account',{
    headers:{Authorization:'Bearer '+session.access_token},body:{confirm:'DELETE'}
  });
  if (error || !data?.ok) throw error || new Error('delete-account');
  try {
    await clearLocal(userId);
  } finally {
    if (currentOwner() === userId) {
      const result = await client.auth.signOut({scope:'local'});
      if (result.error) throw result.error;
    }
  }
}
