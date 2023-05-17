module Types
  class UserType < Types::BaseObject
    description "Base user info"

    field :id, ID, "ID", null: false

    field :avatar_url, String, "URL to avatar image", null: true
    field :email, String, "Email", null: false
    field :first_name, String, "First Name", null: true
    field :last_name, String, "Last Name", null: true

    delegate :avatar, to: :object
    delegate :url, to: :avatar, prefix: true, allow_nil: true
  end
end
