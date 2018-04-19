class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def feed
    @user = User.featured
    @song = Song.featured
    @songs = Song.popular
    @users = User.popular
  end

  def show
    @user = User.find(params[:id])
    @playlists = @user.playlists
    @songs = @user.songs
  end

  def following
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
		  redirect_to edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :password, :bio)
  end
end
