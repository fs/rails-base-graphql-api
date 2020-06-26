module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :avatar_url, String, null: true
    field :activities, [Types::ActivityType], null: true do
      argument :first, Integer, required: false
      argument :skip, Integer, required: false
    end

    def activities(first:, skip:)
      Loaders::AssociationLoader.for(User, :activities).load(object)
    end

    def avatar_url
      object.avatar.url
    end
  end
end
