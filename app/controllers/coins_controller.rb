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
		@coin = Coin.new(params[:coin])
	    if @coin.save
	      redirect_to @coin
		else
	      
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

end