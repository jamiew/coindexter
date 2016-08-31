class UserMailer < Devise::Mailer 

	default from: 'do-not-reply@coindexter.io'

	helper :application # gives access to all helpers defined within `application_helper`.
  	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  	default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
	
	def confirmation_instructions(record, token, opts={})
	    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
	   	message_params = {
	   		:from    => ENV['MAILGUN_USERNAME'],
            :to      => record.email,
            :subject => 'Please confirm your email',
            :text    => 'Welcome to Coindexter! Please confirm your email address by clicking on this link:
            			http://localhost:3000/users/confirmation?confirmation_token=' + token
       	}
   		mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  	end

	def reset_password_instructions(user)
		UserMailer.reset_password_instructions(user, "faketoken", {})
	end

	def unlock_instructions(user)
		UserMailer.unlock_instructions(user, "faketoken", {})
	end

end
	