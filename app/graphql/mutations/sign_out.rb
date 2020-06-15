module Mutations
  class SignOut < BaseMutation
    include AuthenticableGraphqlUser

    argument :everywhere, Boolean, required: false

    type Types::MessageType
    def resolve(everywhere: false)
      SignoutUser.call(token: token, user: current_user, everywhere: everywhere)

      {
        message: "User signed out successfully"
      }
    end
  end
end
