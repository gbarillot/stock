class UsersController < ApplicationController

  layout false

  def index
    @users = User.all.select(:id, :first_name, :last_name)
  end

  def show
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)

    if params[:user][:password].blank?
      if @user.update_attributes(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
        render action: :show
      else
        render json: {errors: @user.errors.messages}.to_json, status: 422
      end
    else
      if @user.update_attributes(user_params)
        render action: :show
      else
        render json: {errors: @user.errors.messages}.to_json, status: 422
      end
    end
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

end
