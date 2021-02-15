module Mutations
  class SignIn < BaseMutation
    argument :input, Types::SignInInput, required: true

    type Types::AuthenticationType

    def resolve(input:)
      singin_user = SigninUser.call(input.to_hash)

      if singin_user.success?
        singin_user
      else
        execution_error(error_data: singin_user.error_data)
      end
    end
  end
end
