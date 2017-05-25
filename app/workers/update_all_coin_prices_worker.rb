class UpdateAllCoinPricesWorker
  include Sidekiq::Worker

  def perform
=begin
    Coin.all.each do |coin|
    	coin.update_prices
    end
    puts 'hey'
=end
  end

  UpdateAllCoinPricesWorker.perform_async
  
end
