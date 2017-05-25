class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth

private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      if username == "labofill" && password == "guillaume"
        session[:current_user] = "guillaume"
      elsif username == "labofill" && password == "cédric"
        session[:current_user] = "guillaume"
      end
    end
  end
end
