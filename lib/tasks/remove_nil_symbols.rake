task :remove_nil_symbols => :environment do
	Coin.all.where(symbol: nil).each do |coin|
		coin.update_attributes(symbol: nil)
	end
end