task :change_coin_repositories => :environment do
	Coin.all.each do |coin| 
		coin.repositories = {} 
		coin.save 
	end
end