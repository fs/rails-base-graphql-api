module Types
  class OmniauthInput < Types::BaseInputObject
    description "Input object for oauth authentication"

    argument :auth_code, String, "OAuth token from provider", required: true
  end
end
