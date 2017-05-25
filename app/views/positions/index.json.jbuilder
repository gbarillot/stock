json.positions @positions.each do |position|
  json.id position.id
  json.name position.name
  json.quantity position.quantity

  json.product do
    json.id position.product.id
    json.name position.product.name
    json.reference position.product.reference
    json.ean13 position.product.ean13
  end
end

json.metrics do
  json.positions @items.count
  json.count @count
end
