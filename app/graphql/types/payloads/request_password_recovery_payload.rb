module Types
  module Payloads
    class RequestPasswordRecoveryPayload < Types::BaseObject
      field :message, String, null: false
      field :detail, String, null: false
    end
  end
end
