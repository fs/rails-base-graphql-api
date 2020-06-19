class RegisterActivityJob < ApplicationJob
  queue_as :events

  def perform(user_id)
    user = User.find(user_id)
    CreateRegisterActivity.call!(user: user)
  end
end
