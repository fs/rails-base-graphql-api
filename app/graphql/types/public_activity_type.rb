module Types
  class PublicActivityType < Types::BaseObject
    description "Data type for Public Activity"

    field :id, ID, "ID", null: false

    field :body, String, "Body", null: false
    field :title, String, "Title", null: false

    def user
      Loaders::RecordLoader.for(User).load(object.user_id)
    end
  end
end
