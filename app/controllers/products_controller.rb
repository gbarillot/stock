class ProductsController < ApplicationController

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: {success: true}.to_json
    else
      render json: {success: false, errors: @product.errors.messages}.to_json, status: 422
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :reference, :quantity, :position)
  end
end
