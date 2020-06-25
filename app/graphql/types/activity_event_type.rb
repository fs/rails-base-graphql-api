module Types
  class ActivityEventType < Types::BaseEnum
    value "USER LOGGED IN", value: "user_logged_in"
    value "USER LOGIN ATTEMPT FAILED", value: "user_login_attempt_failed"
    value "USER REGISTERED", value: "user_registered"
  end
end
