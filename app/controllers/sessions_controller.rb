class SessionsController < ApplicationController
  def new; end

  def create
    credentials = params["/login"]
    user = User.find_by(email: credentials[:email])

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
    @mail_user = User.find_by(email: params[:email])
    UserMailer.with(user: @user).reset_email.deliver_now
  end


end
