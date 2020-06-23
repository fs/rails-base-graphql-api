class CreateUserActivity
  include Interactor

  delegate :user, :event, to: :context

  def call
    user.activities.create!(activity_attributes)
  end

  private

  def activity_attributes
    {
      event: :event,
      title: :event.to_s.titleize,
      body: activity_body
    }
  end

  def activity_body
    I18n.t("activity.#{event}", user: user)
  end
end
