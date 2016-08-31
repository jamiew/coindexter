# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def confirmation_instructions
    	UserMailer.confirmation_instructions(User.last)
  	end

	def reset_password_instructions
		UserMailer.reset_password_instructions(User.last, "faketoken", {})
	end

	def unlock_instructions
		UserMailer.unlock_instructions(User.last, "faketoken", {})
	end
end
