module Mutations
  class UpdateUser < BaseMutation
    argument :input, Types::UpdateUserInput, required: true

    type Types::Payloads::UpdateUserPayload

    def resolve(input:)
      update_user = ::UpdateUser.call(
        user: context[:current_user], user_params: input.to_h
      )

      update_user.success? ? update_user : execution_error(error_data: update_user.error_data)
    end
  end
end
