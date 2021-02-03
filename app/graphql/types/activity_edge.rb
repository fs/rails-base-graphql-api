module Types
  class ActivityEdge < GraphQL::Types::Relay::BaseEdge
    node_type(ActivityType)
  end
end
