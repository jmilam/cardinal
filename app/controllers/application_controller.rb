class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :api_url
  # attr_accessor :user

  def api_url
  	if Rails.env == "test"
			@api_url = "http://webapidev.enduraproducts.com/api/endura"
		elsif Rails.env == "development"
			@api_url = "http://webapidev.enduraproducts.com/api/endura"
		elsif Rails.env == "production"
			@api_url = "http://webapi.enduraproducts.com/api/endura"
		end
  end


end
