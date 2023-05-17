module Types
  class UpdatePasswordInput < Types::BaseInputObject
    description "Input object for update user password on reset password"

    argument :password, String, "A new password", required: true
    argument :reset_token, String, "Password reset token", required: true
  end
end
