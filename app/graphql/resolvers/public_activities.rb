module Resolvers
  class PublicActivities < Resolvers::Base
    description "Fetch public activities"

    type Types::PublicActivityType.connection_type, null: true

    def fetch_data
      Activity.public_events
    end
  end
end
