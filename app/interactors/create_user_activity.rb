class CreateUserActivity
  include Interactor

  delegate :user, :event, to: :context

  def call
    user.activities.create!(activity_attributes)
  end

  private

  def activity_attributes
    {
      event: event,
      title: event.to_s.titleize,
      body: activity_body
    }
  end

  def activity_body
    I18n.t("activity.#{event}", first_name: user.first_name, last_name: user.last_name, email: user.email)
  end
end
