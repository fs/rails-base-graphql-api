module Types
  module Payloads
    class SignOutPayload < Types::BaseObject
      description "Payload object for sign out mutation"

      field :message, String, "Confirmation message", null: false
    end
  end
end
