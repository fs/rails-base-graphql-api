class ApplicationMailer < ActionMailer::Base
  default from: "noreply@example.com"
  layout "mailer"

  def password_recovery(user)
    @user = user

    mail(to: user.email)
  end
end
