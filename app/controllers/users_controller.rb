class UsersController < ApplicationController

	def login
		if session[:userinfo]["info"]["name"].nil
			redirect_to '/signinalt'
		else
			redirect_to '/coins'
		end
	end

	def show 
		
	end

end
