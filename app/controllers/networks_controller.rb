class NetworksController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update,:follow,:unfollow]

	def index
		# @networks = Network.all
		@categories = Category.all.order("name ASC")
		page_title = "networks"
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def links
		@links = Network.friendly.find(params[:id]).links
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def logs
		@active_item = "log"
        network_logs = NetworkService.new
        @network = Network.friendly.find(params[:id]) 
        logs = network_logs.get_logs(@network, "Network").reverse
        @logs = logs.paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end	

	def whitepapers
        @whitepapers = Network.friendly.find(params[:id]).whitepapers
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end		

	def show
		@network = Network.friendly.find(params[:id])
		@whitepapers = @network.whitepapers.all
		if current_user && current_user.following?(@network)
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
		@use_ajax = false
		@network = Network.new
		@network.whitepapers.build
	end

	def edit
		@use_ajax = true
		@network = Network.friendly.find(params[:id])
		@network.whitepapers.build
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@network = Network.new(network_params)
		@network.user = current_user
		@network.founders = params[:founders] 
	    if @network.save
	      if !@network.logo.validate_dimensions
	        render :crop
	      else
			redirect_to @network, notice: "Network created"
		  end
		else
	        render 'new'
	    end
	end

	def update
		@network = Network.friendly.find(params[:id])
		@network.founders = params[:founders] 
	  	if @network.update_attributes(network_params)
	    	if params[:network][:logo].present? and !@network.logo.validate_dimensions
	          render :crop
	        else
	          redirect_to @network, notice: "Network updated"
	        end
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@network.destroy
	end

	def follow
		@network = Network.friendly.find(params[:id])
		@user = current_user
		@coins = @network.coins
		if @user.follow(@network)
			if @network.coins.any?
				@network.coins.each do |coin| 
					@user.follow(coin)
				end
			end
			@success = true
		end
		respond_to do |format|
		    format.html
		    format.js { flash.now[:notice] = "You will receive updates about this network via email" }
		    format.json
		end
	end

	def unfollow
		@network = Network.friendly.find(params[:id])
		@user = current_user
		@coins = @network.coins
		if @user.stop_following(@network)
			if @network.coins.any?
				@network.coins.each do |coin| 
					@user.stop_following(coin)
				end
			end
			@success = true
		end
		respond_to do |format|
		    format.html
		    format.js { flash.now[:alert] = "You will no longer receive updates about this network via email" }
		    format.json
		end
	end

	private

	    def network_params
	    	params.require(:network).permit(:name, :description, :category_id, :link, :slack, :team, :status, :forum, :reddit, :coin_id, :logo, :founders, :github, :differentiator, :coin, :team_location, :blockchain, :crop_x, :crop_y, :crop_w, :crop_h, whitepapers_attributes: [:id, :network_id, :whitepaper_title, :whitepaper, :slug], link_ids: [], founders: [], category_ids: [], coin_ids: [], coins: [])
	    end

end
