module Types
  class BaseObject < GraphQL::Schema::Object
    include ActionPolicy::GraphQL::Behaviour

    description "Base object for all objects"

    field_class Types::BaseField
  end
end
