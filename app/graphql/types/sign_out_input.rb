module Types
  class SignOutInput < Types::BaseInputObject
    description "Data input to sign out"

    argument :everywhere, Boolean, "If true all sessions will reset", required: false
  end
end
