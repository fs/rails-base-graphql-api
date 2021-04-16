module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: false
    argument :password, String, required: false
    argument :google_auth_code, String, required: false

    type Types::AuthenticationType

    def resolve(**params)
      singin_user = SigninUser.call(
        email: params[:email],
        password: params[:password],
        google_auth_code: params[:google_auth_code]
      )

      if singin_user.success?
        singin_user
      else
        execution_error(error_data: singin_user.error_data)
      end
    end
  end
end
