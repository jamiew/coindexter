class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :user_params, if: :devise_controller?

  before_filter :set_paper_trail_whodunnit

  require "browser"
  browser = Browser.new("Some User Agent", accept_language: "en-us")

  def about
    render 'layouts/about'
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private

	def user_params 
		devise_parameter_sanitizer.permit( :sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :username])
	end
  
end
