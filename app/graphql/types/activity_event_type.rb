module Types
  class ActivityEventType < Types::BaseEnum
    value "USER LOGGED IN", value: "user_logged_in"
    value "USER REGISTERED", value: "user_registered"
    value "USER RESET PASSWORD", value: "user_reset_password"
    value "USER UPDATED", value: "user_updated"
  end
end
