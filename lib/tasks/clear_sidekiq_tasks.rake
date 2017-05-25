task :clear_sidekiq_tasks => :environment do
	Sidekiq::ScheduledSet.new.clear
end