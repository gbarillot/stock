json.positions @basket.each do |thing|
  json.id thing.position.id
  json.name thing.position.name
  json.quantity thing.quantity

  json.product do
    json.id thing.position.product.id
    json.name thing.position.product.name
    json.reference thing.position.product.reference
  end
end

json.metrics do
  json.order_reference @order.reference
  json.positions @items.count
  json.count @count
end
