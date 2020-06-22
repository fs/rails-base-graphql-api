module Types
  class PresignFieldType < Types::BaseObject
    field :key, String, null: false
    field :value, String, null: false
  end
end
