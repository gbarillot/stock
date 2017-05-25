total = 0
json.product do
  json.id @product.id
  json.created_at @product.created_at
  json.updated_at @product.updated_at
  json.name @product.name
  json.reference @product.reference
  json.ean13 @product.ean13
  json.quantity @product.quantity

  json.positions @product.positions.each do |position|
    json.id position.id
    json.name position.name
    json.quantity position.quantity
    total += position.quantity
  end
end

json.metrics do
  json.count total
  json.positions 1
end
