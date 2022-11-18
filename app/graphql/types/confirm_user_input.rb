module Types
  class ConfirmUserInput < Types::BaseInputObject
    description "Data input for user confirmation flow"

    argument :value, String, "Token", required: true
  end
end
