class UsersController < ApplicationController

  layout false

  def index
    @users = User.all.select(:id, :first_name, :last_name)

    render json: @users.to_json
  end

private
  def order_params
    params.require(:order).permit(:reference, :name, :user_id, :due_at).merge(created_by: current_user.id)
  end

end
