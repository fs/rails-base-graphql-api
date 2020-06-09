class SignupUser
  include Interactor::Organizer
  include TransactionalInteractor

  organize CreateUser,
           CreateRegisterActivity,
           CreateAccessToken,
           CreateRefreshToken
end
