class UpdateAllCoinPricesAltWorker
  include Sidekiq::Worker
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60
  })
  sidekiq_options :retry => false

	def perform

		Coin.where(:coin_status => 'live').find_each do |coin|
			unless JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)["Data"].select{|key, hash| hash["CoinName"] == coin.name }.empty?
				if coin.coin_market_cap_id.nil?
					response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
					if response["response"] == "Error"
						puts response["Message"]
					end
					data = response["Data"]
					indexed_coin = data.select{|key, hash| hash["CoinName"] == coin.name }
					coin_market_cap_id = indexed_coin.values.first["Id"]
					coin.update_attributes(:coin_market_cap_id => coin_market_cap_id)
				end

				if coin.symbol.nil?
					response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
					if response["response"] == "Error"
						puts response["Message"]
					end
					data = response["Data"]
					indexed_coin = data.select{|key, hash| hash["CoinName"] == coin.name }
					symbol = indexed_coin.values.first["Name"]
					coin.update_attributes(:symbol => symbol)
				end

				# Get supply info
				response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=' + coin.coin_market_cap_id.to_s).body)
				if response["response"] == "Error"
					puts response["Message"]
				end
				data = response["Data"]
				available_supply = data.values.second["TotalCoinsMined"].to_i
				coin.update_attributes(:available_supply => available_supply)
				if coin.total_supply.nil?
					total_supply = data.values.second["TotalCoinSupply"].to_i
					coin.update_attributes(:total_supply => total_supply)
				end
				
				# Get price and 24h change
				response = JSON.parse(HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsym=' + coin.symbol.upcase + '&tsyms=USD').body)	
				unless response["Response"] == "Error"
					price = response.values.first.values.first.values.first["PRICE"].to_d
				    one_day_price_change = response.values.first.values.first.values.first["CHANGEPCT24HOUR"].to_d
				    market_cap = price * available_supply
				    coin.update_attributes(:price => price,:one_day_price_change => one_day_price_change, :market_cap => market_cap)
				end

				coin.save

			end
		end
	end

end