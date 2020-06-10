module Mutations
  class SignOut < BaseMutation
    include AuthenticableGraphqlUser

    argument :everywhere, Boolean, required: false

    type Types::MessageType
    def resolve(everywhere: falsee)
      delete_token = SignoutUser.call(token: token, user: current_user, everywhere: everywhere)

      if delete_token.success?
        {
          message: "User signed out successfully"
        }
      else
        execution_error(error_data: delete_token.error_data)
      end
    end
  end
end
