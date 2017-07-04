task :add_cryptocompare_ids => :environment do
	
	response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
	data = response["Data"]
	user_id = 1
	data.each do |coin|
		coin_exists = Coin.friendly.exists? coin.second["CoinName"].downcase.gsub(".","-").gsub(" ","-")
		if coin_exists
			c = Coin.friendly.find(coin.second["CoinName"].downcase.gsub(".","-").gsub(" ","-"))
			c.coin_market_cap_id = coin.second["Id"]
			if c.symbol.nil?
				c.symbol = coin.second["Name"]
			end
			if c.save
				cv = c.versions.last
				cv.whodunnit = user_id
				cv.save
			else
				puts 'problem saving #{coin[:name]}'
			end
		end
	end

end
