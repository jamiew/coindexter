class UserMailer < ActionMailer::Base
  
  default from: "jonathan@coindexter.io"

  def daily_digest(user, network_logs, coin_logs, coins_following)
    @user = user
    @network_logs = network_logs
    @coin_logs = coin_logs
    @coins_following = coins_following
    update_sum = network_logs.count + coin_logs.count == 1 ? "1 update" : "#{network_logs.count + coin_logs.count} updates" 
    mail(to: @user.email, subject: "Coindexter Daily Digest: #{update_sum}")
  end

end