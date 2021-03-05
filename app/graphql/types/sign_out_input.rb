module Types
  class SignOutInput < Types::BaseInputObject
    argument :everywhere, Boolean, required: false
  end
end
