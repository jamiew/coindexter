class DigestMailer < ApplicationMailer

	default from: 'jonatha@coindexter.io'
 
	def daily_digest(user, networks_following_changes)
		@user = user
		@networks_following_changes = networks_following_changes
		mail(to: @user.email, subject: 'Daily Digest')
	end

end
