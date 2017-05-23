class UpdateAllCoinPricesWorker
  include Sidekiq::Worker

  def perform
    Coin.all.each do |coin|
    	coin.update_prices
    end
  end

  UpdateAllCoinPricesWorker.perform_async
  
end
