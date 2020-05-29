module Types
  class AuthenticationType < Types::BaseObject
    field :token, String, null: true
    field :me, Types::UserType, null: true, method: :user
  end
end
