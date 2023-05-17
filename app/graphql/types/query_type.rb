module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    description "Base query"

    field :activities, description: "Activities", resolver: Resolvers::Activities, connection: true
    field :me, description: "Current User", resolver: Resolvers::CurrentUser
  end
end
