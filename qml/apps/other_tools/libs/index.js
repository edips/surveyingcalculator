//---------INDEX FINDER-------------
function find(model, criteria) {
  for(var i = 0; i < model.count; ++i) if (criteria(model.get(i))) return i
  return null
}
