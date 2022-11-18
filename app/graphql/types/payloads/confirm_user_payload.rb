module Types
  module Payloads
    class ConfirmUserPayload < Types::BaseObject
      description "Data payload on user confirmation mutation"

      field :me, Types::CurrentUserType, "Current User", null: false, method: :user
    end
  end
end
