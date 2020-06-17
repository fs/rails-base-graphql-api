class RegisterActivityJob < ApplicationJob
  queue_as :events

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    logger.error(exception.message)
  end

  def perform(user_id)
    user = User.find(user_id)
    CreateRegisterActivity.call(user: user)
  end
end
