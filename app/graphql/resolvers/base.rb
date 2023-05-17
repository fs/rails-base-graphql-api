module Resolvers
  class Base < GraphQL::Schema::Resolver
    include AuthenticableGraphqlUser
    include ExecutionErrorResponder
    include ActionPolicy::GraphQL::Behaviour
    include TriggerableEvents

    description "Base resolver"

    argument_class Types::BaseArgument

    def resolve(**options)
      @options = options
      append_trigger_event(trigger_event) if trigger_event.present?
      fetch_data
    end

    private

    attr_reader :options

    def fetch_data
      raise NotImplementedError
    end

    def current_user
      @current_user ||= context[:current_user]
    end

    def trigger_event
    end
  end
end
