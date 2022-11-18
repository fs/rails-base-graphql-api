module Types
  class PresignFieldType < Types::BaseObject
    description "Data type for presign fields"

    field :key, String, "Key", null: false
    field :value, String, "Value", null: false
  end
end
