class DailyDigestWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 2

  def perform

    network_logs_in_past_day = []
    coin_logs_in_past_day = []
    
    Network.find_each do |network| 
      network_logs = NetworkService.new
      logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
      unless logs.empty?
        network_logs_in_past_day << logs
      end
    end

    Coin.find_each do |coin| 
      coin_logs = NetworkService.new
      logs = coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
      unless logs.empty?
        coin_logs_in_past_day << logs
      end
    end

    user = User.first

    networks_following = []
    coins_following = []

    user.all_follows.each do |follow|
      if follow.followable_type == "Network"
        networks_following << Network.find(follow.followable_id)
      elsif follow.followable_type == "Coin"
        coins_following << Coin.find(follow.followable_id)
      end
    end

    network_logs = network_logs_in_past_day.select do |network|
      networks_following.index network.first.networks
    end

    coin_logs = coin_logs_in_past_day.select do |coin|
      coins_following.index coin.first.coins
    end

    unless network_logs.first.nil?
      network_logs = network_logs.first.sort_by{|log| log.created_at}.reverse
    end

    unless coin_logs.first.nil?
      coin_logs = coin_logs.first.sort_by{|log| log.first.created_at}.reverse
    end

    UserMailer.daily_digest(user, network_logs, coin_logs, coins_following).deliver_now
  
  end

  DailyDigestWorker.perform_async
  
end
