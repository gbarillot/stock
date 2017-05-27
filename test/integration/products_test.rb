require "test_helper"

feature "#show" do

  before do
    @user = users(:employee)
    login_as @user
  end

  scenario "fetch all products" do
    get "/products"

    response = jsonify(last_response.body)
    assert_equal 200, last_response.status
    assert_equal 2, response[:products].length
    assert_equal '123456', response[:products].first[:reference]
    assert_equal '6789', response[:products].second[:reference]
  end

end
