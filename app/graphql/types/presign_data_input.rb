module Types
  class PresignDataInput < Types::BaseInputObject
    argument :filename, String, required: true
    argument :type, String, required: true
  end
end
