task :clear_sidekiq_tasks => :environment do
	
	require 'sidekiq/api'

	Sidekiq::ScheduledSet.new.clear
end