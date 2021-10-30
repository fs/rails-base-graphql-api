module Types
  module Payloads
    class UpdateUserPayload < Types::BaseObject
      field :me, Types::CurrentUserType, null: false, method: :user
    end
  end
end
