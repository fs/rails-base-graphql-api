module Mutations
  class RequestPasswordRecovery < BaseMutation
    include SkipAuthentication

    description "Request reset password flow mutation"

    argument :input, Types::RequestPasswordRecoveryInput, "Data Input", required: true

    type Types::Payloads::RequestPasswordRecoveryPayload

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
