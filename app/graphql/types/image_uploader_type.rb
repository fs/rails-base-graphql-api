module Types
  class ImageUploaderType < Types::BaseInputObject
    argument :id, String, required: true
    argument :storage, String, required: false, default_value: "cache"
    argument :metadata, Types::ImageUploaderMetadataType, required: true

    def prepare
      to_hash
    end
  end
end
