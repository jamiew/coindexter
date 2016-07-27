class Auth0Controller < ApplicationController
  def callback
  	redirect_to '/'
  end

  def failure
  end
end
