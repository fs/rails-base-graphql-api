module Types
  class PresignType < Types::BaseObject
    field :url, String, null: false
    field :fields, [PresignFieldType], null: false
  end
end
