task :send_daily_digest => :environment do

	puts 'hey'
	# DailyDigestWorker.perform_async

end