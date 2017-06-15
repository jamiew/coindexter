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
		@query = params[:query]
		@network = Network.friendly.find(params[:network])
		@coin_results = Coin.search(params[:query])
		respond_to do |format|
	        format.js 
	    end
	end

	def network_search
		@query = params[:query]
		puts "query is #{@query}"
		@network_results = Network.search(params[:query])
		respond_to do |format|
	        format.js 
	    end
	end

	def network_match
		@query = params[:query]
		@network = Network.friendly.find(params[:network])
		query_length = @query.length
		@network.coins.each do |coin|
			if(coin.name[0..query_length - 1].downcase == @query.downcase)
				@matching_coin = coin
			else
				@matching_coin
			end
		end
		respond_to do |format|
	        format.js 
	    end
	end
	
end
