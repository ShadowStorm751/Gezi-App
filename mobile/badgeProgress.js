// Only use rules whose place metadata is known. The server supplies all counts.
function badgeForPlace(place) {
  if (place.periodCode === 'Osmanlı') return 'ottoman-heritage';
  if (place.periodCode === 'Bizans') return 'byzantine-traveler';
  return {tomb:'sultans-rest',mosque:'mosque-wanderer',museum:'museum-lover',palace:'palace-life'}[place.category];
}
module.exports = {badgeForPlace};
