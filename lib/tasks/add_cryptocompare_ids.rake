task :add_cryptocompare_ids => :environment do
	
	response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
	data = response["Data"]
	data.each do |coin|
		coin_exists = Coin.friendly.exists? coin.second["CoinName"].downcase.gsub(".","-").gsub(" ","-")
		if coin_exists
			c = Coin.friendly.find(coin.second["CoinName"].downcase.gsub(".","-").gsub(" ","-"))
			c.coin_market_cap_id = coin.second["Id"]
			c.symbol = coin.second["Name"]
			c.save
			puts coin.second["CoinName"]
			puts c.coin_market_cap_id
			puts c.symbol
		end
	end

end
