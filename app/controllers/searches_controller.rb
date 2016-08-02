class SearchesController < ApplicationController

	def results
		@query = params[:query]
		@results = Coin.search(params[:query]) 
	end

end
