module Types
  module NodeType
    include Types::BaseInterface
    include GraphQL::Types::Relay::NodeBehaviors

    description "An object with an ID"
  end
end
