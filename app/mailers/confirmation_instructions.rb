class UserMailer < ActionMailer::Base
  
 default from: "Coindexter <jonathan@coindexter.io>"

  def confirmation_instructions(user, confirmation_instructions)
  	mail(to: @user.email, subject: "Confirm you remail address")
  end

end