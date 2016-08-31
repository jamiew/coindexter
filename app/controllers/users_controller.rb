class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
    else
      render 'new'
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
        if get_all_logs(@user.id).empty?
          redirect_to root_url
        else
          redirect_to @user
        end
    else
        render 'edit'
    end
  end

  def index
    get_all_logs
  end

  def finish
    @user = User.find(params[:id])
    if @user.username.nil? || @user.username.blank?
      @user = User.find(params[:id])
    else  
      redirect_to root_url
    end
  end

  def show
    @user = User.friendly.find(params[:id])
    get_all_logs(@user.id)
      respond_to do |format|
        format.html
        format.js
        format.json
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :avatar, :email, :password, :password_confirmation, :username)
    end

    def get_all_logs(user_id=nil)
    
      links = []
      logs = []
      
      puts "user id is #{user_id}"

      if user_id.nil?
        link_query = Link.all.limit(20)
      else
        link_query = User.find(user_id).links
      end
      
      link_query.each do |link| 
        log = LogService.new
        log.data = link
        log.set_metadata(user: link.user, created_at: link.created_at, feed_type: "link")
        add_networks_and_coins(log, link.networks, link.coins)
        links << log
      end

      Network.all.each do |network| 
        network_logs = NetworkService.new
        if user_id.nil?  
          net_logs = network_logs.get_logs(network, "network_log", 5)
        else
          net_logs = network_logs.get_logs(network, user_id, "network_log", 5)
        end
        net_logs.each do |log|
          logs << log
        end
      end

      Coin.all.each do |coin| 
        coin_logs = NetworkService.new
        if user_id.nil? 
          c_logs = coin_logs.get_logs(coin, "coin_log", 5)
        else
          c_logs = coin_logs.get_logs(coin, user_id, "coin_log", 5)
        end
        c_logs.each do |log|
          logs << log
        end
      end

      logs += links
      @logs = logs.sort_by{|log| log.created_at}.reverse
    end
    

    def add_networks_and_coins(log, networks, coins)
      if networks.any?
        log.networks = networks
        if coins.any?  
          network_names = [] 
          networks.each do |network|
            network_names << network.name
          end
          coins.each do |coin|
            if network_names.index coin.name
              coin_to_delete = coin
              log.coins = coins.reject {|coin| coin = coin_to_delete}
            end
          end
        end
      end
      return log
    end

end




