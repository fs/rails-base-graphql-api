module Types
  class AuthenticationType < Types::BaseObject
    field :access_token, String, null: false
    field :refresh_token, String, null: false
    field :me, Types::UserType, null: true, method: :user
  end
end
