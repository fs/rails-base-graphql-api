module Resolvers
  class Base < GraphQL::Schema::Resolver
    argument_class Types::BaseArgument

    private

    def current_user
      @current_user ||= context[:current_user]
    end
  end
end
