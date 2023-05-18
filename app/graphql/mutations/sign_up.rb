module Mutations
  class SignUp < BaseMutation
    include SkipAuthentication

    description "Sign up mutation"

    argument :input, Types::SignUpInput, "Data Input", required: true

    type Types::Payloads::SignUpPayload

    def resolve(input:)
      signup_user = SignupUser.call(user_params: input.to_h)

      signup_user.success? ? signup_user : execution_error(error_data: signup_user.error_data)
    end
  end
end
