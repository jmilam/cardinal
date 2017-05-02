class LoginController < ApplicationController
	require 'net/http'
  def index
  end

  def create
  	begin
	  	login = Login.new
	  	login.validate_fields(params[:login])

	  	uri = URI.parse("#{@api_url}/login")
	  	uri.query = URI.encode_www_form(params[:login])
			response = Net::HTTP.get_response(uri)

			if JSON.parse(response.body)["success"]
				flash[:notice] = "Welcome to cardinal #{params[:login][:username]}!"
				session[:logged_in] = true
				session[:username] = params[:login][:username]
				session[:site] = params[:login][:site]
				session[:printer] = params[:login][:printer]
				redirect_to main_menu_index_path
			else
				flash[:error] = "Login credentials are incorrect."
				redirect_to login_index_path
			end
	  rescue Exception => e
			flash[:error] = "All fields must be filled out. #{e}"
			redirect_to login_index_path
	  end
  end

  def destroy
  	begin
  		flash[:notice] = "Have a great day #{session[:username]}. You have been logged out."

  		session.delete(:username)
  		session.delete(:site)
  		session.delete(:printer)
  		session.delete(:logged_out)

  		redirect_to login_index_path
  	rescue Exception => e
			flash[:error] = "#{e}"
			redirect_to main_menu_index_path
	  end
	end
end
