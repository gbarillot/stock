class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth

private
  def basic_auth
    if ['production'].include? Rails.env
      authenticate_or_request_with_http_basic do |username, password|
        username == "labofill" && password == "stock"
      end
    end
  end
end
