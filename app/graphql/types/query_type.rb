module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    description "Base query"

    field :me, description: "Current User", resolver: Resolvers::CurrentUser

    field :activities, description: "Activities", resolver: Resolvers::Public::Activities, connection: true
  end
end
