class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]

  def new
  end

  def create
    # @mail_user = User.find_by(email: params[:email])
    # UserMailer.with(user: @mail_user).reset_email.deliver_now
    @user = User.find_by(email: params[:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to login_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?                  # Case (3)
      @user.errors.add(:password, "can't be empty")
      render 'edit'

    elsif @user.update_attributes(user_params)          # Case (4)

      flash[:success] = "Password has been reset. Please log in."
      redirect_to login_path
    else
      render 'edit'                                     # Case (2)
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirms a valid user.
    def valid_user
      unless @user
        redirect_to root_url
      end
    end

    def create_reset_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.reset_digest(activation_token)
    end

end
