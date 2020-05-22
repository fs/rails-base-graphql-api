module Mutations
  class UpdateToken < BaseMutation
    type Types::AuthenticationType

    def resolve
      update_token = UpdateTokenPair.call(user: user, token: refresh_token)

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

    def refresh_token
      context[:refresh_token]
    end
  end
end
