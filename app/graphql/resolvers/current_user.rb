module Resolvers
  class CurrentUser < Resolvers::Base
    type Types::UserType, null: true

    def resolve
      current_user
    end
  end
end
