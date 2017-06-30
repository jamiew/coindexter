class DailyDigestWorker

  include Sidekiq::Worker
  
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60,
    :retry => false
  })

  def perform

    all_network_logs = []

    Network.find_each do |network| 
      network_logs = NetworkService.new
      fetched_network_logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
      logs = { network: network, logs: fetched_network_logs, coins: [], links: [] }
      if !network.coins.nil?
        network.coins.each do |coin|
          coin_logs = NetworkService.new
          fetched_coin_logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
          unless fetched_coin_logs.empty? && coin.price.nil?
            network_coin_logs =  { :coin => coin, :logs => fetched_coin_logs }
          end 
          logs[:coins] << network_coin_logs
        end
        network.links.each do |link|
          current_datetime = DateTime.now
          if link.created_at > current_datetime - 1.day
            logs[:links] << link
          end
        end
      end 

      all_network_logs << logs unless logs[:logs].empty? && (logs[:coins].nil? or logs[:coins] == [nil] or logs[:coins].empty?) && (logs[:links].nil? or logs[:links].empty?)

    end

    networks_following = []

    user.find_each do |user|

      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following << Network.find(follow.followable_id).name
        end
      end

      all_network_logs = all_network_logs.select do |network|
        networks_following.index network[:network].name
      end

      unless all_network_logs.empty?
        all_network_logs = all_network_logs.to_json
        UserMailer.daily_digest_new(user, all_network_logs).deliver_later
      end
      
    end
  
  end

  # Sidekiq::Cron::Job.create(name: 'Daily Digest worker - every 1day', cron: '00 03 10 * *', class: 'DailyDigestWorker')

  # DailyDigestWorker.perform_async
  
end
