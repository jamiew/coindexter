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
    @identity = Identity.find_for_oauth env["omniauth.auth"]

    puts "identity is #{@identity.inspect}"

    @user = @identity.user || current_user
    if @user.nil?
      puts "tannehill 1"
      @existing_user = User.find_by_email(@identity.email) unless @identity.email.blank?
      puts "tannehill 2"
      if @existing_user.nil?
        puts "tannehill 3" 
        @user = User.create( email: @identity.email || nil, first_name: first_name(@identity.name) || nil, last_name: last_name(@identity.name) || nil, remote_avatar_url: @identity.image || nil, username: @identity.nickname )
        puts "tannehill 4" 
        @user.skip_confirmation!
        puts "tannehill 5" 
      else
        @user = @existing_user
        puts "tannehill 6" 
        if @user.email.blank? && @identity.email
          puts "tannehill 7" 
          @user.update_attribute( :email, @identity.email)
          puts "tannehill 8" 
        end
        if @user.first_name.blank?
          puts "tannehill 9" 
          @user.update_attributes( :first_name => first_name(@identity.name), :last_name => last_name(@identity.name))
          puts "tannehill 10" 
        end
        puts "tannehill 11" 
        @user.update_attribute( :remote_avatar_url, @identity.image)
        puts "tannehill 12" 
      end
      puts "tannehill 13"
      @user.skip_confirmation!
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.persisted?
      puts "tannehill 14"
      @identity.update_attribute( :user_id, @user.id )
      puts "tannehill 15"
      # This is because we've created the user manually, and Device expects a
      # FormUser class (with the validations)
      puts "tannehill 16"
      @user = FormUser.find @user.id
      puts "tannehill 17"
      if @user.email.blank? && @identity.email
        puts "tannehill 18"
        @user.update_attribute( :email, @identity.email)
        puts "tannehill 19"
      end
      if @user.first_name.blank?
        puts "tannehill 20"
        @user.update_attributes( :first_name => first_name(@identity.name), :last_name => last_name(@identity.name))
        puts "tannehill 21"
      end
      if @user.remote_avatar_url.nil?
        puts "tannehill 22"
        @user.update_attribute( :remote_avatar_url, @identity.image)
        puts "tannehill 23"
      end
      puts "tannehill 24"
      sign_in_and_redirect @user, event: :authentication
      puts "tannehill 25"
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      puts "tannehill 26"
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      puts "tannehill 27"
      @user.skip_confirmation!
      puts "tannehill 28"
      redirect_to new_user_registration_url
      puts "tannehill 29"
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
