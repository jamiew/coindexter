class TestMailer < ApplicationMailer

	default from: 'do-not-reply@coindexter.io'

	helper :application # gives access to all helpers defined within `application_helper`.
	
  	def test_email
	    mg_client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
	   	puts "is it sent?"
	   	message_params = {
	   		:from    => ENV['MAILGUN_USERNAME'],
            :to      => "jonathan.libov@gmail.com",
            :subject => 'hey',
            :text    => 'Welcome to Coindexter! Please confirm your email address by clicking on this link:
            			http://localhost:3000/users/confirmation?confirmation_token='
       	}
   		mg_client.send_message ENV['MAILGUN_DOMAIN'], message_params
  	end

end