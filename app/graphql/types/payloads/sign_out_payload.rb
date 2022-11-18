module Types
  module Payloads
    class SignOutPayload < Types::BaseObject
      description "Data payload on signout mutation"

      field :message, String, "Confirmation message", null: false
    end
  end
end
