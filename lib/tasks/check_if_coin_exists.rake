task :check_if_coin_exists => :environment do

	networks = [
				{name: "Civic", location: "San Francisco, CA", description: "On-demand, secure and low-cost access to identity verification via the blockchain", blockchain: "Ethereum"},
				{name: "Status", location: "Switzerland", description: "An open source consumer mobile messaging app to interact with decentralized applications that run on the Ethereum Network."}, 
				{name: "Bancor", location: "Tel Aviv, Israel", description: "Ethereum-based token conversion protocol that uses reserve tokens to support trading liquidity and to back the creation of new tokens.", blockchain: "Ethereum"},
				{name: "Basic Attention Token", location: "San Francisco, CA", description: "A network browser that automatically blocks ads and trackers while providing a payment system for advertisers to pay user to view their content, and users to donate to publishers to view theirs.", blockchain: "Ethereum"},
				{name: "Mysterium", location: "Lithuania", description: "A decentralized, peer to peer based, serverless VPN network built using Ethereum contracts.", blockchain: "Ethereum"},
				{name: "Storj", location: "British Virgin Islands", description: "A network for peer-to-peer sale of decentralized cloud storage.", blockchain: "Ethereum"},
				{name: "Aragon", blockchain: "Ethereum"},
				{name: "TokenCard", blockchain: "Ethereum"},
				{name: "MobileGo", location: "Dispersed", description: "A mobile gaming platform to buy in-game content and create gamer profiles to compete in live tournaments, gain early access to games' private betas and achieve gaming social status", blockchain: "Ethereum & Waves"},
				{name: "Gnosis", blockchain: "Ethereum"},
				{name: "IEX.EC", location: "Lyon, France", description: "A decentralized marketplace for computing resources", blockchain: "Ethereum"},
				{name: "Cosmos"}, 
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
				{name: "Tao Network"}, 
				{name: "Plimst"}, 
				{name: "CryptoChip"}, 
				{name: "0x"}, 
				{name: "Indorse"}, 
				{name: "OneGram"}, 
				{name: "Hive Project"}, 
				{name: "district0x Network"}, 
				{name: "onG.social"}, 
				{name: "MyBit"}, 
				{name: "Populous"}, 
				{name: "Agrello"}, 
				{name: "Starta"}, 
				{name: "Starbase"}, 
				{name: "Tezos"}, 
				{name: "XinFin Foundation"}, 
				{name: "Santiment"}, 
				{name: "Stremio Adex"}, 
				{name: "SunContract"}, 
				{name: "Dao.Casino"}, 
				{name: "OmiseGO"}, 
				{name: "Impak Coin"}, 
				{name: "Nimiq"}, 
				{name: "TenX"}, 
				{name: "SkinCoin"}, 
				{name: "SilverCoin"}, 
				{name: "Gilgam"}, 
				{name: "Status"}, 
				{name: "Xarcade"}, 
				{name: "Corion Platform"}, 
				{name: "SONM"}, 
				{name: "CompCoin"}, 
				{name: "Orocrypt"}, 
				{name: "Honestis Network"}, 
				{name: "SuperDAO"}, 
				{name: "FundYourselfNow"}, 
				{name: "21 Million"}, 
				{name: "OnPlace"}, 
				{name: "Giga Watt"}, 
				{name: "Gene-ChainCoin"}, 
				{name: "Prospectors"}, 
				{name: "Air"}, 
				{name: "DCORP"}, 
				{name: "Wagerr"}, 
				{name: "Polybius"}, 
				{name: "Moeda"}, 
				{name: "Octanox"}, 
				{name: "FootballCoin"}, 
				{name: "MaskNetwork"}, 
				{name: "NVO"}, 
				{name: "Crypviser"}, 
				{name: "Live-Streaming"}, 
				{name: "EncryptoTel"}, 
				{name: "EcoBit"}, 
				{name: "LeviarCoin"}, 
				{name: "Internet of Coins"}
	]

	coins = [
		{name: "ICONOMI",symbol: "ICN",sale_date: "2016-08-25",ico_actual_end_date: "2016-09-26",ico_planned_end_date: "2016-09-26",capital_raised: "10355054.2",coin_info: "Token holders get weekly dividends based on the two funds' asset management fees and performance fees",coin_status: "concept",ico_use_of_proceeds: "No formal breakdown of proceeds. Proceeds will be put to the development and release of the ICONOMI platform",ico_token_sale_structure: "Capped one-time sale with bonus schedule",coin_pricing: "First week: 15% bonus, Second week: 10% bonus, Third week: 5% bonus. 10 days after ICO, distribution to investors will be determined by their contribution and bonus rate",ico_amount_sold: "100000000",ico_allocation: "85% to investors, 2% to adivsors, 8% to team, 3% to future team, 2% for bounties",ico_buyer_lockup: "10 days after ICO",ico_founder_lockup: "10 days after ICO",ico_min_investment_cap: "2000 BTC",ico_type_of_min_cap: "Disclosed",ico_max_investment_cap: "10,000 BTC",ico_type_of_max_cap: "Disclosed",ico_currency_accepted: "BTC, ETH, LSK, USD & EUR"},
		{name: "Waves",symbol: "WAVES",sale_date: "2016-04-12",ico_actual_end_date: "2016-05-31",ico_planned_end_date: "2016-05-31",capital_raised: "16010008",coin_info: "WAVES are needed in order to create customer tokens on the Waves platform.",coin_status: "concept",ico_use_of_proceeds: "Development of the platform",coin_pricing: "First ICO Day bonus: 20%, Before end of April: 10% bonus, May 1 - May 15: 5% bonus",ico_amount_sold: "100000000",ico_allocation: "85,000,000 to investors, 15,000,000 for core activities: 1 million for pre-ICO bounties, 1 million for post-ICO bounties, 4 million for strategic partners & backers, 9 million to the development team",ico_buyer_lockup: "Until end of ICO",ico_founder_lockup: "Until end of ICO",ico_min_investment_cap: "None",ico_type_of_min_cap: "None",ico_max_investment_cap: "None",ico_type_of_max_cap: "None",ico_currency_accepted: "USD & CAD"},
		{name: "Lisk",symbol: "LSK",sale_date: "2016-02-22",ico_actual_end_date: "2016-03-21",ico_planned_end_date: "2016-03-21",capital_raised: "5700000",coin_info: "LSK tokens are used to use the LSK dev platform or pay others to use it. Also, every LSK holder can vote for mainchain delegates which are securing the network.",coin_status: "concept",ico_use_of_proceeds: "Money will be used in the ecosystem for promotions, advertisements, salaries, travel costs, conference visits, sponsoring, Dapp fundings, development, designs, contractors, infrastructure, necessary devices, meetings, hostel/hotel costs and more.",ico_token_sale_structure: "Capped one-time sale with a bounty program without a cap on amount raised",coin_pricing: "0.0001821238671 BTC/LSK
		First week: 15% bonus, Second week: 10% bonus, Third week: 5% bonus, Fourth week: 0% bonus",ico_amount_sold: "100000000",ico_allocation: "85% for investors, 8% for core team, 4% for campaigns & bounties, 2% for advisors & partners, 1% for social bounty campaigns",ico_buyer_lockup: "Yes, paid out once first blocks have been forged successfully",ico_founder_lockup: "Yes, paid out once first blocks have been forged successfully",ico_min_investment_cap: "None",ico_type_of_min_cap: "None",ico_max_investment_cap: "None",ico_type_of_max_cap: "None",ico_currency_accepted: "BTC, XCR, ETH & partnership with shapeshift to accept any Altcoins"},
		{name: "Augur",symbol: "REP",sale_date: "2015-08-17",ico_actual_end_date: "2015-10-01",capital_raised: "5300000",coin_info: "Augur's Reputation tokens (REP) are held by reporters, who report on the outcome of events within Augur. Each token entitles the reporter to 1/22,000,000th of Augur's total market fees. ",coin_status: "concept",coin_pricing: "Aug 17 - Aug 22, 12:00pm (EST) 15% Discount True Augur. Aug 22 - Aug 27, 12:00pm (EST) 10% Discount Prophet. Aug 27 - Sep 5, 12:00pm (EST) 5% Discount Nate Silver. Sep 5 - Oct 1, 12:00pm (EST) No Discount Weatherman.",ico_amount_sold: "11000000"},
		{name: "Ethereum",symbol: "ETH",sale_date: "2014-07-20",ico_actual_end_date: "2014-09-02",ico_planned_end_date: "2014-09-02",capital_raised: "18400000",coin_info: "Ethereum's native value token, Ether, is mined through a Proof of Work protocol that is set to change to Proof of Stake. Ether is simply a token useful for paying transaction fees or building or purchasing decentralized application services on the Ethereum platform",coin_status: "concept",ico_token_sale_structure: "Uncapped",coin_pricing: "First 14 days: 2,000 ETH per BTC, Rest of the time: 1,337 ETH per BTC",ico_amount_sold: "Uncapped",ico_buyer_lockup: "Lockup until genesis block launches",ico_founder_lockup: "Lockup until genesis block launches"},
		{name: "Cofound.it",symbol: "CFI",sale_date: "2017-06-04",ico_actual_end_date: "2017-06-06",capital_raised: "--",coin_status: "concept"},
		{name: "Patientory",symbol: "PTOY",sale_date: "2017-05-31",ico_actual_end_date: "2017-06-03",capital_raised: "--",coin_status: "concept"},
		{name: "Metal",symbol: "METAL",sale_date: "2017-05-26",ico_actual_end_date: "2017-05-26",capital_raised: "--",coin_status: "concept"},
		{name: "Aira",symbol: "AIR",sale_date: "2017-05-25",ico_actual_end_date: "2017-06-11",capital_raised: "--",coin_status: "concept"},
		{name: "BidLend",symbol: "BLC",sale_date: "2017-05-20",ico_actual_end_date: "2017-06-19",capital_raised: "--",coin_status: "concept"},
		{name: "Monaco",symbol: "MCO",sale_date: "2017-05-18",ico_actual_end_date: "2017-06-18",capital_raised: "--",coin_status: "concept"},
		{name: "Suretly",symbol: "SUR",sale_date: "2017-05-16",ico_actual_end_date: "2017-05-30",capital_raised: "--",coin_status: "concept"},
		{name: "Minexcoin",symbol: "MNC",sale_date: "2017-05-15",ico_actual_end_date: "2017-06-13",capital_raised: "--",coin_status: "concept"},
		{name: "Zrcoin",symbol: "ZRC",sale_date: "2017-05-11",ico_actual_end_date: "2017-06-09",capital_raised: "--",coin_status: "concept"},
		{name: "BOScoin",symbol: "BOS",sale_date: "2017-05-09",ico_actual_end_date: "2017-05-10",capital_raised: "--",coin_status: "concept"},
		{name: "Nexxus",symbol: "NXX",sale_date: "2017-05-08",ico_actual_end_date: "2017-05-08",capital_raised: "Canceled",coin_status: "concept"},
		{name: "VOISE",symbol: "VSM",sale_date: "2017-05-06",ico_actual_end_date: "2017-06-06",capital_raised: "--",coin_status: "concept"},
		{name: "Embermine",symbol: "EMB",sale_date: "2017-05-05",ico_actual_end_date: "2017-06-02",capital_raised: "--",coin_status: "concept"},
		{name: "Ether for the Rest of the World",symbol: "E4ROW",sale_date: "2017-05-02",ico_actual_end_date: "2017-05-22",capital_raised: "--",coin_status: "concept"},
		{name: "Quantum Resistant Ledger",symbol: "QRL",sale_date: "2017-05-01",ico_actual_end_date: "2017-05-07",capital_raised: "2808000",coin_status: "concept"},
		{name: "Viva Coin",symbol: "VIVA",sale_date: "2017-05-01",ico_actual_end_date: "2017-05-21",capital_raised: "--",coin_status: "concept"},
		{name: "Adel",symbol: "ADL",sale_date: "2017-05-01",ico_actual_end_date: "2017-06-01",capital_raised: "--",coin_status: "concept"},
		{name: "BitcoinGrowthFund",symbol: "MCAP",sale_date: "2017-04-27",ico_actual_end_date: "2017-05-17",capital_raised: "--",coin_status: "concept"},
		{name: "Back to Earth",symbol: "SRC",sale_date: "2017-04-26",ico_actual_end_date: "2017-04-28",capital_raised: "971250",coin_status: "concept"},
		{name: "Sikoba",symbol: "SKO",sale_date: "2017-04-25",ico_actual_end_date: "2017-05-15",capital_raised: "--",coin_status: "concept"},
		{name: "Veritaseum",symbol: "VER",sale_date: "2017-04-25",ico_actual_end_date: "2017-05-26",capital_raised: "--",coin_status: "concept"},
		{name: "Exscudo",symbol: "EON",sale_date: "2017-04-25",ico_actual_end_date: "2017-05-31",capital_raised: "--",coin_status: "concept"},
		{name: "Legends Room",symbol: "LGD",sale_date: "2017-04-18",ico_actual_end_date: "2017-05-15",capital_raised: "--",coin_status: "concept"},
		{name: "Ethbits",symbol: "ETB",sale_date: "2017-04-15",ico_actual_end_date: "2017-05-15",capital_raised: "--",coin_status: "concept"},
		{name: "Rchain",symbol: "RCOIN",sale_date: "2017-04-05",ico_actual_end_date: "2017-04-16",capital_raised: "N/A",coin_status: "concept"},
		{name: "MetaGold",symbol: "MEG",sale_date: "2017-04-03",ico_actual_end_date: "2017-04-08",capital_raised: "Refunded",coin_status: "concept"},
		{name: "Lunyr",symbol: "LUN",sale_date: "2017-03-29",ico_actual_end_date: "2017-04-28",capital_raised: "--",coin_status: "concept"},
		{name: "Creativechain",symbol: "CREA",sale_date: "2017-03-15",ico_actual_end_date: "2017-05-01",capital_raised: "--",coin_status: "concept"},
		{name: "Joberr",symbol: "JOBERR",sale_date: "2017-03-12",ico_actual_end_date: "2017-03-26",capital_raised: "23449",coin_status: "concept"},
		{name: "Edgeless",symbol: "EDG",sale_date: "2017-02-28",ico_actual_end_date: "2017-03-21",capital_raised: "2650788",coin_status: "concept"},
		{name: "Apptrade",symbol: "APPX",sale_date: "2017-02-28",ico_actual_end_date: "2017-04-30",capital_raised: "--",coin_status: "concept"},
		{name: "Chain of Points",symbol: "POINTS",sale_date: "2017-02-26",ico_actual_end_date: "2017-03-31",capital_raised: "--",coin_status: "concept"},
		{name: "Peerplays",symbol: "PPY",sale_date: "2017-02-26",ico_actual_end_date: "2017-05-15",capital_raised: "--",coin_status: "concept"},
		{name: "Melon",symbol: "MLN",sale_date: "2017-02-15",ico_actual_end_date: "2017-02-15",capital_raised: "2900000",coin_status: "concept"},
		{name: "Dfinity",symbol: "DFN",sale_date: "2017-02-11",ico_actual_end_date: "2017-02-12",capital_raised: "3750000",coin_status: "concept"},
		{name: "Lykke",symbol: "LKK",sale_date: "2017-02-09",ico_actual_end_date: "2017-02-28",capital_raised: "1973554",coin_status: "concept"},
		{name: "Equibit",symbol: "EQB",sale_date: "2017-02-01",ico_actual_end_date: "2017-03-31",capital_raised: "552000",coin_status: "concept"},
		{name: "Augmentors",symbol: "DBT",sale_date: "2017-01-31",ico_actual_end_date: "2017-03-01",capital_raised: "1087000",coin_status: "concept"},
		{name: "Wings",symbol: "WINGS",sale_date: "2016-11-18",ico_actual_end_date: "2017-01-06",capital_raised: "2074000",coin_status: "concept"},
		{name: "vDice",symbol: "VSL",sale_date: "2016-11-15",ico_actual_end_date: "2016-12-15",capital_raised: "1647000",coin_status: "concept"},
		{name: "Ark",symbol: "ARK",sale_date: "2016-11-07",ico_actual_end_date: "2016-12-11",capital_raised: "1000000",coin_status: "concept"},
		{name: "Komodo",symbol: "KMD",sale_date: "2016-10-15",ico_actual_end_date: "2016-11-20",capital_raised: "1983000",coin_status: "concept"},
		{name: "Bitgirls",symbol: "TOREKABU",sale_date: "2016-10-03",ico_actual_end_date: "2016-10-31",coin_status: "concept"},
		{name: "DarkSilk",symbol: "DSLK",sale_date: "2017-09-23",ico_actual_end_date: "2016-10-23",ico_planned_end_date: "2016-10-23",coin_status: "concept"},
		{name: "Decent",symbol: "DCT",sale_date: "2016-09-11",ico_actual_end_date: "2016-11-06",coin_status: "concept"},
		{name: "Hong Coin",symbol: "Ħ",sale_date: "2016-08-29",ico_actual_end_date: "2016-09-29",coin_status: "concept"},
		{name: "Antshares",symbol: "ANS",sale_date: "2016-08-08",ico_actual_end_date: "2016-09-07",ico_planned_end_date: "2016-09-07",capital_raised: "4500000",coin_status: "concept"},
		{name: "Kibo",symbol: "KBT",ico_actual_end_date: "2016-11-09",coin_status: "concept"},
		{name: "Synereo",symbol: "AMP",ico_actual_end_date: "2016-10-18",coin_status: "concept"},
		{name: "Lykke",symbol: "LKK",ico_actual_end_date: "2016-10-09",capital_raised: "1147135",coin_status: "concept"},
		{name: "DeClouds",symbol: "DCS",ico_actual_end_date: "2016-10-07",coin_status: "concept"},
		{name: "BlockPay",symbol: "BLOCKPAY",ico_actual_end_date: "2016-09-15",coin_status: "concept"},
		{name: "Metaverse",symbol: "ETP",ico_actual_end_date: "2016-09-05",coin_status: "concept"},
		{name: "Incent",symbol: "INCNT",ico_actual_end_date: "2016-09-01",coin_status: "concept"},
		{name: "Tao Network",symbol: "XTO",ico_actual_end_date: "2016-08-16",coin_status: "concept"},
		{name: "Plimst",symbol: "PLM",sale_date: "2017-10-31",ico_actual_end_date: "2017-11-30",coin_status: "concept"},
		{name: "CryptoChip",symbol: "CRC",sale_date: "2017-09-29",ico_actual_end_date: "2017-10-29",coin_status: "concept"},
		{name: "0x",symbol: "ZRX",sale_date: "2017-09-09",ico_actual_end_date: "2017-10-09",coin_status: "concept"},
		{name: "Indorse",symbol: "IDS",sale_date: "2017-08-08",ico_actual_end_date: "2017-09-09",coin_status: "concept"},
		{name: "OneGram",symbol: "OGC",sale_date: "2017-08-05",ico_actual_end_date: "2017-08-08",coin_status: "concept"},
		{name: "Hive Project",symbol: "HVN",sale_date: "2017-07-30",ico_actual_end_date: "2017-08-30",coin_status: "concept"},
		{name: "district0x Network",symbol: "DNT",sale_date: "2017-07-18",ico_actual_end_date: "2017-08-01",coin_status: "concept"},
		{name: "onG.social",symbol: "ONG",sale_date: "2017-07-17",ico_actual_end_date: "2017-08-17",coin_status: "concept"},
		{name: "MyBit",symbol: "MYB",sale_date: "2017-07-17",ico_actual_end_date: "2017-08-16",coin_status: "concept"},
		{name: "Populous",symbol: "PPT",sale_date: "2017-07-16",ico_actual_end_date: "2017-08-16",coin_status: "concept"},
		{name: "Agrello",symbol: "DLT",sale_date: "2017-07-10",ico_actual_end_date: "2017-08-09",coin_status: "concept"},
		{name: "Starta",symbol: "STA",sale_date: "2017-07-04",ico_actual_end_date: "2017-08-03",coin_status: "concept"},
		{name: "Starbase",symbol: "STAR",sale_date: "2017-07-01",ico_actual_end_date: "2017-08-15",coin_status: "concept"},
		{name: "Tezos",symbol: "XTZ",sale_date: "2017-07-01",ico_actual_end_date: "2017-08-01",coin_status: "concept"},
		{name: "XinFin Foundation",symbol: "XDC",sale_date: "2017-07-01",ico_actual_end_date: "2017-07-30",coin_status: "concept"},
		{name: "Santiment",symbol: "SAN",sale_date: "2017-06-30",ico_actual_end_date: "2017-07-30",coin_status: "concept"},
		{name: "Stremio Adex",symbol: "ADX",sale_date: "2017-06-30",ico_actual_end_date: "2017-07-30",coin_status: "concept"},
		{name: "SunContract",symbol: "SNC",sale_date: "2017-06-30",ico_actual_end_date: "2017-07-28",coin_status: "concept"},
		{name: "Dao.Casino",symbol: "BET",sale_date: "2017-06-29",ico_actual_end_date: "2017-07-26",coin_status: "concept"},
		{name: "OmiseGO",symbol: "OMG",sale_date: "2017-06-27",ico_actual_end_date: "2017-07-27",coin_status: "concept"},
		{name: "Impak Coin",symbol: "MPK",sale_date: "2017-06-26",ico_actual_end_date: "2017-07-26",coin_status: "concept"},
		{name: "Nimiq",symbol: "NET",sale_date: "2017-06-26",ico_actual_end_date: "2017-07-26",coin_status: "concept"},
		{name: "TenX",symbol: "PAY",sale_date: "2017-06-24",ico_actual_end_date: "2017-07-24",coin_status: "concept"},
		{name: "SkinCoin",symbol: "SKIN",sale_date: "2017-06-21",ico_actual_end_date: "2017-07-21",coin_status: "concept"},
		{name: "SilverCoin",symbol: "SVC",sale_date: "2017-06-21",ico_actual_end_date: "2017-07-19",coin_status: "concept"},
		{name: "Gilgam",symbol: "GGS",sale_date: "2017-06-20",ico_actual_end_date: "2017-07-20",coin_status: "concept"},
		{name: "Status",symbol: "SNT",sale_date: "2017-06-20",ico_actual_end_date: "2017-07-03",coin_status: "concept"},
		{name: "Xarcade",symbol: "XAR",sale_date: "2017-06-20",ico_actual_end_date: "2017-06-30",coin_status: "concept"},
		{name: "Corion Platform",symbol: "COR",sale_date: "2017-06-18",ico_actual_end_date: "2017-07-30",coin_status: "concept"},
		{name: "SONM",symbol: "SNM",sale_date: "2017-06-15",ico_actual_end_date: "2017-07-15",coin_status: "concept"},
		{name: "CompCoin",symbol: "CMP",sale_date: "2017-06-14",ico_actual_end_date: "2017-07-31",coin_status: "concept"},
		{name: "Orocrypt",symbol: "OROC",sale_date: "2017-06-14",ico_actual_end_date: "2017-07-14",coin_status: "concept"},
		{name: "Honestis Network",symbol: "HNT",sale_date: "2017-06-14",ico_actual_end_date: "2017-07-05",coin_status: "concept"},
		{name: "SuperDAO",symbol: "SUP",sale_date: "2017-06-13",ico_actual_end_date: "2017-07-12",coin_status: "concept"},
		{name: "FundYourselfNow",symbol: "FYN",sale_date: "2017-06-13",ico_actual_end_date: "2017-07-02",coin_status: "concept"},
		{name: "21 Million",symbol: "21M",sale_date: "2017-06-12",ico_actual_end_date: "2017-06-28",coin_status: "concept"},
		{name: "OnPlace",symbol: "OPL",sale_date: "2017-06-06",ico_actual_end_date: "2017-07-06",coin_status: "concept"},
		{name: "Giga Watt",symbol: "WTT",sale_date: "2017-06-02",ico_actual_end_date: "2017-07-31",coin_status: "concept"},
		{name: "Gene-ChainCoin",symbol: "GeneCC",sale_date: "2017-06-01",ico_actual_end_date: "2017-08-01",coin_status: "concept"},
		{name: "Prospectors",symbol: "OBT",sale_date: "2017-06-01",ico_actual_end_date: "2017-07-01",coin_status: "concept"},
		{name: "Air",symbol: "XID",sale_date: "2017-06-01",ico_actual_end_date: "2017-06-29",coin_status: "concept"},
		{name: "DCORP",symbol: "DRP",sale_date: "2017-06-01",ico_actual_end_date: "2017-06-29",coin_status: "concept"},
		{name: "Wagerr",symbol: "WGR",sale_date: "2017-06-01",ico_actual_end_date: "2017-06-25",coin_status: "concept"},
		{name: "Polybius",symbol: "PLBT",sale_date: "2017-05-31",ico_actual_end_date: "2017-07-05",coin_status: "concept"},
		{name: "Moeda",symbol: "MOEDA",sale_date: "2017-05-28",ico_actual_end_date: "2017-07-28",coin_status: "concept"},
		{name: "Octanox",symbol: "OTX",sale_date: "2017-05-25",ico_actual_end_date: "2017-06-26",coin_status: "concept"},
		{name: "FootballCoin",symbol: "XFC",sale_date: "2017-05-24",ico_actual_end_date: "2017-06-23",coin_status: "concept"},
		{name: "MaskNetwork",symbol: "MSK",sale_date: "2017-05-24",ico_actual_end_date: "2017-06-24",coin_status: "concept"},
		{name: "NVO",symbol: "NVOT",sale_date: "2017-05-23",ico_actual_end_date: "2017-06-25",coin_status: "concept"},
		{name: "Crypviser",symbol: "CVC",sale_date: "2017-05-20",ico_actual_end_date: "2017-06-30",coin_status: "concept"},
		{name: "Live-Streaming",symbol: "LIVE",sale_date: "2017-05-10",ico_actual_end_date: "2017-08-08",coin_status: "concept"},
		{name: "EncryptoTel",symbol: "ETT",sale_date: "2017-04-24",ico_actual_end_date: "2017-07-01",coin_status: "concept"},
		{name: "EcoBit",symbol: "ECOB",sale_date: "2017-04-09",ico_actual_end_date: "2017-08-06",coin_status: "concept"},
		{name: "LeviarCoin",symbol: "XLC",sale_date: "2017-04-07",ico_actual_end_date: "2017-07-09",coin_status: "concept"},
		{name: "Internet of Coins",symbol: "HYBRID",sale_date: "2017-03-21",ico_actual_end_date: "2017-06-21",coin_status: "concept"}
	]

	networks.each do |network|  
		puts "#{network[:name]} — #{Network.friendly.exists? network[:name].downcase.gsub(".","-").gsub(" ","-")}"
		network_exists = Network.friendly.exists? network[:name].downcase.gsub(".","-").gsub(" ","-")
		if network_exists
			n = Network.friendly.find(network[:name].downcase.gsub(".","-").gsub(" ","-"))
			add_network_fields(n, network)
			puts "updating #{network[:name]}"
			n.save
		else 
			n = Network.new
			n.name = network[:name]
			n.status = "concept"
			add_network_fields(n, network)	
			puts "adding #{network[:name]}"
			n.save
		end
	end

	coins.each do |coin| 
		puts "#{coin[:name]} — #{Coin.friendly.exists? coin[:name].downcase}"
		coin_exists = Coin.friendly.exists? coin[:name].downcase.gsub(".","-").gsub(" ","-")
		if coin_exists
			c = Coin.friendly.find(coin[:name].downcase.gsub(".","-").gsub(" ","-"))
			add_coin_fields(c, coin)
			n = Network.friendly.find(coin[:name].downcase.gsub(".","-").gsub(" ","-"))
			c.network = n
			puts "updating #{coin[:name]}"
			c.save
		else 
			c = Coin.new
			add_coin_fields(c, coin)
			n = Network.friendly.find(coin[:name].downcase.gsub(".","-").gsub(" ","-"))
			c.network = n
			puts "adding #{coin[:name]}"
			c.save
		end
	end
end

def add_network_fields(n, network)
	unless network[:location].nil?
		n.team_location = network[:location]
	end
	unless n.description.nil?
		unless network[:description].nil?
			n.description = network[:description]
		end
	end
	unless network[:blockchain].nil?
		n.blockchain = network[:blockchain]
	end	
	return n
end

def add_coin_fields(c, coin)
	unless coin[:capital_raised].nil?
		c.capital_raised = coin[:capital_raised]
	end
	unless coin[:ico_use_of_proceeds].nil?
		c.ico_use_of_proceeds = coin[:ico_use_of_proceeds]
	end
	unless coin[:ico_token_sale_structure].nil?
		c.ico_token_sale_structure = coin[:ico_token_sale_structure]
	end
	unless coin[:capital_raised].nil?
		c.ico_pricing = coin[:ico_pricing]
	end
	unless coin[:ico_amount_sold].nil?
		c.ico_amount_sold = coin[:ico_amount_sold]
	end
	unless coin[:ico_allocation].nil?
		c.ico_allocation = coin[:ico_allocation]
	end
	unless coin[:ico_lockup].nil?
		c.ico_lockup = coin[:ico_lockup]
	end
	unless coin[:ico_buyer_lockup].nil?
		c.ico_buyer_lockup = coin[:ico_buyer_lockup]
	end
	unless coin[:ico_founder_lockup].nil?
		c.ico_founder_lockup = coin[:ico_founder_lockup]
	end
	unless coin[:ico_min_investment_cap].nil?
		c.ico_min_investment_cap = coin[:ico_min_investment_cap]
	end
	unless coin[:ico_type_of_min_cap].nil?
		c.ico_type_of_min_cap = coin[:ico_type_of_min_cap].downcase
	end
	unless coin[:ico_type_of_max_cap].nil?
		c.ico_type_of_max_cap = coin[:ico_type_of_max_cap].downcase
	end
	unless coin[:ico_max_investment_cap].nil?
		c.ico_max_investment_cap = coin[:ico_max_investment_cap]
	end
	unless coin[:ico_currency_accepted].nil?
		c.ico_currency_accepted = coin[:ico_currency_accepted]
	end
	unless coin[:ico_additional_notes].nil?
		c.ico_additional_notes = coin[:ico_additional_notes]
	end
	unless coin[:ico_planned_end_date].nil?
		c.ico_planned_end_date = coin[:ico_planned_end_date]
	end
	unless coin[:ico_actual_end_date].nil?
		c.ico_actual_end_date = coin[:ico_actual_end_date]
	end
	return c
end
