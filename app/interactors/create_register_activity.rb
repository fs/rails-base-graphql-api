class CreateRegisterActivity
  include Interactor

  delegate :user, to: :context

  def call
    activity.save
  end

  private

  def activity
    user.activities.build(
      event: :user_registered,
      title: "User registered",
      body: <<~TXT
        New user registered with the next attributes:
          First name - #{user.first_name},
          Last name - #{user.last_name}
      TXT
    )
  end
end
