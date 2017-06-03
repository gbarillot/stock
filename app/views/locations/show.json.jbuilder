json.locations @locations.each do |location|
  json.id location.id
  json.name location.name.split(' ').last
  json.quantity location.quantity
  json.slug location.name.parameterize
  json.level location.level
  json.kind location.product_id ? 'position' : 'node'

  if location.level == 0
    json.type "Allée"
  elsif location.level == 1
    json.type "Rack"
  elsif location.level == 2
    json.type "Etage"
  elsif location.level == 3
    json.type "Emplacement"
  end
end

json.level @level
json.tree locations_tree(params[:slug])
