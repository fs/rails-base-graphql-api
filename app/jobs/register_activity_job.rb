class RegisterActivityJob < ApplicationJob
  queue_as :events

  def perform(user_id, event)
    user = User.find(user_id)
    CreateUserActivity.call!(user: user, event: event)
  end
end
