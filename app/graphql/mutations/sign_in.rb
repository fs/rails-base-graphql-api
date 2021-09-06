module Mutations
  class SignIn < BaseMutation
    argument :input, Types::SignInInput, required: true

    type Types::AuthenticationType

    def resolve(input:)
      signin_user = SigninUser.call(input.to_h)

      if signin_user.success?
        signin_user
      else
        execution_error(error_data: signin_user.error_data)
      end
    end
  end
end
