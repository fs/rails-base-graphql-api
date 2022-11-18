module Types
  class CurrentUserType < Types::BaseObject
    description "Data type for current user"

    field :id, ID, "ID", null: false

    field :avatar_url, String, "URL for avatar image", null: true
    field :confirmed_at, GraphQL::Types::ISO8601DateTime, "Confirmation datetime", null: true
    field :email, String, "Email", null: false
    field :first_name, String, "First Name", null: true
    field :last_name, String, "Last Name", null: true

    field :activities, resolver: Resolvers::Activities, connection: true, description: "Activities array"

    delegate :avatar, to: :object
    delegate :url, to: :avatar, prefix: true, allow_nil: true
  end
end
