class UserMailer < ActionMailer::Base
  
 default from: "Coindexter <jonathan@coindexter.io>"

  def daily_digest(user, network_logs, coin_logs, coins_following)
    @user = user
    @network_logs = network_logs
    network_logs_count = @network_logs.nil? ?  0 : @network_logs.count
    @coin_logs = coin_logs
    coin_logs_count = @coin_logs.nil? ? 0 : @coin_logs.count
    @coins_following = coins_following
    update_sum = network_logs.count + coin_logs.count == 1 ? "1 update" : "#{network_logs_count + coin_logs_count} updates" 
    mail(to: @user.email, subject: "Coindexter Daily Digest: #{update_sum}")
    puts "mail sent to #{@user.email}"
  end

end