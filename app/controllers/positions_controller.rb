class PositionsController < ApplicationController

  layout false

  def index
    @positions = Position.joins(:product).where(['product_id IS NOT NULL AND products.id != ?', 0]).order('updated_at DESC').limit(20)
    @items = Position.where('product_id IS NOT NULL')
    @count = Position.where('product_id IS NOT NULL').sum('quantity')
  end

  def show
    @position = Position.find(params[:id])
  end

  def create
    @position = Position.find(params[:id])

    if @position.errors.any?
      render json: {errors: @position.errors}.to_json, status: 422
    else
      render action: :show
    end
  end

  def update
    render json: {old: '123', new: '456', quantity: 12}.to_json
  end

private
  def position_params
    params.require(:position).permit(:product_id, :quantity, :name)
  end

end
