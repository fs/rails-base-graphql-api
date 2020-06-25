class SignupUser
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :user, to: :context

  organize CreateUser,
           CreateAccessToken,
           CreateRefreshToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_registered)
  end
end
