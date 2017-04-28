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
    @logs = get_all_logs.paginate(:page => params[:page], :per_page => 10)  
    respond_to do |format|
      format.html
      format.js
    end
  end

  def daily_digest
    network_changes_in_past_day = []
    @networks.each do |network| 
      network_changes_in_past_day << versions.where("created_at > ?",  1.day.ago)
    end
    coin_changes_in_past_day = []
    @coins.each do |coin| 
      coin_changes_in_past_day << versions.where("created_at > ?",  1.day.ago)
    end
    @user.all.each do |user|
      @user = user
      @email_content = []
      networks_following = []
      coins_following = []
      user.all_follows.each do |follow|
        if follow.followable_type == "Network"
          networks_following_changes << Network.find(follow.followable_id)
        else 
          coins_following_changes << Coin.find(follow.followable_id)
        end
      end


    end
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

    def get_all_logs(user_id=nil)
    
      links = []
      logs = []
      
      if user_id.nil?
        link_query = Link.all.limit(20)
      else
        link_query = User.find(user_id).links
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




