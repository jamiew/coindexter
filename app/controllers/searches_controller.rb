class SearchesController < ApplicationController

	def results
		@query = params[:query]
		@coin_results = Coin.search(params[:query]) 
		@network_results = Network.search(params[:query]) 
		@whitepaper_results = Whitepaper.search(params[:query])
		result_categories = []
		@coin_results.each do |result|
			result_categories << result.category
		end
		@network_results.each do |result|
			result_categories << result.category
		end
		@whitepaper_results.each do |result|
			result_categories << result.category
		end
		@result_categories = result_categories.uniq
		puts "result categories are "
		@result_categories.each do |cat|
			puts cat.name
		end
	end
	
end
