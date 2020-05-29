module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::AuthenticationType

    def resolve(email:, password:)
      singin_user = SigninUser.call(email: email, password: password)

      if singin_user.success?
        singin_user
      else
        execution_error(error_data: singin_user.error_data)
      end
    end
  end
end
