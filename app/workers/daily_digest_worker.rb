class DailyDigestWorker
  include Sidekiq::Worker
  
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60
  })
  sidekiq_options :retry => false

  def perform

      all_network_logs = []

      Network.find_each do |network| 
        network_logs = NetworkService.new
        fetched_network_logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
        logs = {network.name => []}
        unless fetched_network_logs.empty?
          logs[network.name] << {:network_logs => fetched_network_logs}
        end

        network.coins.each do |coin|
          coin_logs = NetworkService.new
          fetched_coin_logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
          network_coin_logs = {coin.name => {}}
          unless fetched_coin_logs.empty? 
            network_coin_logs[coin.name] = {:logs => fetched_coin_logs, :price => coin.price}
          end 
          logs[network.name] << {:network_coin_logs => network_coin_logs}
        end
          
        all_network_logs << logs

      end

      networks_following = []

      user = User.first

      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following << Network.find(follow.followable_id).name
        end
      end

      all_network_logs = all_network_logs.select do |network|
        networks_following.index network.keys.first
      end

    UserMailer.daily_digest_new(user, all_network_logs).deliver_later
  
  end

  DailyDigestWorker.perform_async
  
end
