class RequestPasswordReset
  class SendRecoveryInstructions
    include Interactor

    delegate :user, to: :context

    def call
      ApplicationMailer.password_recovery(user).deliver_later
    end
  end
end
