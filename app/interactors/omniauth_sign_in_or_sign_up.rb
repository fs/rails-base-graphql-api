class OmniauthSignInOrSignUp
  include Interactor::Organizer

  delegate :user, to: :context

  organize OmniauthAuthenticateUser,
           CreateAccessToken,
           CreateRefreshToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_logged_in)
  end
end
