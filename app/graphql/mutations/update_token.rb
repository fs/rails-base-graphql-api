module Mutations
  class UpdateToken < BaseMutation
    include SkipAuthentication

    description "Update short live access token mutation"

    type Types::Payloads::UpdateTokenPayload

    def resolve
      update_token = UpdateTokenPair.call(token: token)

      update_token.success? ? update_token : execution_error(error_data: update_token.error_data)
    end
  end
end
