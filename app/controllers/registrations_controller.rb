class RegistrationsController < Devise::RegistrationsController

  before_action :user_params, if: :devise_controller?

	def update_resource(resource, params)
    if resource.encrypted_password.blank? # || params[:password].blank?
      resource.email = params[:email] if params[:email]
      resource.first_name = params[:first_name] if params[:first_name]
      resource.last_name = params[:last_name] if params[:last_name]
      if !params[:password].blank? && params[:password] == params[:password_confirmation] && !params[:email].blank? && !params[:first_name].blank? && !params[:last_name].blank?
        logger.info "Updating password"
        resource.password = params[:password]
        resource.last_name = params[:last_name]
        resource.first_name = params[:first_name]
        resource.save
      end
      if resource.valid?
        resource.update_without_password(params)
      end
    else
      resource.update_with_password(params)
    end
  end

  private

    def user_params 
      params.require(:user).permit(:first_name, :last_name)
    end

end
