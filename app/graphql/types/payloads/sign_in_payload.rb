module Types
  module Payloads
    class SignInPayload < Types::BaseObject
      description "Payload object for sign in mutation"

      field :access_token, String, "Short live access token", null: false
      field :refresh_token, String, "Long live refresh token", null: false

      field :me, Types::CurrentUserType, "Current User", null: true, method: :user
    end
  end
end
