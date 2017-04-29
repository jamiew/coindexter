class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(user_params)
    puts "got here"
    if @user.save
      UserMailer.confirmation_instructions(@user, @user.confirmation_token).deliver_now
      flash[:success] = "Please check your email to confirm your email address"
    else
      render 'new'
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
        if get_all_logs(@user.id,nil).empty?
          redirect_to root_url
        else
          redirect_to @user
        end
    else
        render 'edit'
    end
  end

  def index
    @logs = get_all_logs.paginate(:page => params[:page], :per_page => 10)  
    respond_to do |format|
      format.html
      format.js
    end
  end

  def daily_digest
    network_changes_in_past_day = []
    Network.all.each do |network| 
      versions = network.versions.where("created_at > ?", 1.day.ago)
      unless versions.empty?
        network_changes_in_past_day << [network, versions]
      end
    end
    coin_changes_in_past_day = []
    Coin.all.each do |coin| 
      versions = coin.versions.where("created_at > ?", 1.day.ago)
      unless versions.empty? 
        coin_changes_in_past_day << [coin, coin.versions.where("created_at > ?", 1.day.ago)]
      end
    end
    
=begin
    User.all.each do |user|
      @user = user
      @email_content = []
      networks_following = []
      coins_following = []
      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following << Network.find(follow.followable_id)
        else 
          coins_following << Coin.find(follow.followable_id)
        end
      end
      @networks_following_changes = network_changes_in_past_day.select do |network|
        networks_following.index network.first 
      end
      @coins_following_changes = coin_changes_in_past_day.select do |coin|
        coins_following.index coin.first 
      end
      puts "@networks_following_changes is #{@networks_following_changes}"
      # DigestMailer.daily_digest(@user, @networks_following_changes).deliver_now
    end


    @user = User.friendly.find("libovness")
    @email_content = []
    networks_following = []
    coins_following = []
    @user.all_follows.each do |follow|
      if follow.followable_type == "Network"
        networks_following << Network.find(follow.followable_id)
      else 
        coins_following << Coin.find(follow.followable_id)
      end
    end
    @networks_following_changes = network_changes_in_past_day.select do |network|
      networks_following.index network.first 
    end
    @coins_following_changes = coin_changes_in_past_day.select do |coin|
      coins_following.index coin.first 
    end
    puts "@networks_following_changes is #{@networks_following_changes}"
    # DigestMailer.daily_digest(@user, @networks_following_changes).deliver_now
=end 

    @user = User.friendly.find("libovness")
    @email_content = []
    networks_following = []
    coins_following = []
    @user.all_follows.each do |follow|
      if follow.followable_type == "Network"
        networks_following << Network.find(follow.followable_id)
      else 
        coins_following << Coin.find(follow.followable_id)
      end
    end

    @all_following_logs = []

    networks_following.each do |network|
      network_logs = NetworkService.new
      @all_following_logs << network_logs.get_logs(network, "Network",nil,nil,1).reverse
    end

    puts "@logs are #{@logs}"

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
    @user = User.friendly.find(params[:username])
    @logs = get_all_logs(@user.id).paginate(:page => params[:page], :per_page => 10)
    all_follows = @user.all_follows
    @networks_following = []
    @coins_following = []
    all_follows.each do |follow|
      if follow.followable_type == "Network"
        @networks_following << Network.find(follow.followable_id)
      else 
        @coins_following << Coin.find(follow.followable_id)
      end
    end
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def activity
    @user = User.friendly.find(params[:username])
    @logs = get_all_logs(@user.id).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :avatar, :email, :password, :password_confirmation, :username)
    end

    def get_all_logs(user_id=nil, since=nil)
    
      links = []
      logs = []
      
      if user_id.nil?
        if since.nil?
          link_query = Link.all.limit(20)
        else
          link_query = Link.all.limit(20).where("created_at > ?", since.day.ago)
        end
      else
        if since.nil?
          link_query = User.find(user_id).links
        else
          link_query = User.find(user_id).links.where("created_at > ?", since.day.ago)
        end
      end
      
      link_query.each do |link| 
        log = LogService.new
        log.data = link
        log.set_metadata(user: link.user, created_at: link.created_at, feed_type: "link")
        puts "log is #{log.inspect}"
        add_networks_and_coins(log, link.networks, link.coins)
        links << log
      end

      network_logs = NetworkService.new
      net_logs = network_logs.get_all_the_logs
      net_logs.each do |log|
        logs << log
      end
      logs += links
      temp_logs = logs.sort_by{|log| log.created_at}.reverse
      temp_logs.each do |tl|
        puts tl.inspect
      end
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




