class ApplicationMailer < ActionMailer::Base
  layout "mailer"

  def password_recovery(user)
    @user = user
    @password_recovery_link = format(
      ENV.fetch("PASSWORD_RECOVERY_LINK_TEMPLATE"),
      password_reset_token: user.password_reset_token
    )

    mail(to: user.email)
  end
end
