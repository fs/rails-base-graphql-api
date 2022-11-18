module Resolvers
  class CurrentUser < Resolvers::Base
    description "Data type for current user"

    type Types::CurrentUserType, null: true

    def resolve
      current_user if type == "access"
    end

    private

    def type
      context[:token_payload][:type]
    end
  end
end
