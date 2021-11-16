module Types
  class OmniauthInput < Types::BaseInputObject
    argument :auth_code, String, required: true
  end
end
