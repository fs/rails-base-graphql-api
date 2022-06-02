module Types
  class SignUpInput < Types::BaseInputObject
    argument :email, SquishedString, required: true
    argument :password, String, required: true

    argument :first_name, String, required: false
    argument :last_name, String, required: false

    argument :avatar, Types::ImageUploaderType, required: false
  end
end
