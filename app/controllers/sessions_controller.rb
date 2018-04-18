class SessionsController < ApplicationController
  def new; end

  def create
    credentials = params["/login"]
    user = User.find_by(email: credentials[:email])
    byebug
    if user && user.authenticate(credentials[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:errors] = 'Invalid credentials'
      redirect_to login_path
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to login_path
  end

  def reset
    UserMailer.with(email: params[:email]).reset_email.deliver_now
  end


end
