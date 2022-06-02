module Types
  class SignInInput < Types::BaseInputObject
    argument :email, SquishedString, required: true
    argument :password, String, required: true
  end
end
