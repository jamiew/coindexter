class UpdateAllCoinPricesWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform
    Coin.all.each do |coin|
    	if coin.coin_status == "live"
    		puts coin.name
	    	response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + coin.name.delete(" ").downcase)
		    if response[0].nil?
		      puts coin.name
		    else
		      price = response[0]["price_usd"]
		      one_hour_price_change = response[0]["percent_change_1h"]
		      one_day_price_change = response[0]["percent_change_24h"]
		      available_supply = response[0]["available_supply"]
		      total_supply = response[0]["total_supply"]
		      market_cap = response[0]["market_cap_usd"]
		      coin.update_attributes(:price => price,:one_day_price_change => one_day_price_change, :one_hour_price_change => one_hour_price_change, :available_supply => available_supply, :total_supply => total_supply, :market_cap => market_cap)
		      coin.save
		    end
		end
    end
  end

  UpdateAllCoinPricesWorker.perform_async
  
end
