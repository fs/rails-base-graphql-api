module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder

    description "Base mutation for all mutations"

    argument_class Types::BaseArgument
    field_class Types::BaseField
    object_class Types::BaseObject

    private

    def current_user
      context[:current_user]
    end

    def token
      context[:token]
    end

    def token_payload
      context[:token_payload]
    end
  end
end
