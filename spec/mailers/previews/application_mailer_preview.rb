class ApplicationMailerPreview < ActionMailer::Preview
  def password_recovery
    ApplicationMailer.password_recovery(
      FactoryBot.build(:user, password_reset_token: "1234")
    )
  end
end
