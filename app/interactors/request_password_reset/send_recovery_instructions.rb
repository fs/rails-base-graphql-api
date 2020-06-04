class RequestPasswordReset
  class SendRecoveryInstructions
    include Interactor

    delegate :user, to: :context

    def call
      ApplicationMailer.password_recovery(user).deliver_later

      context.message = I18n.t(".sent.message")
      context.detail = I18n.t(".sent.detail")
    end
  end
end
