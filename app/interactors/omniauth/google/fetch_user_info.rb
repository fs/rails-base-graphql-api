require "google/apis/oauth2_v2"

module Omniauth
  module Google
    class FetchUserInfo
      include Interactor

      delegate :auth_client, to: :context

      def call
        context.user_info = user_info
      end

      private

      def user_info
        oauth_service.get_userinfo(options: { authorization: auth_client })
      end

      def oauth_service
        ::Google::Apis::Oauth2V2::Oauth2Service.new
      end
    end
  end
end
