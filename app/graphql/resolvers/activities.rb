module Resolvers
  class Activities < Resolvers::Base
    type [Types::ActivityType], null: true

    def resolve
      Activity.includes(:user).all
    end
  end
end
