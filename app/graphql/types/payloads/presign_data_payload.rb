module Types
  module Payloads
    class PresignDataPayload < Types::BaseObject
      description "Payload object for presign file data mutation"

      field :data, Types::PresignType, "Data", null: false, method: :presign_data
    end
  end
end
