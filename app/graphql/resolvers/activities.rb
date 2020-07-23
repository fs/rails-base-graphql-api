module Resolvers
  class Activities < Resolvers::Base
    argument :events, [Types::ActivityEventType], required: false

    type Types::ActivityType.connection_type, null: true

    def fetch_data
      FilteredActivitiesQuery.new(raw_relation, options).all.to_a
    end

    def raw_relation
      object ? Activity.where(user_id: object.id) : Activity.all
    end
  end
end
