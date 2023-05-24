module Omniauth
  module Google
    class ExchangeAuthCode
      include Interactor
      include AuthenticableInteractor

      delegate :auth_client, to: :context

      def call
        auth_client.fetch_access_token!
      rescue Signet::AuthorizationError
        raise_unauthorized_error!
      end
    end
  end
end
