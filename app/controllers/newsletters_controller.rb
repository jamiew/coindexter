class NewslettersController < ApplicationController

  def new
    
  end

  def mailing_list_form

  end

  def show
    cookies['coindexter-newsletter'] = {
        :value => true,
        :expires => 10.year.from_now
    }
  end

  def create 	
    begin
    	response = RestClient::Request.execute(
       		url: "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v3/lists/updates@coindexter.io/members",
       		method: :post,
       		:payload => {
        		:address => params[:email]
        	}
       )
    rescue => e
      puts e
    end
   	unless response.nil?
      cookies['coindexter-newsletter'] = {
        :value => true,
        :expires => 10.year.from_now
      }
      redirect_to root_url
   	end
  end

  def restore_cookie
    cookies['coindexter-newsletter'] = {
        :value => false,
        :expires => 10.year.from_now
    }
    redirect_to root_url
  end

  def prevent_display
    cookies['coindexter-newsletter'] = {
        :value => true,
        :expires => 10.year.from_now
    }
  end

end