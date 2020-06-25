module Types
  class ActivityEventType < Types::BaseEnum
    value "USER LOGGED IN", value: "user_logged_in"
    value "USER REGISTERED", value: "user_registered"
    value "RESET PASSWORD REQUEST", value: "reset_password_request"
  end
end
