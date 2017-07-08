class UpdateSingleCoinPriceWorker
  include Sidekiq::Worker
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60
  })
  sidekiq_options :retry => false

  def perform(coin_id)

    fullCoinList = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)
    puts fullCoinList

    coin = Coin.find(coin_id)

  	unless fullCoinList["Data"].select{|key, hash| hash["CoinName"] == coin.name }.empty?
      if coin.coin_market_cap_id.nil? or coin.symbol.nil?
        if fullCoinList["response"] == "Error"
          puts fullCoinList["Message"]
        else 
          data = fullCoinList["Data"]
        end
        indexed_coin = data.select{|key, hash| hash["CoinName"] == coin.name }
        if coin.coin_market_cap_id.nil?
          coin_market_cap_id = indexed_coin.values.first["Id"]
          if coin.symbol.nil?
            symbol = indexed_coin.values.first["Name"]
            coin.update_attributes(:symbol => symbol, :coin_market_cap_id => coin_market_cap_id)
          else  
            coin.update_attributes(:coin_market_cap_id => coin_market_cap_id) 
          end
        end
      end

      attributes_to_save = Hash.new

      # Get supply info
      unless coin_market_cap_id.nil?
        response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=' + coin_market_cap_id.to_s).body)
      else 
        response = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinsnapshotfullbyid/?id=' + coin.coin_market_cap_id.to_s).body)
      end
      if response["response"] == "Error"
        puts response["Message"]
      end
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
      
      # Get price and 24h change
      unless symbol.nil?
        response = JSON.parse(HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=' + symbol.upcase + '&tsyms=USD').body) 
      else 
        response = JSON.parse(HTTParty.get('https://min-api.cryptocompare.com/data/pricemultifull?fsyms=' + coin.symbol.upcase + '&tsyms=USD').body)  
      end
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
      end

      puts attributes_to_save
      puts coin.name
      coin.update_attributes(attributes_to_save)

    end

  end

  # UpdateSingleCoinPriceWorker.perform_async
  
end
