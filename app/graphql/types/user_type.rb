module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :avatar_url, String, null: true

    field :activities, resolver: Resolvers::Activities, connection: true

    def avatar_url
      object.avatar.url
    end
  end
end
