class UserMailer < ApplicationMailer
  default from: 'picloud.notifications@gmail.com'

  def password_reset(user)
    @user = user
    user.reset_token = User.new_token
    mail(to: user.email, subject: 'Password Reset')
  end

  def account_activation(user)
    @user = user
    mail(to: user.email, subject: 'Activate your Account')
  end

end
