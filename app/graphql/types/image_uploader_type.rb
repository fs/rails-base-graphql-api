module Types
  class ImageUploaderType < Types::BaseInputObject
    description "Data type for upload file"

    argument :id, String, "ID", required: true
    argument :metadata, Types::ImageUploaderMetadataType, "File metadata", required: true
    argument :storage, String, "Storage: cache or store", required: false, default_value: "cache"

    def prepare
      to_hash
    end
  end
end
