module Types
  class SignUpInput < Types::BaseInputObject
    description "Data input to sign up"

    argument :avatar, Types::ImageUploaderType, "URL to avatar image", required: false
    argument :email, String, "Email", required: true
    argument :first_name, String, "First Name", required: false
    argument :last_name, String, "Last Name", required: false
    argument :password, String, "Password", required: true
  end
end
