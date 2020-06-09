class RequestPasswordReset
  class GenerateResetToken
    include Interactor
    include TransactionalInteractor

    delegate :email, to: :context

    def call
      user.regenerate_password_reset_token
      user.password_reset_sent_at = Time.current
      user.save!
    end

    private

    def user
      context.user ||= User.find_by(email: email) || context.fail!(error_data: error_data)
    end

    def error_data
      {
        message: I18n.t("password_recovery.not_found.message"),
        detail: I18n.t("password_recovery.not_found.detail", email: email)
      }
    end
  end
end
