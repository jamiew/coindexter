class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :user_params, if: :devise_controller?

  before_filter :set_paper_trail_whodunnit

  def about
    render 'layouts/about'
  end

  private

	def user_params 
		devise_parameter_sanitizer.permit( :sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :username])
	end

end
