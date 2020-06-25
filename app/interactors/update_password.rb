class UpdatePassword
  include Interactor::Organizer
  include TransactionalInteractor

  delegate :user, to: :context

  organize FindUserByToken,
           UpdateUserPassword,
           CreateAccessToken,
           CreateRefreshToken

  after do
    RegisterActivityJob.perform_later(user.id, :user_updated_password)
  end
end
