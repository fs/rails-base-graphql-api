module Types
  class SignUpInput < Types::BaseInputObject
    argument :email, SquishedString, required: true
    argument :password, String, required: true

    argument :first_name, SquishedString, required: false
    argument :last_name, SquishedString, required: false

    argument :avatar, Types::ImageUploaderType, required: false
  end
end
