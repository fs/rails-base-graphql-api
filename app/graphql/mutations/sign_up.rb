module Mutations
  class SignUp < BaseMutation
    argument :input, Types::SignUpInput, required: true

    type Types::AuthenticationType

    def resolve(input:)
      signup_user = SignupUser.call(user_params: input.to_h)

      if signup_user.success?
        signup_user
      else
        execution_error(error_data: signup_user.error_data)
      end
    end
  end
end
