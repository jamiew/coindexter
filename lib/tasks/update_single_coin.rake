task :update_single_coin => :environment do
	UpdateSingleCoinPriceWorker.perform_async(134)
end

