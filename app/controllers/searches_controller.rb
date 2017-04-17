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
		@result_categories = result_categories.uniq
	end

	def coin_search
		puts 'executed'
		@query = params[:query]
		@coin_results = Coin.search(params[:query])
		@coin_results.each do |result|
			puts result.inspect
		end
		render :layout => nil 
		respond_to do |format|

	        format.js
	    end
	end
	
end
