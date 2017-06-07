task :test_daily_digest => :environment do

  network_logs_in_past_day = []
  Network.find_each do |network| 
    network_logs = NetworkService.new
    logs = network_logs.get_logs(network, "Network",nil,nil,1).reverse
    coins = network.coins
    coins.each do |coin|
      coin_logs = NetworkService.new
      logs += coin_logs.get_logs(coin, "Coin",nil,nil,1).reverse
      coin_price = coin.price
    end
    unless logs.empty?
      network_logs_in_past_day << logs
    end
  end

  user = User.first
  networks_following = []
  coins_following = []

  user.all_follows.each do |follow|
    if follow.followable_type == "Network"
      networks_following << Network.find(follow.followable_id)
    end
  end

  @network_logs = network_logs_in_past_day.select do |network|
    networks_following.index network.first.networks
  end

  unless @network_logs.count == 0
    UserMailer.daily_digest(user, @network_logs).deliver_now
  end

end