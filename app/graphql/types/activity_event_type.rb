module Types
  class ActivityEventType < Types::BaseEnum
    value "USER_LOGGED_IN", value: "user_logged_in"
    value "USER_REGISTERED", value: "user_registered"
    value "RESET_PASSWORD_REQUESTED", value: "reset_password_requested"
    value "USER_UPDATED", value: "user_updated"
  end
end
