task :change_slug_to_symbol_if_exists => :environment do
	Coin.find_each do |coin| 
		if !coin.symbol.nil?
			coin.update_attribute(:slug, coin.symbol.downcase)
		end
	end
end