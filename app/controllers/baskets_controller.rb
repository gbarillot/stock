class BasketsController < ApplicationController

  layout false

  def show
    @order = Order.find(params[:order_id])
    @basket = Basket.where(['order_id = ?', params[:order_id]])
    @items = @basket
    @count = @basket.sum('quantity')
  end

  def create
    record = Basket.new(
      position_id: params[:position_id],
      order_id: params[:order_id],
      quantity: params[:quantity]
    )

    if record.save
      render json: record.to_json
    else
      render json: {errors: record.errors}.to_json, status: 422
    end
  end

  def destroy
    records = Basket.where([
      'position_id = ? AND order_id = ?', params[:position_id], params[:order_id]
    ])

    if records.destroy_all
      render json: {success: true}.to_json
    else
      render json: {errors: records.errors}.to_json, status: 422
    end
  end

end
