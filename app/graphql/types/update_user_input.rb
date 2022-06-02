module Types
  class UpdateUserInput < Types::BaseInputObject
    argument :email, SquishedString, required: false
    argument :first_name, SquishedString, required: false
    argument :last_name, SquishedString, required: false
    argument :current_password, String, required: false
    argument :password, String, required: false
    argument :avatar, Types::ImageUploaderType, required: false
  end
end
