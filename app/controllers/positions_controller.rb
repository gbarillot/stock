class PositionsController < ApplicationController

  layout false

  def index
    @positions = Position.joins(:product).where(['product_id IS NOT NULL AND products.reference != ?', '0000']).order('updated_at DESC').limit(20)
    @items = Position.where('product_id IS NOT NULL')
    @count = Position.where('product_id IS NOT NULL').sum('quantity')
  end

  def show
    @position = Position.find(params[:id])
  end

  def available
    if params[:id].to_i > 0 && params[:quantity].to_i > 0
      @positions = Position.where(['free >= ? AND product_id IS NOT NULL AND (product_id = ? OR quantity = ?)', params[:quantity], params[:id], 0])
    else
      @positions = []
    end

    render json: @positions.to_json
  end

  def autocomplete
    @positions = Position.autocomplete(params[:q])
    @items = @positions
    @count = @positions.sum('quantity')

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
