task :update_all_coin_prices => :environment do
    Coin.all.each do |coin|
    	coin.update_prices
    end
end