module Mutations
  class UpdateToken < BaseMutation
    include SkipAuthentication

    description "Update short live access token mutation"

    type Types::Payloads::UpdateTokenPayload

    MAX_RETRIES_COUNT = 5

    def resolve
      @retries ||= MAX_RETRIES_COUNT
      UpdateTokenPair.call!(token: token)
    rescue ActiveRecord::RecordNotUnique, Interactor::Failure => _e
      prevent_constant_token_refresh
      (@retries -= 1).negative? ? raise_unauthorized_error! : retry
    end

    private

    def prevent_constant_token_refresh
      sleep(rand.seconds)
    end

    def raise_unauthorized_error!
      raise execution_error(error_data: authentication_error)
    end

    def authentication_error
      { message: "Invalid credentials", status: 401, code: :unauthorized }
    end
  end
end
