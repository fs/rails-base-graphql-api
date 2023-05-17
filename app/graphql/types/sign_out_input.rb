module Types
  class SignOutInput < Types::BaseInputObject
    description "Input object for sign out"

    argument :everywhere, Boolean, "If true all sessions will reset", required: false
  end
end
