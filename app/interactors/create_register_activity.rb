class CreateRegisterActivity
  include Interactor

  delegate :user, to: :context

  def call
    user.activities.create!(activity_attributes)
  end

  private

  def activity_attributes
    {
      event: :user_registered,
      title: "User registered",
      body: activity_body
    }
  end

  def activity_body
    <<~TXT
      New user registered with the next attributes:
        First name - #{user.first_name},
        Last name - #{user.last_name}
    TXT
  end
end
