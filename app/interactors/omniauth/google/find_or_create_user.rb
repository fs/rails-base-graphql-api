module Omniauth
  module Google
    class FindOrCreateUser
      include Interactor
      include AuthorizedInteractor

      delegate :user_info, :user, to: :context
      delegate :email, :family_name, :given_name, :picture, to: :user_info

      def call
        context.user = user
        raise_unauthorized_error! unless user.valid?
      end

      private

      def user
        @user ||= User.find_or_create_by(email: email) do |user|
          user.first_name = given_name
          user.last_name = family_name
          user.password = SecureRandom.hex(20)
          user.avatar = URI.open(picture) if picture.present?
        end
      end
    end
  end
end
