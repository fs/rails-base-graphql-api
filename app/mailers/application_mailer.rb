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

  def confirm_user(possession_token)
    @user = possession_token.user
    @confirmation_link = format(
      ENV.fetch("CONFIRM_USER_LINK_TEMPLATE"),
      token_value: possession_token.value
    )

    mail(to: @user.email)
  end
end
