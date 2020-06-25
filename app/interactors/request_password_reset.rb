class RequestPasswordReset
  include Interactor
  include TransactionalInteractor

  delegate :email, to: :context

  def call
    user ? generate_password_reset_token : raise_error
  end

  after do
    ApplicationMailer.password_recovery(user).deliver_later
    RegisterActivityJob.perform_later(user.id, :reset_password_request)
  end

  private

  def user
    @user ||= User.find_by(email: email)
  end

  def generate_password_reset_token
    user.regenerate_password_reset_token
    user.password_reset_sent_at = Time.current
    user.save!
  end

  def raise_error
    context.fail!(error_data: error_data)
  end

  def error_data
    {
      message: I18n.t("password_recovery.not_found.message"),
      detail: I18n.t("password_recovery.not_found.detail", email: email)
    }
  end
end
