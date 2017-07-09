task :update_from_cryptocompare => :environment do
	UpdateAllCoinPricesWorker.perform_async
end