task :add_categories => :environment do
	category_names = ['Application development', 'Asset management', 'Computing', 'Crowdfunding', 'Currency', 'DAO', 'Data & Records', 'Digital assets', 'Electricity', 'Exchange', 'Financial', 'Governance', 'Identity', 'Insurance', 'Interoperability', 'IoT', 'Marketplace', 'Media rights', 'Payments', 'Prediction markets', 'Ridesharing', 'Smart contracts', 'Social', 'Storage', 'Wallet', 'Web', 'Web & Browsers', 'Work']
	category_names.each do |category|
		cat = Category.new
		cat.name = category
		cat.save
	end
end