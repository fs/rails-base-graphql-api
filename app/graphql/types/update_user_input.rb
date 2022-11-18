module Types
  class UpdateUserInput < Types::BaseInputObject
    description "Data input to update user info"

    argument :avatar, Types::ImageUploaderType, "Avatar data", required: false
    argument :email, String, "Email", required: false
    argument :first_name, String, "First Name", required: false
    argument :last_name, String, "Last Name", required: false

    argument :current_password, String, "Password", required: false
    argument :password, String, "Password", required: false
  end
end
