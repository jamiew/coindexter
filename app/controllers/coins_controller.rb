class CoinsController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		page_title = "Coins"
		coins = Coin.all.order("market_cap DESC")
		@coins_live = coins.reject {|c| c.coin_status != "live"}
		@coins_preproduction = coins.reject {|c| c.coin_status != "preproduction"}
		@coins_concept = coins.reject {|c| c.coin_status != "concept"}
		@coins_dead = coins.reject {|c| c.coin_status != "dead"}
	end

	def links
		@links = Coin.friendly.find(params[:id]).links.paginate(:page => params[:page], :per_page => 10)
		@coin = Coin.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def logs
        coin_logs = NetworkService.new
        @coin = Coin.friendly.find(params[:id]) 
        logs = coin_logs.get_logs(@coin, "coin_log").reverse
        @logs = logs.paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end	

	def show
		@coin = Coin.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def new
		@use_ajax = true
		@network = Network.friendly.find(params[:network_id])
		@coin = @network.coins.new
		puts "the network is #{@coin.network.inspect}"
		@coin.build_repository
	end

	def edit
		@use_ajax = false
		@network = Network.friendly.find(params[:network_id])
		@coin = @network.coins.friendly.find(params[:id])
		if @coin.repositories.empty?
			@coin.build_repository
		end
		if @coin.exchanges.empty?
			@coin.build_exchange
		end
	end

	def create
		@network = Network.friendly.find(params[:network_id])
		@coin = Coin.new(coin_params)
	    if @coin.save
	    	@coin.category_id = 2 ? @coin.category_id.nil? : @coin.category_id
	    	@coin.update_prices
	    	@coin.network = @network
	    	@coin.save
	    	puts "the coin is #{@coin.inspect}"
			redirect_to network_coin_path(@network, @coin)
		else
	        render 'new'
	    end
	end

	def update
		@coin = Coin.friendly.find(params[:id])
	  	if @coin.update_attributes(coin_params)
	    	redirect_to redirect_to network_coin_path(network, @coin)
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@coin.destroy
	end

	private

	    def coin_params
	    	params.require(:coin).permit(:name, :symbol, :coin_status, :coin_info, :application_name, :application_description, :application_status, :application_url, :category_id, :logo, :slug, :coin_type, :network_id, networks: [], network_ids: [], exchanges: {}, repositories: {}, repositories_attributes: [:name, :url, :_destroy], exchanges_attributes: [:name, :url, :_destroy])
	    end

		def up_or_down(value)
			if value > 0
				return "up"
			else
				return "down"
			end
		end
end