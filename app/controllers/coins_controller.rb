class CoinsController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update,:follow,:unfollow]


	def index
		page_title = "Coins"
		coins = Coin.all.order("market_cap DESC")
		@coins_live = coins.reject {|c| c.coin_status != "live"}
		@coins_preproduction = coins.reject {|c| c.coin_status != "preproduction"}
		@coins_concept = coins.reject {|c| c.coin_status != "concept"}
		@coins_dead = coins.reject {|c| c.coin_status != "dead"}
	end

	def logs
		@active_item = "log"
        coin_logs = NetworkService.new
        if params[:id].nil?
        	@coin = Coin.friendly.find(params[:coin_id]) 
        else
        	@coin = Coin.friendly.find(params[:id]) 
        end
        logs = coin_logs.get_logs(@coin, "coin_log").reverse
        @logs = logs.paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end	

	def show
		@active_item = "details"
		@coin = Coin.friendly.find(params[:id])
		@network = Network.friendly.find(params[:network_id])
		if current_user && current_user.following?(@coin)
			@following = true
		else 
			@following = false
		end
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
		@coin.build_repository
	end

	def ico
		@active_item = "ico"
		@coin = Coin.friendly.find(params[:id])
		@network = Network.friendly.find(params[:network_id])
		if current_user && current_user.following?(@coin)
			@following = true
		else 
			@following = false
		end
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def edit_ico
		@use_ajax = false
		@network = Network.friendly.find(params[:network_id])
		@coin = Coin.friendly.find(params[:id])
	end


	def edit
		@use_ajax = false
		@network = Network.friendly.find(params[:network_id])
		@coin = Coin.friendly.find(params[:id])
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
		@coin.network = @network
	    if @coin.save
	    	if @coin.coin_status == "live"
	    		if @coin.price.nil?
	    			@fetching_price = true
	    		end    		
	    	end
	    	redirect_to network_coin_path(@network, @coin)
		else
	        render 'new'
	    end
	end

	def add_network
		@network = Network.friendly.find(params[:network_id])
		@coin = Coin.friendly.find(params[:id])
		@coin.network = @network
		@coin.save
		redirect_to network_coin_path(@network, @coin)
	end

	def update
		@coin = Coin.friendly.find(params[:id])
		@network = Network.friendly.find(params[:network_id])
	  	if @coin.update_attributes(coin_params)
	  		@coin.network = @network
    		@coin.save
    		if @coin.coin_status == "live"
    			if @coin.price.nil?
	    			@fetching_price = true
	    			puts "@fetching price #{@fetching_price}"
	    		end
	    		id = @coin.id
	    		puts "id is #{id}"
	    		UpdateSingleCoinPriceWorker.perform_async(id)
    		end
    		redirect_to network_coin_path(@network, @coin)
		else
	    	flash[:alert] = @coin.errors.messages
	    	render 'edit'
	  	end
	end

	def destroy
		@coin.destroy
	end

	def sales
		@previous_sales = Coin.where('saledate <= ?', Time.now).order(saledate: :desc).group_by { |sale| sale.send(:saledate).strftime('%B %Y') }
		@upcoming_sales = Coin.where('saledate > ?', Time.now).order(saledate: :desc).group_by { |sale| sale.send(:saledate).strftime('%B %Y') }
	end

	def follow
		@coin = Coin.friendly.find(params[:id])
		@user = current_user
		@network = @coin.network
		if @user.follow(@coin)
			unless @coin.network.nil?
				@user.follow(@coin.network)
			end
			@success = true
		end
		respond_to do |format|
		    format.html
		    format.js { flash.now[:notice] = "You will receive updates about this coin and its parent network via email" }
		    format.json
		end
	end

	def unfollow
		@coin = Coin.friendly.find(params[:id])
		@user = current_user
		@network = @coin.network
		if @user.stop_following(@coin)
			unless @coin.network.nil?
				@user.stop_following(@coin.network)
			end
			@success = true
		end
		respond_to do |format|
		    format.html
		    format.js { flash.now[:alert] = "You will no receive updates about this coin and its parent network via email" }
		    format.json
		end
	end

	private

	    def coin_params
	    	params.require(:coin).permit(:name, :symbol, :coin_status, :coin_info, :application_name, :application_description, :application_status, :application_url, :category_id, :logo, :slug, :coin_type, :saledate, :differentiator, :proof_algorithm, :network_id, :capital_raised, :ico_use_of_proceeds, :ico_token_sale_structure, :ico_pricing, :ico_amount_sold, :ico_allocation, :ico_lockup, :ico_buyer_lockup, :ico_founder_lockup, :ico_min_investment_cap, :ico_type_of_min_cap, :ico_max_investment_cap, :ico_currency_accepted, :ico_additional_notes, :ico_planned_end_date, :ico_actual_end_date, networks: [], network_id: [], exchanges: {}, repositories: {}, repositories_attributes: [:name, :url, :_destroy], exchanges_attributes: [:name, :url, :_destroy])
	    end

		def up_or_down(value)
			if value > 0
				return "up"
			else
				return "down"
			end
		end
end