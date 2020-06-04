class RequestPasswordReset
  class GenerateResetToken
    include Interactor

    delegate :email, to: :context

    def call
      user.regenerate_password_reset_token
      user.password_reset_sent_at = Time.current
      user.save!
    end

    def user
      context.user ||= User.find_by!(email: email)
    rescue ActiveRecord::RecordNotFound
      context.fail!(error: I18n.t("password_recovery.not_found"))
    end
  end
end
