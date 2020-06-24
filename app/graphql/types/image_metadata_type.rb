module Types
  class ImageMetadataType < Types::BaseObject
    field :size, Integer, null: false
    field :filename, String, null: false
    field :mime_type, String, null: false
  end
end
