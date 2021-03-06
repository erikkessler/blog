class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit,:update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_url, :notice =>"Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, :notice => "Profile Updated..."
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Before filters
  def signed_in_user
    store_location
    redirect_to log_in_path, :notice => "Sign in required." unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) || current_user.admin?
  end

  def admin_user
    if !current_user.admin?
      redirect_to users_path, :flash => { :error => "You must be admin to do that" }
    end
  end
end
