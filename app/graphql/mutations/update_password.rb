module Mutations
  class UpdatePassword < BaseMutation
    argument :input, Types::UpdatePasswordInput, required: true

    type Types::Payloads::UpdatePasswordPayload

    def resolve(input:)
      result = ::UpdatePassword.call(input.to_h)

      result.success? ? result : execution_error(error_data: result.error_data)
    end
  end
end
