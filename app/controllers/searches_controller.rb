class SearchesController < ApplicationController

	def results
		@query = params[:query]
		@categories = Category.all
		@results = Coin.search(params[:query]) 
	end

	def results_filtered
		@query = params[:query]
		@categories = Category.all
		@results = Coin.search(params[:query])
	end

end
