require "google/api_client/client_secrets"

module Omniauth
  module Google
    class BuildAuthClient
      include Interactor

      delegate :auth_code, to: :context

      def call
        context.auth_client = auth_client
        update_auth_client!
      end

      private

      def auth_client
        @auth_client ||= client_secrets.to_authorization
      end

      def update_auth_client!
        auth_client.update!(
          client_id: ENV.fetch("GOOGLE_CLIENT_ID"),
          client_secret: ENV.fetch("GOOGLE_CLIENT_SECRET"),
          redirect_uri: "postmessage",
          code: auth_code
        )
      end

      def client_secrets
        ::Google::APIClient::ClientSecrets.load
      end
    end
  end
end
