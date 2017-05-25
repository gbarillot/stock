class ProductsController < ApplicationController

  def index
    @products = Position.all.order('updated_at DESC')

    render json: {products: @products}.to_json
  end

  def show
    @product = Product.find(params[:id])
  end

  def autocomplete
    @products = Product.autocomplete(params[:q])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      render json: {success: true}.to_json
    else
      render json: {success: false, errors: @product.errors.messages}.to_json, status: 422
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: {
        success: true,
        product: {
          name: @product.name,
          reference: @product.reference,
          quantity: @product.quantity,
          position: @product.position
        }
      }.to_json
    else
      render json: {success: false, errors: @product.errors.messages}.to_json, status: 422
    end
  end

private
  def product_params
    params.require(:product).permit(:name, :reference, :quantity, :position, :notes)
  end
end
