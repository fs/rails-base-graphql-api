class SignupUser
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :user, to: :context

  organize CreateUser,
           CreateAccessToken,
           CreateRefreshToken,
           CreatePossessionToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_registered)
    ApplicationMailer.confirm_user(context.possession_token).deliver_later
  end
end
