task :clear_sidekiq_jobs => :environment do

	require 'sidekiq/api'

	queue = Sidekiq::Queue.new

	def remove_jobs(queue)
	  rem_count = 0
	  Sidekiq.redis do |r| 
	    # get all jobs in queue to an array
	    all =r.lrange queue, 0,-1
	    puts "count: #{all.count}"
	    all.each do |job|
	        r.lrem queue, 1, job
	        rem_count = rem_count + 1
	    end
	  end
	  puts "removed #{rem_count}"
	end

end