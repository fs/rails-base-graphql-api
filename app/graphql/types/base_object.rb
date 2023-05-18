module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    include ActionPolicy::GraphQL::Behaviour

    field_class Types::BaseField
  end
end
