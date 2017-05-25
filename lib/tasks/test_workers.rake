task :test_workers => :environment do
	 TestWorker.perform_async
end
