class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :img, :password, :bio)
  end
end
