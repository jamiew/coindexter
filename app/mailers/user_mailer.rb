class UserMailer < ApplicationMailer

	default from: 'do-not-reply@coindexter.io'

	def welcome_email(user)
	    @user = user
	    @url  = 'http://example.com/login'
	    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end
	
end
