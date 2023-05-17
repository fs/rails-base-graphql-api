module Types
  class ActivityType < Types::BaseObject
    description "Data type for Activity"

    field :id, ID, "ID", null: false

    field :body, String, "Body", null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, "Created datetime", null: false
    field :event, ActivityEventType, "Event type from Enum", null: false
    field :title, String, "Title", null: false
    field :user, Types::UserType, "Activity initiator", null: false

    def user
      Loaders::RecordLoader.for(User).load(object.user_id)
    end
  end
end
