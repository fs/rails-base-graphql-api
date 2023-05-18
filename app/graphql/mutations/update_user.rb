module Mutations
  class UpdateUser < BaseMutation
    description "Update user info mutation"

    argument :input, Types::UpdateUserInput, "Data Input", required: true

    type Types::Payloads::UpdateUserPayload

    def resolve(input:)
      update_user = ::UpdateUser.call(
        user: current_user, user_params: input.to_h
      )

      update_user.success? ? update_user : execution_error(error_data: update_user.error_data)
    end
  end
end
