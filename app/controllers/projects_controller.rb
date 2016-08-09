class ProjectsController < ApplicationController

	before_action :authenticate_user!, only: [:edit,:new,:create,:update]

	def index
		@projects = Project.all
		page_title = "projects"
	end

	def show
		@project = Project.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def new
		@use_ajax = false
		@project = Project.new
	end

	def edit
		@use_ajax = true
		@project = Project.friendly.find(params[:id])
		respond_to do |format|
		    format.html
		    format.js
		    format.json
		end
	end

	def create
		@project = Project.new(project_params)
		@project.user = current_user
	    if @project.save
			redirect_to @project
		else
	        render 'new'
	    end
	end

	def update
		@project = Project.friendly.find(params[:id])
		@project.founders = params[:founders]
		@project.status = params[:status]
	  	if @project.update_attributes(project_params)
	    	redirect_to @project
		else
	    	render 'edit'
	  	end
	end

	def destroy
		@project.destroy
	end

	private

	    def project_params
	    	params.require(:project).permit(:name, :description, :category_id, :link, :slack, :team, :status, :forum, :coin_id, :logo, :founders, :coin, :whitepaper_title, :whitepaper_url, :founders => [], :category_ids => [], :coin_ids => [], :coins => [])
	    end

end
