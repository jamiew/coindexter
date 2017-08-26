class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    generic_callback( 'facebook' )
  end

  def twitter
    generic_callback( 'twitter' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    @identity = Identity.find_for_oauth request.env["omniauth.auth"]

    puts "identity is #{@identity.inspect}"
    puts "provider is #{provider}"

    @user = @identity.user || current_user
    if @user.nil?
      @existing_user = User.find_by_email(@identity.email) unless @identity.email.blank?
      if @existing_user.nil?
        @user = User.create( email: @identity.email || nil, first_name: first_name(@identity.name) || nil, last_name: last_name(@identity.name) || nil, remote_avatar_url: @identity.image || nil, username: @identity.nickname )
        @user.skip_confirmation!
      else
        @user = @existing_user
        if @user.email.blank? && @identity.email
          @user.update_attribute( :email, @identity.email)
        end
        if @user.first_name.blank?
          @user.update_attributes( :first_name => first_name(@identity.name), :last_name => last_name(@identity.name))
        end
        @user.update_attribute( :remote_avatar_url, @identity.image)
      end
      @user.skip_confirmation!
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      @user = FormUser.find @user.id
      if @user.email.blank? && @identity.email
        @user.update_attribute( :email, @identity.email)
      end
      if @user.first_name.blank?
        @user.update_attributes( :first_name => first_name(@identity.name), :last_name => last_name(@identity.name))
      end
      if @user.remote_avatar_url.nil?
        @user.update_attribute( :remote_avatar_url, @identity.image)
      end
      @user.skip_confirmation!
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      puts "ENV['omniauth.auth'] is #{ENV['omniauth.auth']}"
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      @user.skip_confirmation!
      sign_in_and_redirect @user
    end
  end

  private 

    def first_name(name)
      name.split[0]
    end

    def last_name(name)
      name.split[1]
    end

end
