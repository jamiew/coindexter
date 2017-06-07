class UserMailer < ActionMailer::Base
  
  default from: "from@example.com"

  def daily_digest(user, network_logs)
    @user = user
    @network_logs = network_logs
    update_sum = network_logs.count == 1 ? "1 update" : "#{network_logs.count} updates" 
    mail(to: @user.email, subject: "Coindexter Daily Digest: #{update_sum}")
  end

end