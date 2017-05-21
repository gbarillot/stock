total = 0
json.products @products.each do |product|
  json.id product.id
  json.name product.name
  json.reference product.reference
  json.quantity product.quantity
  total += product.quantity
  json.position product.position
end

json.total @products.length
json.items total
