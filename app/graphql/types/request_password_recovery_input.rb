module Types
  class RequestPasswordRecoveryInput < Types::BaseInputObject
    argument :email, SquishedString, required: true
  end
end
