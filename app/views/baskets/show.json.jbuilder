json.items @basket.each do |item|
  json.id item.id
  json.order_id item.order_id
  json.quantity item.quantity
  json.picked item.picked

  json.position do
    json.id item.position.id
    json.name item.position.name
    json.quantity item.position.quantity
  end

  json.product do
    json.id item.position.product.id
    json.name item.position.product.name
    json.reference item.position.product.reference
  end

end

json.metrics do
  json.order do
    json.id @order.id
    json.reference @order.reference
  end
  json.positions @items.count
  json.count @count
end
