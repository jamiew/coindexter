task :clear_sidekiq_queue => :environment do

	require 'sidekiq/api'
	
	Sidekiq::Queue.new.clear
end