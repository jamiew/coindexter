task :mix_logs => :environment do
	
	all_network_logs = []

	Network.find_each do |network| 
		network_logs = NetworkService.new
		fetched_network_logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
		logs = {network.name => []}
		unless fetched_network_logs.empty?
			logs[network.name] << {:network_logs => fetched_network_logs}
		end

		network.coins.each do |coin|
			coin_logs = NetworkService.new
			fetched_coin_logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
			network_coin_logs = {coin.name => []}
			unless fetched_coin_logs.empty?
				network_coin_logs[coin.name] = coin.name
				network_coin_logs[coin.name][:logs] = fetched_coin_logs
				network_coin_logs[coin.name][:price] = coin.price unless coin.price.nil? 
			end 
			logs[network.name] << {:network_coin_logs => network_coin_logs}
		end
			
		all_network_logs << logs

	end

	puts all_network_logs

end