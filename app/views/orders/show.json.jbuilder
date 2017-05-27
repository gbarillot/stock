json.orders @orders.each do |order|
  json.id order.id
  json.reference order.reference
  json.created_at order.created_at
  json.updated order.updated_at
  json.due_at l(order.due_at)
  json.user_name order.user.full_name
  json.state_name I18n.t(order.state, scope: 'states')
  json.state order.state
  json.klass order.state_klass
  json.count order.baskets.sum('quantity')
  json.references order.baskets.count
end
