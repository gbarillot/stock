class PositionsController < ApplicationController

  layout false

  def index
    @positions = Position.joins(:product)
                         .where(['product_id IS NOT NULL AND products.id != ?', 0])
                         .order('updated_at DESC')
                         .limit(20)
    @items = Position.where('product_id IS NOT NULL AND product_id != 0')
    @count = Position.where('product_id IS NOT NULL AND product_id != 0').sum('quantity')
  end

  def show
    @position = Position.find(params[:id])
  end

  def list
    @positions = Position.joins(:product).where("product_id IS NOT NULL AND products.reference != '0000' AND positions.name ILIKE (?)", "#{params[:slug].gsub('-', ' ')}%")
    @items = @positions
    @count = @positions.sum('quantity')
  end

  def create
    @position = Position.find(params[:id])
    @position.update_attributes(
      product_id: params[:product_id],
      quantity: params[:quantity]
    )

    if @position.errors.any?
      render json: {errors: @position.errors}.to_json, status: 422
    else
      render json: {success: true}.to_json
    end
  end

  def update
    origin = Position.find(params[:id]).move(to: params[:destination], quantity: params[:quantity])
    target = Position.find(params[:destination])

    render json: {old: origin.name, new: target.name, quantity: params[:quantity]}.to_json
  end

private
  def position_params
    params.require(:position).permit(:product_id, :quantity, :name)
  end

end
