class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      session[:user_id] = user.id
      flash[:success] = 'Account activated!'
      redirect_to user
    else

      flash[:danger] = 'Invalid activation link'
      redirect_to login_path
    end
  end
end
