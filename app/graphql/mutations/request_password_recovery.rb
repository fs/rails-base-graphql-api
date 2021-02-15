module Mutations
  class RequestPasswordRecovery < BaseMutation
    argument :input, Types::RequestPasswordRecoveryInput, required: true

    type Types::DetailedMessageType

    def resolve(input:)
      RequestPasswordReset.call(input.to_hash)

      {
        message: I18n.t("password_recovery.sent.message"),
        detail: I18n.t("password_recovery.sent.detail")
      }
    end
  end
end
