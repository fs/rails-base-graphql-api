class SigninUser
  include Interactor::Organizer

  delegate :user, to: :context

  organize AuthenticateByEmailAndPassword,
           CreateAccessToken,
           CreateRefreshToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_logged_in)
  end
end
