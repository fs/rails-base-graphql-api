module Mutations
  class UpdatePassword < BaseMutation
    argument :input, Types::UpdatePasswordInput, required: true

    type Types::AuthenticationType

    def resolve(input:)
      result = ::UpdatePassword.call(input.to_hash)

      if result.success?
        result
      else
        execution_error(error_data: result.error_data)
      end
    end
  end
end
