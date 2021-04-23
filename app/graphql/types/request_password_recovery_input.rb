module Types
  class RequestPasswordRecoveryInput < Types::BaseInputObject
    argument :email, String, required: true
  end
end
