require "test_helper"

feature "#show" do

  scenario "Create new product" do
    post "/products", {
      product: {
        name: "name",
        reference: "reference",
        quantity: "2",
        position: "a1b2"
      }
    }

    response = jsonify(last_response.body)
    assert_equal true, response[:success]
  end

  scenario "validation on name" do
    post "/products", {
      product: {
        name: "",
        reference: "reference",
        quantity: "2",
        position: "a1b2"
      }
    }

    response = jsonify(last_response.body)
    assert_equal false, response[:success]
  end
end
