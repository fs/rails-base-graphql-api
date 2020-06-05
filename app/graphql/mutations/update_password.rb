module Mutations
  class UpdatePassword < BaseMutation
    argument :password, String, required: true
    argument :reset_token, String, required: true

    type Types::AuthenticationType

    def resolve(password:, reset_token:)
      user = UpdateUserPassword.call(password: password, reset_token: reset_token)

      if user.success?
        user
      else
        execution_error(error_data: user.error_data)
      end
    end
  end
end
