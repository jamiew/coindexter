class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :user_params, if: :devise_controller?

  before_filter :set_paper_trail_whodunnit

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

  def redirect_to_https
    redirect_to :protocol => "https://" unless (request.ssl? || request.local?)
  end

end
