module Types
  class BaseField < GraphQL::Schema::Field
    description "Base field for all fields"

    argument_class Types::BaseArgument
  end
end
