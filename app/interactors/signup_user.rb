class SignupUser
  include Interactor::Organizer
  include TransactionalInteractor

  organize CreateUser,
           CreateAccessToken,
           CreateRefreshToken
end
