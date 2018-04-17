class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # can login
      session[:user_id] = user.id
      redirect_to user
    else
      #incorrect credentials
      flash[:errors] = "Invalid credentials"
      redirect_to login_path
    end
  end

end
