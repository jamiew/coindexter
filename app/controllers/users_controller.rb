class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
        redirect_to @user
    else
        render 'edit'
    end
  end

  def index
    get_all_logs
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

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :avatar, :email, :password, :password_confirmation, :username)
    end

    def get_all_logs(*user_id)
      links = []
      logs = []
      
      unless user_id.nil?
        link_query = Link.all.limit(20)
      else
        link_query = User.find(user_id).links
      end
      
      link_query.each do |link| 
        log = LogService.new
        log.data = link
        log.created_at = link.created_at
        log.feed_type = "link"
        add_networks_and_coins(log, link.networks, link.coins)
        links << log
      end

      Network.all.each do|network| 
        unless user_id.nil?
          versions = network.versions.all.order("created_at DESC").limit(5)
        else
          versions = network.versions.where(:whodunnit => user_id).all.order("created_at DESC").limit(5)
        end
        versions.each do |version|
          unless version.changeset == {}
            log = build_log(nil, "network_log",version.created_at)
            log.networks = network
            log = convert_changeset(log, version)
            unless !log 
              logs << log
            end
          end
        end
      end

      Coin.all.each do |coin| 
        unless user_id.nil?
          versions = coin.versions.all.order("created_at DESC").limit(5)
        else 
          versions = coin.versions.where(:whodunnit => user_id).all.order("created_at DESC").limit(5)
        end
        versions.each do |version| 
          unless version.changeset == {}
            log = build_log(nil, "coin_log",version.created_at)
            log.coins = coin
            log = convert_changeset(log, version)
            unless !log 
              logs << log
            end
          end
        end
      end 

      logs += links
      @logs = logs.sort_by{|log| log.created_at}.reverse
    
    end

    def build_log(user, feed_type, created_at)
      log = LogService.new
      unless user.nil?
        log.user = user
      end
      log.feed_type = feed_type
      log.created_at = created_at
      return log
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

    def convert_changeset(log, version)
      if defined?(version.user) && !version.user.nil?
        log.user = version.user
      end
      version.changeset.each do |key, value|
        unless key == "updated_at"
          type = nil
          case key
          when "repositories", "exchanges"
            if value.first == {} || value.first == [] || value.first.nil? || value.first == [""]
              type = "added"  
              unless value.first == [""] && value.second.second.nil?
                abort_log = true
              end 
            else 
              type = "edited"
            end
            key = "repositories" ? change_attr = "Repositories" : change_attr = "Exchanges"
          when "network_id"
            if value.first.nil? 
              type = "added"
            else
              type = "edited"
              value[0] = Network.find(value[0])
            end
            value[1] = Network.find(value[1])
            change_attr = "Network"
          when "type"
            change_attr = "Asset type"
          when "coin_status"
            change_attr = "Status"
          when "code_license"
            change_attr = "Code license"
          when "proof algorithm"
            change_attr = "Proof algorithm"
          when "coin_info"
            change_attr = "Additional info"                
          when "whitepapers", "founders"
            if value.first == {} || value.first == [] || value.first == [""]
              type = "added"
              unless value.first == [""] && value.second.second.nil?
                abort_log = true
              end  
            else 
              type = "edited"
            end
          when "description"
            change_attr = "Description"
          when "link"
            change_attr = "Link"
          when "status"
            change_attr = "Status"
          else
            change_attr = key
          end
          if type.nil?
            if value.first == "" || value.nil?
              type = "added"
            else
              type = "edited"
            end
          end
          if change_attr.nil?
            change_attr = key
          end
          if abort_log
            return false
          else
            log.set_data(change: value, change_attr: change_attr, change_type: type)
            return log
          end
        end
      end
    end

end




