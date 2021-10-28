module Mutations
  class RequestPasswordRecovery < BaseMutation
    argument :input, Types::RequestPasswordRecoveryInput, required: true

    type Types::DetailedMessageType

    def resolve(input:)
      result = RequestPasswordReset.call(input.to_h)

      result.success? ? success_response : result.error_data
    end

    private

    def success_response
      {
        message: I18n.t("password_recovery.sent.message"),
        detail: I18n.t("password_recovery.sent.detail")
      }
    end
  end
end
