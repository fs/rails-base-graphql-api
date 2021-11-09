module Mutations
  class SignIn < BaseMutation
    argument :input, Types::SignInInput, required: true

    type Types::Payloads::SignInPayload

    def resolve(input:)
      signin_user = SigninUser.call(input.to_h)

      signin_user.success? ? signin_user : execution_error(error_data: signin_user.error_data)
    end
  end
end
