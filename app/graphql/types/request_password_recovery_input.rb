module Types
  class RequestPasswordRecoveryInput < Types::BaseInputObject
    description "Input object for reset password flow"

    argument :email, String, "Email", required: true
  end
end
