module Types
  class DetailedMessageType < Types::BaseObject
    field :message, String, null: false
    field :detail, String, null: false
  end
end
