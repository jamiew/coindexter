task :update_statuses => :environment do
	Coin.all.each do |coin|
		if coin.coin_status == 0
			coin_status = "Concept"
		elsif coin.coin_status == 1
			coin_status = "Preproduction"
		elsif coin.coin_status == 2
			coin_status = "Live"
		end
	end
end

