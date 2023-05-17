module Mutations
  class ConfirmUser < BaseMutation
    description "Confirm user mutation"

    argument :input, Types::ConfirmUserInput, "Data Input", required: true

    type Types::Payloads::ConfirmUserPayload

    def resolve(input:)
      result = ::ConfirmUser.call(value: input.value)

      result.success? ? result : execution_error(error_data: result.error_data)
    end
  end
end
