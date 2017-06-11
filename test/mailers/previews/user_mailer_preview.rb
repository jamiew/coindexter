# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def confirmation_instructions
    	UserMailer.confirmation_instructions(User.last)
  	end

	def reset_password_instructions
		UserMailer.reset_password_instructions(User.last, User.last.reset_password_token, {})
	end

	def unlock_instructions
		UserMailer.unlock_instructions(User.last, token, {})
	end

	def daily_digest_new
		all_network_logs = []

		Network.find_each do |network| 
			network_logs = NetworkService.new
			fetched_network_logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
			logs = { network: network, logs: fetched_network_logs, coins: [] }
			if !network.coins.nil?
				network.coins.each do |coin|
					coin_logs = NetworkService.new
					fetched_coin_logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
					unless fetched_coin_logs.empty?	&& coin.price.nil?
						network_coin_logs =  { :coin => coin, :logs => fetched_coin_logs }
					end 
					logs[:coins] << network_coin_logs
				end
			end 

			all_network_logs << logs unless logs[:logs].empty? && (logs[:coins].nil? or logs[:coins].empty?)

		end

		networks_following = []

		user = User.first

		user.all_follows.each do |follow|
			if follow.followable_type == "Network"
			  networks_following << Network.find(follow.followable_id).name
			end
		end

		all_network_logs = all_network_logs.select do |network|
			networks_following.index network[:network].name
		end

	    # mail(to: @user.email, subject: "Coindexter Daily Digest").deliver

		UserMailer.daily_digest_new(user, all_network_logs)   

	end
end
