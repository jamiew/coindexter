class UpdateAllCoinPricesAltWorker
  include Sidekiq::Worker
  sidekiq_options({
    unique: :all,
    expiration: 24 * 60 * 60
  })
  sidekiq_options :retry => false

	def perform

		fullCoinList = JSON.parse(HTTParty.get('https://www.cryptocompare.com/api/data/coinlist/').body)

	end

end