task :clear_sidekiq_jobs => :environment do

	queue = Sidekiq::Queue.new

	queue.each do |job|
	   job.delete
	end

end