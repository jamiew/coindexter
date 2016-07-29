class CoinsController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		page_title = "Coins"
		@coins = Coin.all
	end

	def show
		@coin = Coin.friendly.find(params[:id])
		unless @coin.one_day_price_change.nil?
			if @coin.one_day_price_change > 0
				@one_day_up = "up"
			else
				@one_day_up = "down"
			end
		end
		unless @coin.one_hour_price_change.nil? 
			if @coin.one_hour_price_change > 0
				@one_hour_up = "up"
			else
				@one_hour_up = "down"
			end
		end
	end

	def new
		@use_ajax = true
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
		@coin = Coin.new(coin_params)
	    if @coin.save
	    	@coin.update_prices
	    	@coin.save
			redirect_to @coin
		else
	        render 'new'
	    end
	end

	def update
		@coin = Coin.friendly.find(params[:id])
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
	    	params.require(:coin).permit(:name, :coin_status, :coin_info, :application_name, :application_description, :application_status, :application_url, :category_id, :logo, :slug, :has_application)
	    end

end