task :update_all_coin_prices => :environment do
	UpdateAllCoinPricesWorker.perform_async
end