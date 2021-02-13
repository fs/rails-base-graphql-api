module Mutations
  class SignUp < BaseMutation
    argument :input, Types::SignUpAttributes, required: true

    type Types::AuthenticationType

    def resolve(**user_params)
      signup_user = SignupUser.call(user_params: user_params)

      if signup_user.success?
        signup_user
      else
        execution_error(error_data: signup_user.error_data)
      end
    end
  end
end
