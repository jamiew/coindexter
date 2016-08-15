class NetworksController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		@networks = Network.all
		@categories = []
		Network.all.each do |net|
			@categories << net.category
		end
		@categories = @categories.uniq
		page_title = "networks"
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def links
		@links = Network.friendly.find(params[:id]).links
		@network = Network.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def trollbox

	end

	def log

	end		

	def show
		@network = Network.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def new
		@use_ajax = false
		@network = Network.new
	end

	def edit
		@use_ajax = true
		@network = Network.friendly.find(params[:id])
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
		@network.status = params[:status]
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
	    	params.require(:network).permit(:name, :description, :category_id, :link, :slack, :team, :status, :forum, :coin_id, :logo, :founders, :coin, :whitepaper_title, :whitepaper_url, link_ids: [], founders: [], category_ids: [], coin_ids: [], coins: [])
	    end

end
