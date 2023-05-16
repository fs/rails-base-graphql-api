module Types
  module BaseInterface < GraphQL::Schema::Interface
    description "Base interface for all interfaces"

    field_class Types::BaseField
  end
end
