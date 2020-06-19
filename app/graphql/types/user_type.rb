module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :activities, [ActivityType], null: true

    def activities
      Loaders::AssociationLoader.for(User, :activities).load(object)
    end
  end
end
