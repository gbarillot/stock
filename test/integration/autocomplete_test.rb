require "test_helper"

feature "#autocomplete" do

  before do
    login_as users(:employee)

    Position.create!(name: 'a', level: 0, quantity: 8, product_id: nil, free: 10)
    Position.create!(name: 'a 1', level: 1, quantity: 6, product_id: nil, free: 8)
    Position.create!(name: 'a 1 23', level: 2, quantity: 4, product_id: nil, free: 6)
    @position = Position.create!(name: 'a 1 23 4', level: 3, quantity: 2, product_id: 0, free: 5)
    @position.insert(product_id: products(:product_1).id, quantity: 2)
  end

  scenario "products" do
    get "/autocomplete/products", q: '123', format: :json

    response = jsonify(last_response.body)
    assert_equal 200, last_response.status
    assert_equal 1, response[:products].length
    assert_equal '123456', response[:products].first[:reference]
  end

  scenario "positions" do
    get "/autocomplete/positions", q: products(:product_1).reference, format: :json

    response = jsonify(last_response.body)
    assert_equal 200, last_response.status
    assert_equal 1, response[:positions].length
    assert_equal @position.id, response[:positions].first[:id]
    assert_equal '123456', response[:positions].first[:product][:reference]
  end

  scenario "availabilities" do
    @new_position = Position.create!(name: 'a 1 23 5', level: 3, quantity: 2, product_id: 0, free: 5)
    get "/autocomplete/availabilities", id: @position.id, quantity: 1, format: :json

    response = jsonify(last_response.body)
    assert_equal 200, last_response.status
    assert_equal 1, response[:positions].length
    assert_equal @new_position.id, response[:positions].first[:id]
    assert_equal 0, response[:positions].first[:product][:reference]
  end

end
