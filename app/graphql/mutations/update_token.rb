module Mutations
  class UpdateToken < BaseMutation
    type Types::AuthenticationType

    def resolve
      update_token = UpdateTokenPair.call(user: user, client_uid: client_uid)

      if update_token.success?
        update_token
      else
        execution_error(error_data: update_token.error_data)
      end
    end

    private

    def user
      context[:current_user]
    end

    def client_uid
      context[:client_uid]
    end
  end
end
