module Types
  class QueryType < Types::BaseObject
    field :me, resolver: Resolvers::CurrentUser
  end
end
