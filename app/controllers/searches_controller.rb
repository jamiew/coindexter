class SearchesController < ApplicationController

	def results
		@query = params[:query]
		@categories = Category.all
		@coin_results = Coin.search(params[:query]) 
		@network_results = Network.search(params[:query]) 
		@whitepaper_results = Whitepaper.search(params[:query])
		puts "Network results are #{@network_results.inspect}"
	end

	def results_filtered
		@query = params[:query]
		@categories = Category.all
		@results = Coin.search(params[:query])
	end

end
