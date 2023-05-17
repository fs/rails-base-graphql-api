module Resolvers
  module Public
    class Activities < Resolvers::Base
      include SkipAuthentication

      description "Fetch public activities"

      type Types::Public::ActivityType.connection_type, null: true

      def fetch_data
        Activity.public_events
      end
    end
  end
end
