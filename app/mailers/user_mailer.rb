class UserMailer < ApplicationMailer
  default from: 'alicelin723@gmail.com'

  def reset_email
    mail(to: params[:email], subject: 'Password Reset')
    # byebug
  end

end
