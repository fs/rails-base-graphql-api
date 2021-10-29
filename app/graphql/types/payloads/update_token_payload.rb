module Types
  module Payloads
    class UpdateTokenPayload < Types::BaseObject
      field :access_token, String, null: false
      field :refresh_token, String, null: false
      field :me, Types::CurrentUserType, null: true, method: :user
    end
  end
end
