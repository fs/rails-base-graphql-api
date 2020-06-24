module Types
  class ImageType < Types::BaseObject
    field :id, String, null: false
    field :metadata, Types::ImageMetadataType, null: false
  end
end
