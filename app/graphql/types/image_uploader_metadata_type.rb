module Types
  class ImageUploaderMetadataType < Types::BaseInputObject
    argument :size, Integer, required: true
    argument :filename, String, required: true
    argument :mime_type, String, required: true
  end
end
