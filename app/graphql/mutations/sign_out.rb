module Mutations
  class SignOut < BaseMutation
    description "Sign out mutation"

    argument :input, Types::SignOutInput, "Data Input", required: true

    type Types::Payloads::SignOutPayload

    def resolve(input:)
      SignoutUser.call(token: token, user: current_user, everywhere: input.everywhere)

      {
        message: "User signed out successfully"
      }
    end
  end
end
