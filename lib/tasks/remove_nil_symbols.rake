task :remove_nil_symbols => :environment do
	Coin.all.where(symbol: nil).each do |coin|
		puts coin.name
		coin.update_attributes(symbol: nil)
	end
	Coin.all.where(symbol: "").each do |coin|
		puts coin.name
		coin.update_attributes(symbol: nil)
	end
end