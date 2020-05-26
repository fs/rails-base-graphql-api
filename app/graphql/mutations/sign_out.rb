module Mutations
  class SignOut < BaseMutation
    type Types::UserType

    def resolve
      user = DeleteRefreshToken.call(client_uid: client_uid)

      if user.success?
        current_user
      else
        execution_error(error_data: user.error_data)
      end
    end

    private

    def client_uid
      context[:client_uid]
    end

    def current_user
      context[:current_user]
    end
  end
end
