class UserMailer < ApplicationMailer
  default from: 'picloud.notifications@gmail.com'

  def reset_email
    mail(to: params[:user][:email], subject: 'Password Reset')

  end

end
