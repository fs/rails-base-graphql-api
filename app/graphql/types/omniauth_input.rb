module Types
  class OmniauthInput < Types::BaseInputObject
    description "Data input on oauth authentication"

    argument :auth_code, String, "OAuth token from provider", required: true
  end
end
