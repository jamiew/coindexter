# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.minute do
   rake "update_all_coin_prices"
end

every :day, :at => '9:15am' do
   rake "update_all_coin_prices"
end


