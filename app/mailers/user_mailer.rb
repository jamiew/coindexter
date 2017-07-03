class UserMailer < ActionMailer::Base
  
  default from: "jonathan@coindexter.io"

  def daily_digest_new(user, all_network_logs)
    @user = user
    @all_network_logs = all_network_logs
    mail(to: @user.email, subject: "Coindexter Daily Digest")
  end

  def confirmation_instructions(user, confirmation_instructions, opts={})
    @user = user
    @confirmation_instructions = confirmation_instructions
    mail(to: @user.email, subject: "Confirm your email address")
  end

  def reset_password_instructions(user, reset_password_token, opts={})
    @user = user
    @reset_password_token = reset_password_token
    mail(to:@user.email, subject: "Reset your password")
  end

end