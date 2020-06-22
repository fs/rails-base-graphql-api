class UpdatePassword
  include Interactor::Organizer
  include TransactionalInteractor

  organize FindUserByToken,
           UpdateUserPassword,
           CreateAccessToken,
           CreateRefreshToken
end
