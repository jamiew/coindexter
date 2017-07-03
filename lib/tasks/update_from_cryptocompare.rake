task :update_from_cryptocompare => :environment do

	UpdateAllCoinPricesAltWorker.perform_async

end