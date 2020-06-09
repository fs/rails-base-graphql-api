module Resolvers
  class Activities < Resolvers::Base
    type [Types::ActivityType], null: true

    def resolve
      Activity.all
    end
  end
end
