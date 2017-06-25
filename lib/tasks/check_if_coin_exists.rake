task :check_if_coin_exists => :environment do

	networks = [
				{name: "Civic", location: "San Francisco, CA", description: "On-demand, secure and low-cost access to identity verification via the blockchain", blockchain: "Ethereum"}, 
				{name: "Status", location: "Switzerland", description: "An open source consumer mobile messaging app to interact with decentralized applications that run on the Ethereum Network."}, 
				{name: "Bancor Protocol", location: "Tel Aviv, Israel", description: "Ethereum-based token conversion protocol that uses reserve tokens to support trading liquidity and to back the creation of new tokens.", blockchain: "Ethereum"}, 
				{name: "Basic Attention Token", location: "San Francisco, CA", description: "A network browser that automatically blocks ads and trackers while providing a payment system for advertisers to pay user to view their content, and users to donate to publishers to view theirs.", blockchain: "Ethereum"}, 
				{name: "Mysterium Network", location: "Lithuania", description: "A decentralized, peer to peer based, serverless VPN network built using Ethereum contracts.", blockchain: "Ethereum"}, 
				{name: "Storj", location: "British Virgin Islands", description: "A network for peer-to-peer sale of decentralized cloud storage.", blockchain: "Ethereum"}, 
				{name: "Aragon", blockchain: "Ethereum"}, 
				{name: "TokenCard", blockchain: "Ethereum"}, 
				{name: "MobileGo", location: "Dispersed", description: "A mobile gaming platform to buy in-game content and create gamer profiles to compete in live tournaments, gain early access to games' private betas and achieve gaming social status", blockchain: "Ethereum & Waves"}, 
				{name: "Gnosis", blockchain: "Ethereum"}, 
				{name: "IEX.EC", location: "Lyon, France", description: "A decentralized marketplace for computing resources", blockchain: "Ethereum"}, 
				{name: "Cosmos Network"}, 
				{name: "Humaniq", location: "Novosibirsk, Russia", description: "Provides a financial banking app with biometric technology in the hopes of expanding banking services to those in undeveloped countries that are underbanked.", blockchain: "Ethereum"}, 
				{name: "Aeternity", location: "Liechtenstein", description: "A smart contract platform that stores contracts off chain to increase efficiency. Aeternity uses a native oracle machine to read off chain data."}, 
				{name: "Matchpool"}, 
				{name: "TaaS", location: "Singapore", description: "A closed-end, crypto-asset fund dedicated to blockchain markets with quarterly dividend payouts", blockchain: "Ethereum"}, 
				{name: "Qtum", location: "Singapore", description: "A proof-of-stake, smart-contract compatible protocol that works with both Ethereum and Bitcoin dapps.", blockchain: "Bitcoin & Ethereum"}, 
				{name: "Chronobank", location: "Australia", description: "A platform for people to buy and sell labor. Labor Hour tokens (LH) are backed by people-hours.", blockchain: "Ethereum"}, 
				{name: "Golem", location: "Poland", description: "A peer-to-peer network for the sale of computing resources", blockchain: "Ethereum"}, 
				{name: "SingularDTV", location: "Switzerland", description: "Along with producing original content in the form of documentaries, SingularDTV is a blockchain-based content management platform where artists can sell their work and the company will post other original content after acquiring their rights", blockchain: "Ethereum"}, 
				{name: "FirstBlood", location: "Boston, MA", description: "FirstBlood is a decentralized app, built on top of Ethereum, that allows eSports enthusiasts to compete in their favorite games through a decentralized, automated platform", blockchain: "Ethereum"}, 
				{name: "ICONOMI", location: "Slovenia", description: "ICONOMI is a decentralized crypto-fund platform, providing an index fund and hedge fund for cryptocurrencies.", blockchain: "Ethereum"}, 
				{name: "Waves", location: "Russia", description: "WAVES is a crypto-platform for asset/custom token issuance, transfer, and trading on blockchain. It's a cryptocurrency platform with emphasis on custom token creation, transfer and decentralized trading, with deep fiat integration and focus on community-backed projects.", blockchain: "Waves"}, 
				{name: "Lisk", location: "Berlin, Germany", description: "A decentralized application platform allows the deployment, distribution and monetisation of decentralized applications and custom blockchains onto the Lisk blockchain.", blockchain: "Ethereum"}, 
				{name: "Augur", blockchain: "Ethereum"}, 
				{name: "Ethereum"}, 
				{name: "Cofound.it"}, 
				{name: "Patientory"}, 
				{name: "Metal"}, 
				{name: "Aira"}, 
				{name: "BidLend"}, 
				{name: "Monaco"}, 
				{name: "Suretly"}, 
				{name: "Minexcoin"}, 
				{name: "Zrcoin"}, 
				{name: "BOScoin"}, 
				{name: "Nexxus"}, 
				{name: "VOISE"}, 
				{name: "Embermine"}, 
				{name: "Ether for the Rest of the World"}, 
				{name: "Quantum Resistant Ledger"}, 
				{name: "Viva Coin"}, 
				{name: "Adel"}, 
				{name: "BitcoinGrowthFund"}, 
				{name: "Back to Earth"}, 
				{name: "Sikoba"}, 
				{name: "Veritaseum"}, 
				{name: "Exscudo"}, 
				{name: "Legends Room"}, 
				{name: "Ethbits"}, 
				{name: "Rchain"}, 
				{name: "MetaGold"}, 
				{name: "Lunyr"}, 
				{name: "Creativechain"}, 
				{name: "Joberr"}, 
				{name: "Edgeless"}, 
				{name: "Apptrade"}, 
				{name: "Chain of Points"}, 
				{name: "Peerplays"}, 
				{name: "Melon"}, 
				{name: "Dfinity"}, 
				{name: "Lykke"}, 
				{name: "Equibit"}, 
				{name: "Augmentors"}, 
				{name: "Wings"}, 
				{name: "vDice"}, 
				{name: "Ark"}, 
				{name: "Komodo"}, 
				{name: "Bitgirls"}, 
				{name: "DarkSilk"}, 
				{name: "Decent"}, 
				{name: "Hong Coin"}, 
				{name: "Antshares", location: "Shanghai, China", description: "Antshares is a decentralized network protocol based on blockchain technology. People can use it to digitalize assets or shares, and accomplish financial business such as registration and issuing, transactions, settlement and payment through a peer-to-peer network."}, 
				{name: "Kibo"}, 
				{name: "Synereo"}, 
				{name: "Lykke"}, 
				{name: "DeClouds"}, 
				{name: "BlockPay"}, 
				{name: "Metaverse"}, 
				{name: "Incent"}, 
				{name: "Tao Network"}
]

	networks.each do |network|  
		puts "#{coin[:name]} — #{Network.friendly.exists? coin[:name].downcase}"
		if Network.friendly.exists? network[:name].downcase
			n = Network.friendly.find(network[:name])
			unless network[:location].nil?
				n.team_location = network[:location]
			end
			unless network[:description].nil?
				n.description = network[:description]
			end
			unless network[:blockchain].nil?
				n.blockchain = network[:blockchain]
			end			
			n.save
		else 
			n = Network.new
			n.name = network[:name]
			unless network[:location].nil?
				n.team_location = network[:location]
			end
			unless network[:description].nil?
				n.description = network[:description]
			end
			unless network[:blockchain].nil?
				n.blockchain = network[:blockchain]
			end			
			n.save
		end
	end

end
