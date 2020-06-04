module Resolvers
  class CurrentUser < Resolvers::Base
    type Types::UserType, null: true

    def resolve
      current_user if type == "access"
    end

    private

    def type
      context[:token_payload] && context[:token_payload]["type"]
    end
  end
end
