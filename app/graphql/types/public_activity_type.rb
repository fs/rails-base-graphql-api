module Types
  class PublicActivityType < Types::BaseObject
    description "Data type for Public Activity"

    field :id, ID, "ID", null: false

    field :body, String, "Body", null: false
    field :title, String, "Title", null: false
  end
end
