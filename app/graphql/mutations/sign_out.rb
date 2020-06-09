module Mutations
  class SignOut < BaseMutation
    argument :everywhere, Boolean, required: false

    type Types::UserType

    def resolve(everywhere: nil)
      delete_token = SignoutUser.call(token: token, user: current_user, everywhere: everywhere)

      if delete_token.success?
        current_user
      else
        execution_error(error_data: delete_token.error_data)
      end
    end
  end
end
