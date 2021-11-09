module Types
  module Payloads
    class PresignDataPayload < Types::BaseObject
      field :data, Types::PresignType, null: false, method: :presign_data
    end
  end
end
