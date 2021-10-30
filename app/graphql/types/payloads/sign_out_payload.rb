module Types
  module Payloads
    class SignOutPayload < Types::BaseObject
      field :message, String, null: false
    end
  end
end
