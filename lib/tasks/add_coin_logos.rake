task :add_coin_logos => :environment do
	Coin.all.each do |coin|
		filename = "#{coin.name}.png"
		if File.exist?(Rails.root.join('app','assets','images','coins',filename)) 
			File.open(Rails.root.join('app','assets','images','coins',filename)) do |f|
				coin.logo = f
				coin.save!
			end
		end
	end
end
