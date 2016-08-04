class LinksController < ApplicationController

	def index
		@links = Link.all
	end

	def show
		@links = Link.friendly.find(params[:id])
	end


	def new
		@use_ajax = true
		@link = Link.new
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
		@link = Links.new(link_params)
		if @link.save
	    	redirect_to @link
		else
	        render 'new'
	    end
	end

	def update
		@link = Link.friendly.find(params[:id])
		#set_has_application(@coin)
	  	if @link.update_attributes(coin_params)
	    	redirect_to @link
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@link.destroy
	end

	private

	    def coin_params
	    	params.require(:link).permit(:link, :title, :coin_id)
	    end	

end
