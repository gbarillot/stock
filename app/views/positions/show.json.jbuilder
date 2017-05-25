total = 0
json.position do
  json.id @position.id
  json.name @position.name
  json.quantity @position.quantity
  total += @position.quantity

  json.product do
    json.id @position.product.id
    json.name @position.product.name
    json.reference @position.product.reference
    json.ean13 @position.product.ean13
  end
end

json.metrics do
  json.count total
  json.created_at @position.created_at
  json.updated_at @position.updated_at
end
