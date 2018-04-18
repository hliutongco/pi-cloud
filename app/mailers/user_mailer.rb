class UserMailer < ApplicationMailer
  default from: 'picloud.notifications@gmail.com'

  def password_reset(user)
    user.reset_token = User.new_token
    reset_email(user)
  end

  def reset_email(user)
    @user = user  
    mail(to: user.email, subject: 'Password Reset')

  end

end
