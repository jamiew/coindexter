task :paper_trail_test => :environment do
	
	user = User.find(1)
	PaperTrail.whodunnit = user

	network = Network.first
	network.update_attributes(team: "The Steem Foundationzz.")
	network.versions.last.update_attributes(whodunnit: user.id)

end