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
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    user_id = @user.id
    network_versions = []
    coin_versions = []
    links = []
    User.friendly.find(params[:id]).links.each do |link| 
      log = {}
      log[:data] = link
      log[:feed_type] = "link"
      log[:created_at] = link.created_at
      if link.coins.any?  
        log[:coins] = link.coins
      end
      if link.networks.any?
        log[:networks] = link.networks
      end
      links << log
    end
    Network.all.each do |network|
      network.versions.where(:whodunnit => user_id).each do |version|
        unless version.changeset == {}
          log = {}
          version.changeset.each do |key, value|
            case key
            when "whitepapers"
              if value.first == {} || value.first == []
                type = "added"  
              else 
                type = "edited"
              end
              log[:data] = {change: value, change_attr: key, change_type: type}
            when "founders"
              if value.first == {} || value.first == []
                type = "added"  
              else 
                type = "edited"
              end
              log[:data] = {change: value, change_attr: key, change_type: type}
            when "description"
              change_attr = "Description"
            when "link"
              change_attr = "Link"
            when "status"
              change_attr = "Status"
            else
              change_attr = key
            end
            if log == {}
              if value.first == ""
                type = "added"
              else
                type = "edited"
              end
              log[:data] = {change: value, change_attr: change_attr, change_type: type}
            end
            log[:created_at] = version.created_at
            log[:feed_type] = "network_log"
            log[:networks] = network
            network_versions << log
          end
        end
      end
    end
    Coin.all.each do |coin|
      coin.versions.where(:whodunnit => user_id).each do |version|
        unless version.changeset == {}
          log = {}
          version.changeset.each do |key, value|
            case key
            when "repositories", "exchanges"
              if value.first == {} || value.first == [] || value.first.nil?
                type = "added"  
              else 
                type = "edited"
              end
              log[:data] = {change: value, change_attr: key, change_type: type}
            when "network_id"
              if value.first.nil? 
                type = "added"
              else
                type = "edited"
                value[0] = Network.find(value[0])
              end
              value[1] = Network.find(value[1])
              change_attr = "Network"
              log[:data] = {change: value, change_attr: change_attr, change_type: type}
            when "coin_info"
              change_attr = "Additional info"
            when "type"
              change_attr = "Asset type"
            when "coin_status"
              change_attr = "Status"
            when "code_license"
              change_attr = "Code license"
            when "proof algorithm"
              change_attr = "Proof algorithm"
            else
              change_attr = key
            end
            if log == {}
              if value.first == ""
                type = "added"
              else
                type = "edited"
              end
              log[:data] = {change: value, change_attr: change_attr, change_type: type}
            end
            log[:created_at] = version.created_at
            log[:feed_type] = "coin_log"
            log[:coins] = coin
            coin_versions << log
          end
        end
      end
    end   
    logs = network_versions + coin_versions + links
    @logs = logs.sort_by{|log| log[:created_at]}.reverse
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

end
