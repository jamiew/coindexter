task :send_daily_digest => :environment do

	puts "working"
	DailyDigestWorker.perform_async

end