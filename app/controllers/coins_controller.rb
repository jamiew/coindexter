class CoinsController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		page_title = "Coins"
		@categories = Category.all
	end

	def sorted_by_market_cap
		@coins = Coin.all.order(market_cap: 'desc')
	end

	def links
		@links = Coin.friendly.find(params[:id]).links
		@coin = Coin.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def trollbox

	end

	def logs
		@coin = Coin.friendly.find(params[:id])
		all_versions = @coin.versions.reverse
		@logs = []
		all_versions.each do |version|
			version.changeset.each do |key, value|
				log = {}
				case key
				when "repositories"
					data_type = "Repository"
					unless value.first.first[:url] == value.second.first[:url] && value.first.first[:name] == value.second.first[:name]
						if value.first.first[:url] == "" 
							type = "added"
						else
							type = "edited"
						end
						log[:data] = {change: version.changeset[:repositories], change_type: type}
					end
				when "coin_info"
					data_type = "Additional info"
					if value.first == ""
						type = "added"
					else
						type = "edited"
					end
					log[:data] = {change: version.changeset[:coin_info], change_type: type}
				end
				log[:data_type] = data_type
				unless log[:data].nil?
					log[:user] = version.user
					log[:created_at] = version.created_at
					@logs << log
				end
			end
		end
		puts @logs
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
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def new
		@use_ajax = true
		@coin = Coin.new
		@coin.build_repository
		puts "It is #{@coin.repositories}"
	end

	def edit
		@use_ajax = false
		@coin = Coin.friendly.find(params[:id])
		puts "It is #{@coin.repositories}"
	end

	def create
		@coin = Coin.new(coin_params)
	    if @coin.save
	    	@coin.category_id = 2 ? @coin.category_id.nil? : @coin.category_id
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
	    	params.require(:coin).permit(:name, :coin_status, :coin_info, :application_name, :application_description, :application_status, :application_url, :category_id, :logo, :slug, :type, :network_id, :repositories, repositories_attributes: [:name, :url, :destroy])
	    end

	    def set_has_application(coin)
	    	unless @coin.application_url.nil? && @coin.application.name.nil? && application_description.nil?
				@coin.has_application = true
			end
		end
end