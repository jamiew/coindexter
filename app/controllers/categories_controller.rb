class CategoriesController < ApplicationController

	def index
		@categories = Category.all.order('name')
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end	
	end

	def show
		@categories = Category.all.order('name')
		@category = Category.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end	
	end

	def new
		@category = Category.new
	end

	def edit
		@category = Category.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@category = Category.new(params[:category])
	    if @Category.save
	      redirect_to @category
		else
	      
	    end
	end

	def update
		@category = Category.friendly.find(params[:id])
	  	if @Category.update_attributes(coin_params)
	    	redirect_to @category
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@Category.destroy
	end
end
