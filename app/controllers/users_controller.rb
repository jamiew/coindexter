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
      whitepapers = []

      if user_id.nil?
        if since.nil?
          link_query = Link.all.limit(20)
          whitepaper_query = Whitepaper.all.limit(20)
        else
          link_query = Link.all.limit(20).where("created_at > ?", since.day.ago)
          whitepaper_query = Whitepaper.all.limit(20).where("created_at > ?", since.day.ago)
        end
      else
        if since.nil?
          link_query = User.find(user_id).links
          whitepaper_query = User.find(user_id).whitepapers
        else
          link_query = User.find(user_id).links.where("created_at > ?", since.day.ago)
          whitepaper_query = User.find(user_id).whitepapers.where("created_at > ?", since.day.ago)
        end
      end
      
      link_query.each do |link| 
        log = LogService.new
        log.data = link
        log.set_metadata(user: link.user, created_at: link.created_at, feed_type: "link")
        add_networks_and_coins(log, link.networks, link.coins)
        links << log
      end

      whitepaper_query.each do |whitepaper| 
        log = LogService.new
        log.data = whitepaper
        log.set_metadata(user: whitepaper.user, created_at: whitepaper.created_at, feed_type: "whitepaper")
        add_networks_and_coins(log, whitepaper.network, nil)
        whitepapers << log
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
      if log.feed_type = 'whitepaper'
        wp_networks = []
        wp_networks << log.networks
        log.networks = wp_networks
        puts "whitepaper log is #{log}"
        return log
      else
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

end




