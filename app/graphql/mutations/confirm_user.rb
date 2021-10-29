module Mutations
  class ConfirmUser < BaseMutation
    argument :input, Types::ConfirmUserInput, required: true

    type Types::Payloads::ConfirmUserPayload

    def resolve(input:)
      result = ::ConfirmUser.call(value: input.value)

      result.success? ? result : execution_error(error_data: result.error_data)
    end
  end
end
