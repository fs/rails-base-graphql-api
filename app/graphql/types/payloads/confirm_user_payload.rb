module Types
  module Payloads
    class ConfirmUserPayload < Types::BaseObject
      field :me, Types::CurrentUserType, null: false, method: :user
    end
  end
end
