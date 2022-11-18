module Types
  class RequestPasswordRecoveryInput < Types::BaseInputObject
    description "Data input to reset password flow"

    argument :email, String, "Email", required: true
  end
end
