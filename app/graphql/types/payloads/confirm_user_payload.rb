module Types
  module Payloads
    class ConfirmUserPayload < Types::BaseObject
      description "Payload object for user confirmation mutation"

      field :me, Types::CurrentUserType, "Current User", null: false, method: :user
    end
  end
end
