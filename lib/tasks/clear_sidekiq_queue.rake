task :clear_sidekiq_queue => :environment do
	Sidekiq::Queue.new.clear
end