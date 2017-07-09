task :set_all_blank_whodunnits_to_system => :environment do
	
	user = User.first

	Network.all.each do |network|
		network.versions.all.each do |version|
			if version.whodunnit.nil? or version.whodunnit = "" or version.whodunnit.blank?
				version.update_attributes(whodunnit: user.id)
			end
		end
	end

	Coin.all.each do |coin|
		coin.versions.all.each do |version|
			if version.whodunnit.nil? or version.whodunnit = "" or version.whodunnit.blank?
				version.update_attributes(whodunnit: user.id)
			end
		end
	end

end


