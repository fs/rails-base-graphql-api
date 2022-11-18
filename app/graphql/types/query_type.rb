module Types
  class QueryType < Types::BaseObject
    description "Base query"

    field :activities, description: "Activities", resolver: Resolvers::Activities, connection: true
    field :me, description: "Current User", resolver: Resolvers::CurrentUser
  end
end
