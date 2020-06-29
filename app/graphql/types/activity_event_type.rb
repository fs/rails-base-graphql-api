module Types
  class ActivityEventType < Types::BaseEnum
    value "USER LOGGED IN", value: "user_logged_in"
    value "USER REGISTERED", value: "user_registered"
    value "USER UPDATED PASSWORD", value: "user_reset_password"
  end
end
