module Types
  module Payloads
    class UpdateUserPayload < Types::BaseObject
      description "Payload object for update user mutation"

      field :me, Types::CurrentUserType, "Current User", null: false, method: :user
    end
  end
end
