class LinksController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		if params.has_key?(:network_id)
			@network = Network.friendly.find(params[:network_id])
			@links = @network.links.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
		else
			@links = Link.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
		end
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def show
		@link = Link.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def new
		@use_ajax = true
		if params.has_key?(:network_id)
			@network = Network.friendly.find(params[:network_id])
			@link = @network.links.new
		else
			@link = Link.new
		end
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def edit
		@use_ajax = true
		@link = Link.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@link = current_user.links.new(link_params)
		if @link.save
	    	redirect_to @link
		else
	        puts 'not working'
	    end
	end

	def update
		@link = Link.friendly.find(params[:id])
	  	if @link.update_attributes(link_params)
	    	redirect_to @link
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@link.destroy
	end

	def comment_count(link)
		link.comments.count
	end

	private

	    def link_params
	    	params.require(:link).permit(:link, :title, :body, coin_ids: [], network_ids: [])
	    end	

end
