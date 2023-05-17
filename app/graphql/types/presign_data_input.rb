module Types
  class PresignDataInput < Types::BaseInputObject
    description "Input object for prepare presigned URL"

    argument :filename, String, "Filename for presign", required: true
    argument :type, String, "Filetype", required: true
  end
end
