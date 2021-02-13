class Types::SignUpAttributes < Types::BaseInputObject
  argument :email, String, required: true
  argument :password, String, required: true

  argument :first_name, String, required: false
  argument :last_name, String, required: false

  argument :avatar, Types::ImageUploaderType, required: false
end
