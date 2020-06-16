module Types
  class AuthenticationType < Types::BaseObject
    field :access_token, String, null: true
    field :refresh_token, String, null: true
    field :me, Types::UserType, null: true, method: :user

    def access_token
      object.access_token
    end

    def refresh_token
      object.refresh_token
    end
  end
end
