class ApplicationController < ActionController::Base
  # before_filter :authorize
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end

  def authorize
     redirect_to login_path unless logged_in?
  end

end
