class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :user_params, if: :devise_controller?

  before_filter :set_paper_trail_whodunnit

  def user_for_paper_trail
    user_signed_in? ? {id: current_user.id, name: current_user.first_name + ' ' + current_user.last_name} : ''
  end

  private

	def user_params 
		devise_parameter_sanitizer.permit( :sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
	end

end
