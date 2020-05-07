module Mutations
  class SignUp < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    argument :first_name, String, required: false
    argument :last_name, String, required: false

    type Types::AuthenticationType

    def resolve(**user_params)
      signup_user = SignupUser.call(user: User.new, user_params: user_params)

      if signup_user.success?
        signup_user
      else
        execution_error(error_data: signup_user.error_data)
      end
    end
  end
end
