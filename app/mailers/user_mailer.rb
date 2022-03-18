class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Aktivace účtu"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Obnovení hesla"
  end
end
