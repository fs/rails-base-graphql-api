module Types
  class ActivityType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :event, ActivityEventType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false

    def user
      Loaders::RecordLoader.for(User).load(object.user_id)
    end
  end
end
