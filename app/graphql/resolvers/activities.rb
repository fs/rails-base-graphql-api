module Resolvers
  class Activities < Resolvers::Base
    argument :events, [Types::ActivityEventType], required: false

    type Types::ActivityType.connection_type, null: true

    def fetch_data
      FilteredActivitiesQuery.new(raw_relation, options).all.to_a
    end

    def raw_relation
      authorized_scope(Activity.all, with: ::ActivityPolicy)
    end
  end
end
