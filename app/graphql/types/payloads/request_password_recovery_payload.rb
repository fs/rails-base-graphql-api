module Types
  module Payloads
    class RequestPasswordRecoveryPayload < Types::BaseObject
      description "Data payload on request password reset mutation"

      field :detail, String, "Detail", null: false
      field :message, String, "Message", null: false
    end
  end
end
