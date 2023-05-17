module Types
  class PresignType < Types::BaseObject
    description "Data type to presign file for upload"

    field :fields, [PresignFieldType], "Metadata fields used as headers on upload to storage", null: false
    field :url, String, "URL where to upload file", null: false
  end
end
