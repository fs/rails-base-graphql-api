module Types
  class ActivityConnection < GraphQL::Types::Relay::BaseConnection
    edge_type(ActivityEdge)

    field :total_count, Integer, null: false

    def total_count
      10
    end
  end
end
