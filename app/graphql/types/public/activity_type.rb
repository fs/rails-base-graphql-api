module Types
  module Public
    class ActivityType < Types::BaseObject
      description "Data type for Public Activity"

      field :id, ID, "ID", null: false

      field :body, String, "Body", null: false

      def user
        Loaders::RecordLoader.for(User).load(object.user_id)
      end
    end
  end
end
