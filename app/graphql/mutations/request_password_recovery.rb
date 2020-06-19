module Mutations
  class RequestPasswordRecovery < BaseMutation
    argument :email, String, required: true

    type Types::DetailedMessageType

    def resolve(email:)
      RequestPasswordReset.call(email: email)

      {
        message: I18n.t("password_recovery.sent.message"),
        detail: I18n.t("password_recovery.sent.detail")
      }
    end
  end
end
