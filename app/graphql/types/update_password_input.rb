module Types
  class UpdatePasswordInput < Types::BaseInputObject
    description "Data input to update user password on reset password"

    argument :password, String, "A new password", required: true
    argument :reset_token, String, "Password reset token", required: true
  end
end
