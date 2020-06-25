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
        register_failed_login(email)

        execution_error(error_data: singin_user.error_data)
      end
    end

    def register_failed_login(email)
      result = FindUser.call(email: email)

      RegisterActivityJob.perform_later(result.user.id, :user_login_attempt_failed) if result.success?
    end
  end
end
