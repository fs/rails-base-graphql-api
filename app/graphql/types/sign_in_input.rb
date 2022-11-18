module Types
  class SignInInput < Types::BaseInputObject
    description "Data input to sign in"

    argument :email, String, "Email", required: true
    argument :password, String, "Password", required: true
  end
end
