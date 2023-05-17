module Types
  class ImageUploaderMetadataType < Types::BaseInputObject
    description "Data type for file"

    argument :filename, String, "Filename", required: true
    argument :mime_type, String, "Filetype", required: true
    argument :size, Integer, "Size in bytes", required: true
  end
end
