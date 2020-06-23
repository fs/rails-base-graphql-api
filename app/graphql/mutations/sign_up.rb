module Mutations
  class SignUp < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    argument :first_name, String, required: false
    argument :last_name, String, required: false

    argument :avatar, Types::ImageUploaderType, required: false

    type Types::AuthenticationType

    def resolve(**user_params)
      user_params[:avatar] = user_params.delete(:avatar).to_hash
      signup_user = SignupUser.call(user_params: user_params)

      if signup_user.success?
        signup_user
      else
        execution_error(error_data: signup_user.error_data)
      end
    end
  end
end
