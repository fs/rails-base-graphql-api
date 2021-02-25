module Types
  class UpdatePasswordInput < Types::BaseInputObject
    argument :password, String, required: true
    argument :reset_token, String, required: true
  end
end
