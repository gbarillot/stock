class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :spread_user

private
  def spread_user
    $current_user = current_user
  end

end
