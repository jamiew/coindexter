class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :user_params, if: :devise_controller?

  before_action :set_paper_trail_whodunnit

  before_action :store_current_location, :unless => :devise_controller?

  require "browser"
  browser = Browser.new("Some User Agent", accept_language: "en-us")

  def about
    render 'layouts/about'
  end

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with *args, options, &blk
  end

  private

	def user_params 
		devise_parameter_sanitizer.permit( :sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :username])
	end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end

  
end
