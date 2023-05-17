module Types
  class ConfirmUserInput < Types::BaseInputObject
    description "Input object for user confirmation flow"

    argument :value, String, "Token", required: true
  end
end
