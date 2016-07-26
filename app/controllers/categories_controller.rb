class CategoriesController < ApplicationController

	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
	end

	def new
		@category = Category.new
	end

	def edit
		@category = Category.find(params[:id])
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
		@category = Category.find(params[:id])
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
