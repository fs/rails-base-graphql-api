module Resolvers
  class CurrentUser < Resolvers::Base
    include SkipAuthentication

    description "Fetch current user"

    type Types::CurrentUserType, null: true

    def resolve
      current_user
    end
  end
end
