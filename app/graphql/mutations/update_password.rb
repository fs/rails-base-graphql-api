module Mutations
  class UpdatePassword < BaseMutation
    argument :password, String, required: true
    argument :reset_token, String, required: true

    type Types::AuthenticationType

    def resolve(password:, reset_token:)
      result = ::UpdatePassword.call(password: password, reset_token: reset_token)

      if result.success?
        result
      else
        execution_error(error_data: result.error_data)
      end
    end
  end
end
