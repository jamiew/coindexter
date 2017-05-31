class UserMailer < Devise::Mailer   
	helper :application # gives access to all helpers defined within `application_helper`.
	include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
	default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

	default from: 'jonathan@coindexter.io'

	def daily_digest(user, network_logs_count, coin_logs_count)
		@user = user
		@network_logs = network_logs
		@coin_logs = coin_logs
		update_sum = network_logs_count + coin_logs_count == 1 ? "1 update" : "#{network_logs.count + coin_logs.count} updates" 
		mail(to: @user.email, subject: "Coindexter Daily Digest: #{update_sum}")
	end

end