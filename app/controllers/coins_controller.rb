class CoinsController < ApplicationController
	respond_to? :html, :js

	def index
		page_title = "Coins"
		@coins = Coin.all
	end

	def show
		@coin = Coin.friendly.find(params[:id])
	end

	def new
		@use_ajax = false
		@coin = Coin.new
	end

	def edit
		@use_ajax = true
		@coin = Coin.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@use_ajax = false
		@coin = Coin.new(coin_params)
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

	private

	    def coin_params
	    	params.require(:coin).permit(:name, :coin_status, :coin_info, :application_name, :application_description, :application_status, :category_id, :logo)
	    end

end