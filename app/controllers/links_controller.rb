class LinksController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		@links = Link.all
	end

	def show
		@link = Link.friendly.find(params[:id])
	end


	def new
		@use_ajax = true
		@link = current_user.links.new
	end

	def edit
		@use_ajax = true
		@link = Link.friendly.find(params[:id])
		#set_has_application(@coin)
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

	private

	    def link_params
	    	params.require(:link).permit(:link, :title, :coin_id => [], :coin_ids => [])
	    end	

end
