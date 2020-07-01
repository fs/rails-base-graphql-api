module Types
  class ActivityEventType < Types::BaseEnum
    value "USER LOGGED IN", value: "user_logged_in"
    value "USER REGISTERED", value: "user_registered"
    value "USER RESET PASSWORD", value: "user_reset_password"
    value "RESET_PASSWORD_REQUESTED", value: "reset_password_requested"
    value "USER UPDATED", value: "user_updated"
  end
end
