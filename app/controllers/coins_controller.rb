class CoinsController < ApplicationController
	respond_to? :html, :js

	def index
		page_title = "Coins"
		@coins = Coin.all
	end

	def show
		@coin = Coin.find(params[:id])
	end

	def new
		@coin = Coin.new
	end

	def edit
		@coin = Coin.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@categories = Category.all
		@coin.categories.build(coin_params)
		if @coin.save 
			format.html { redirect_to @coin }
			format.js
		else 
			render 'new'
		end
	end

	def update
		@coin = Coin.find(params[:id])
	  	if @coin.update_attributes(coin_params)
	    	redirect_to @coin
		else
	    	render 'edit'
	  	end

	end

	def destroy
		@coin.destroy
	end

	private 
	
		def coin_params 
	    	params.require(:coin).permit(:name, :info_way_to_earn, :info_status, :info_additional, :application_name, :application_description, :application_status, :application_category, :application_category_id, :application_url)
	    end

end