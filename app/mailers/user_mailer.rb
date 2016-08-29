class UserMailer < ApplicationMailer

	default from: 'do-not-reply@coindexter.io'

	def registration_confirmation(user)
	    @user = user
	    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
	   	message_params = {
	   		:from    => ENV['MAILGUN_USERNAME'],
            :to      => user.email,
            :subject => 'Sample Mail using Mailgun API',
            :text    => 'This mail is sent using Mailgun API via mailgun-ruby'
       	}
   		mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
	end

	
end
	