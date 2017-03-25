class NetworksController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		@networks = Network.all
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
        network_logs = NetworkService.new
        @network = Network.friendly.find(params[:id]) 
        logs = network_logs.get_logs(@network, "Network").reverse
        @logs = logs.paginate(:page => params[:page], :per_page => 10)
        puts "the logs are #{logs}"
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
	    if @network.save
			redirect_to @network
		else
	        render 'new'
	    end
	end

	def update
		@network = Network.friendly.find(params[:id])
		@network.founders = params[:founders] 
	  	if @network.update_attributes(network_params)
	    	redirect_to @network
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@network.destroy
	end

	private

	    def network_params
	    	params.require(:network).permit(:name, :description, :category_id, :link, :slack, :team, :status, :forum, :coin_id, :logo, :founders, :coin, whitepapers_attributes: [:id, :network_id, :whitepaper_title, :whitepaper, :slug], link_ids: [], founders: [], category_ids: [], coin_ids: [], coins: [])
	    end

end
