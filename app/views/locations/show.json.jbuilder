json.positions @positions.each do |position|
  json.id position.id
  json.name position.name
  json.quantity position.quantity
  json.location position.name.parameterize

  json.product do
    json.id position.product.id
    json.name position.product.name.truncate(25)
    json.reference position.product.reference
    json.ean13 position.product.ean13
  end
end

json.tree full_tree(params[:slug])

json.metrics do
  json.positions @items.count
  json.count @count
end
