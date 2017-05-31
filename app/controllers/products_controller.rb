class ProductsController < ApplicationController

  def index
    @products = Product.order('updated_at DESC')

    render json: {products: @products}.to_json
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      render template: '/products/show'
    else
      render json: {success: false, errors: @product.errors.messages}.to_json, status: 422
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render template: '/products/show'
    else
      render json: {success: false, errors: @product.errors.messages}.to_json, status: 422
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :reference, :quantity, :position, :notes)
  end
end
