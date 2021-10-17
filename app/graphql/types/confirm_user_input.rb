module Types
  class ConfirmUserInput < Types::BaseInputObject
    argument :value, String, required: true
  end
end
