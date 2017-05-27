class OrdersController < ApplicationController

  layout false

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order.to_json
    else
      render json: {errors: @order.errors}.to_json, status: 422
    end
  end

  def show
    if params[:id] == 'all'
      @orders = Order.all.order('due_at ASC')
    end
    if params[:id] == 'me'
      @orders = Order.where(['user_id = ?', current_user.id]).order('due_at ASC')
    end
  end

  def update
    order = Order.find(params[:id])

    if order.update_attributes(order_params)
      @orders = [order]
      render template: '/orders/show'
    end
  end

private
  def order_params
    begin
      due_date_time = DateTime.parse("#{params[:order][:due_date]} #{params[:order][:due_hour]}:#{params[:order][:due_minutes]}")
    rescue
      due_date_time = nil
    end

    if params[:order][:created_by]
      params.require(:order).permit(:reference, :name, :user_id, :due_at, :state)
        .merge(created_by: current_user.id)
    elsif params[:order][:due_date]
      params.require(:order).permit(:reference, :name, :user_id, :due_at, :state)
        .merge(due_at: due_date_time)
    elsif params[:order][:created_by] && params[:order][:due_date]
      params.require(:order).permit(:reference, :name, :user_id, :due_at, :state)
        .merge(due_at: due_date_time)
        .merge(created_by: current_user.id)
    else
      params.require(:order).permit(:reference, :name, :user_id, :due_at, :state)
    end
  end

end
