module Mutations
  class UpdateUser < BaseMutation
    argument :input, Types::UpdateUserInput, required: true

    type Types::UserType

    def resolve(input:)
      update_user = ::UpdateUser.call(
        user: context[:current_user], user_params: input.to_hash
      )

      if update_user.success?
        update_user.user
      else
        execution_error(error_data: update_user.error_data)
      end
    end
  end
end
