module Types
  class AuthenticationType < Types::BaseObject
    field :access_token, String, null: true
    field :refresh_token, String, null: true
    field :me, Types::UserType, null: true, method: :user

    delegate :access_token, :refresh_token, to: :object
  end
end
