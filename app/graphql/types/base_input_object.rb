module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    description "Base input object for all input objects"

    argument_class Types::BaseArgument
  end
end
