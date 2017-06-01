class UpdateSingleCoinPriceWorker
  include Sidekiq::Worker

  def perform(coin_id)
  	logger.info "things are happening"
    logger.info coin_id
  	coin = Coin.find(coin_id)
    logger.info coin.inspect
	response = HTTParty.get('https://api.coinmarketcap.com/v1/ticker/' + coin.name.delete(" ").downcase)
    if response[0].nil?
      puts name
    else
      coin.price = response[0]["price_usd"]
      coin.one_hour_price_change = response[0]["percent_change_1h"]
      coin.one_day_price_change = response[0]["percent_change_24h"]
      coin.available_supply = response[0]["available_supply"]
      coin.total_supply = response[0]["total_supply"]
      coin.market_cap = response[0]["market_cap_usd"]
      coin.update_attributes(:price => price,:one_day_price_change => one_day_price_change, :one_hour_price_change => one_hour_price_change, :available_supply => available_supply, :total_supply => total_supply, :market_cap => market_cap)
      logger.info "things are happening 2"
      coin.save
    end
  end

  UpdateSingleCoinPriceWorker.perform_async
  
end
