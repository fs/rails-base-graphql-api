module Omniauth
  module Google
    class ExchangeAuthCode
      include Interactor

      delegate :auth_client, to: :context

      def call
        auth_client.fetch_access_token!
      rescue Signet::AuthorizationError
        context.fail!(error_data: error_data)
      end

      private

      def error_data
        { status: 401, code: :unauthorized, message: "Invalid credentials" }
      end
    end
  end
end
