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
    UserMailer.welcome_email(@user).deliver_later
  end

end
