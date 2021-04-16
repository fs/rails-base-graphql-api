module Omniauth
  module Google
    class FindOrCreateUser
      include Interactor

      delegate :user_info, to: :context
      delegate :email, :family_name, :given_name, to: :user_info

      def call
        context.user = user
        context.fail!(error_data: error_data) unless context.user
      end

      private

      def user
        @user ||= User.find_or_create_by(email: email).tap do |user|
          user.first_name = given_name
          user.last_name = family_name
          user.password = Devise.friendly_token(20)
        end
      end

      def create_user
        User.create()
      end

      def error_data
        { status: 401, code: :unauthorized, message: "Invalid credentials" }
      end
    end
  end
end
