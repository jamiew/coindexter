task :add_status_to_coins => :environment do
	Coin.all.each do |coin|
		coin.coin_status = "live"
		coin.save
	end
end
