module Types
  class SignInInput < Types::BaseInputObject
    argument :email, String, required: false
    argument :password, String, required: false
    argument :google_auth_code, String, required: false
  end
end
