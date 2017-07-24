class UpdateAllCoinPricesWorker
	include Sidekiq::Worker
	sidekiq_options({
		unique: :all,
		expiration: 24 * 60 * 60
	})
	sidekiq_options :retry => false

	def perform

		Coin.find_each do |coin|
			
			coin = Coin.find(coin_id)

		    # attributes to save
		    attributes_to_save = Hash.new

		    # if coin doesn't have a symbol or has never appeared in cryptocompare, try to get symbol or cryptocompare id
		    if coin.coin_market_cap_id.nil? or coin.symbol.nil?
		      fullCoinList = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
		      if !fullCoinList["Data"].select{|key, hash| clean_name(hash["CoinName"]) == clean_name(coin.name) }.empty?
		        data = fullCoinList["Data"]
		        indexed_coin = data.select{|key, hash| clean_name(hash["CoinName"]) == clean_name(coin.name)}
		        attributes_to_save = save_coin_market_cap_id(indexed_coin, coin, attributes_to_save)
		      elsif !fullCoinList["Data"].select{|key, hash| key == coin.symbol.upcase}.empty?
		        data = fullCoinList["Data"]
		        indexed_coin = data.select{|key, hash| key == coin.symbol }
		        attributes_to_save = save_coin_market_cap_id(indexed_coin, coin, attributes_to_save)
		      end
		    end

		    # Get supply info
		    unless coin.coin_market_cap_id.nil?
		      response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=' + coin.coin_market_cap_id.to_s).body)
		    else 
		      response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=' + attributes_to_save[:coin_market_cap_id].to_s).body)
		    end
		    if response["response"] == "Error"
		      puts "getting supply data for #{coin.name} via coinmarketcap"
		      altResponse = JSON.parse(HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + coin.name.gsub(".","-").gsub(" ","-").downcase).body).first
		      unless altResponse.first == "error"
		        attributes_to_save[:available_supply] = altResponse["available_supply"].to_i
		        attributes_to_save[:total_supply] = altResponse["total_supply"].to_i
		      end
		    else
		      puts "getting supply data for #{coin.name} via cryptocompare"
		      data = response["Data"]
		      available_supply = data.values.second["TotalCoinsMined"].to_i
		      unless available_supply == 0
		        attributes_to_save[:available_supply] = available_supply
		      end
		      if coin.total_supply.nil?
		        total_supply = data.values.second["TotalCoinSupply"].to_i
		        unless total_supply == 0
		          attributes_to_save[:total_supply] = total_supply
		        end
		      end
		    end
		    
		    # Get price and 24h change from cryptocompare
		    if !attributes_to_save[:symbol].nil?
		      response = JSON.parse(HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=' + attributes_to_save[:symbol].upcase + '&tsyms=USD').body) 
		    elsif !coin.symbol.nil? && coin.symbol != ""
		      response = JSON.parse(HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=' + coin.symbol.upcase + '&tsyms=USD').body)  
		    end
		    # As long as cryptocompare call doesnt fail
		    unless response["Response"] == "Error"
		      if coin.coin_status != 'live'
		        attributes_to_save[:coin_status] = 'live'
		      end
		      price = response.values.first.values.first.values.first["PRICE"].to_d
		      one_day_price_change = response.values.first.values.first.values.first["CHANGEPCT24HOUR"].to_d.round(2)
		      market_cap = price * available_supply
		      attributes_to_save[:price] = price
		      attributes_to_save[:one_day_price_change] = one_day_price_change
		      unless market_cap == 0
		        attributes_to_save[:market_cap] = market_cap
		      end
		      puts "saving #{coin.name} price info via cryptocompare" 
		    else
		      # if Cryptocompare fails, try coinmarketcap
		      if altResponse.nil?
		        altResponse = JSON.parse(HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + coin.name.gsub(".","-").gsub(" ","-").downcase).body).first
		      end
		      unless altResponse.first == "error"
		        attributes_to_save[:market_cap] = altResponse["market_cap_usd"].to_i
		        attributes_to_save[:price] = altResponse["price_usd"].to_f.round(2)
		      end
		      puts "saving #{coin.name} price info via coinmarketcap" 
		    end
		    
		    unless attributes_to_save.empty?
		      if coin.coin_status != "live"
		        attributes_to_save[:coin_status] = "live"
		      end
		      puts "saving #{attributes_to_save} for #{coin.name}"
		      coin.update_attributes(attributes_to_save)
		    else
		      puts "Nothing to save for #{coin.name}"
		    end
		end

	end

	def save_coin_market_cap_id(indexed_coin, coin, attributes_to_save)
	    puts indexed_coin
	    if coin.coin_market_cap_id.nil?
	      coin_market_cap_id = indexed_coin.values.first["Id"]
	      if coin.symbol.nil?
	        symbol = indexed_coin.values.first["Name"]
	        attributes_to_save[:symbol] = symbol
	      else  
	      end
	      attributes_to_save[:coin_market_cap_id] = coin_market_cap_id
	    end
	    return attributes_to_save
  	end

	def clean_name(name)
	    cleaned_name = name.strip.gsub(".","-").gsub(" ","-").downcase
	    return cleaned_name
	end

	# UpdateAllCoinPricesWorker.perform_async
	
end
