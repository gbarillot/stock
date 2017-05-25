class PositionsController < ApplicationController

  layout false

  def index
    @items = Position.where('product_id IS NOT NULL')
    @count = Position.where('product_id IS NOT NULL').sum('quantity')
    @positions = Position.where(['product_id IS NOT NULL']).order('updated_at DESC').limit(20)
  end

  def show
    @position = Position.find(params[:id])
  end

  def autocomplete
    @positions = Position.autocomplete(params[:q])

    render template: '/positions/index'
  end

  def create
    @position = Position.link(position_params)

    if @position.errors.any?
      render json: {errors: @position.errors}.to_json, status: 422
    else
      render action: :show
    end
  end

private
  def position_params
    params.require(:position).permit(:product_id, :quantity, :name)
  end

end
