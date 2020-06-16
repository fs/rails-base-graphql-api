module Types
  class PresignType < Types::BaseObject
    field :url, String, null: false
    field :headers, String, null: false
    field :fields, String, null: false
  end
end
