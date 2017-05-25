class DailyDigestWorker
  include Sidekiq::Worker

  def perform
    network_logs_in_past_day = []
    Network.all.each do |network| 
      network_logs = NetworkService.new
      logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
      unless logs.empty?
        network_logs_in_past_day << logs
      end
    end

    coin_logs_in_past_day = []
    Coin.all.each do |coin| 
      coin_logs = NetworkService.new
      logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
      unless logs.empty?
        coin_logs_in_past_day << logs
      end
    end
    
    @user = User.all.each do |user|
      networks_following = []
      coins_following = []

      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following << Network.find(follow.followable_id)
        else 
          coins_following << Coin.find(follow.followable_id)
        end
      end

      @network_logs = network_logs_in_past_day.select do |network|
        networks_following.index network.first.networks
      end

      @coin_logs = coin_logs_in_past_day.select do |coin|
        coins_following.index coin.first.coins
      end

      UserMailer.daily_digest(user, @network_logs, @coin_logs).deliver_now
      
  	end
  end

  DailyDigestWorker.perform_async
  
end
