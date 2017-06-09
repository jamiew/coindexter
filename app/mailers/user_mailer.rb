class UserMailer < ActionMailer::Base
  
  default from: "jonathan@coindexter.io"

  def daily_digest(user, network_logs, coin_logs, coins_following)
    @user = user
    @network_logs = network_logs
    @coin_logs = coin_logs
    @coins_following = coins_following
    update_sum = network_logs.count + coin_logs.count == 1 ? "1 update" : "#{network_logs.count + coin_logs.count} updates" 
    if network_logs.count + coin_logs.count == 0
      mail(to: @user.email, subject: "Coindexter Daily Digest").deliver
    else   
      mail(to: @user.email, subject: "Coindexter Daily Digest: #{update_sum}").deliver
    end
  end

  def confirmation_instructions(user, confirmation_instructions, opts={})
    @user = user
    @confirmation_instructions = confirmation_instructions
    mail(to: @user.email, subject: "Confirm your email address").deliver
  end

  def reset_password_instructions(user, reset_password_token, opts={})
    @user = user
    @reset_password_token = reset_password_token
    mail(to:@user.email, subject: "Reset your password").deliver
  end

end