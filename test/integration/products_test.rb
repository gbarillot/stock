require "test_helper"

feature "#show" do

  scenario "fetch all products" do
    get "/products"
    out = {
      success: true,
      products: [
        {name: "First product", reference: "1234"},
        {name: "Second product", reference: "5678"}
    ]}

    response = jsonify(last_response.body)
    assert_equal true, response[:success]
    assert_equal out, response
  end

end
