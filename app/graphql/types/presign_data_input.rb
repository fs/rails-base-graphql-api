module Types
  class PresignDataInput < Types::BaseInputObject
    description "Data input to prepare presigned URL"

    argument :filename, String, "Filename for presign", required: true
    argument :type, String, "Filetype", required: true
  end
end
