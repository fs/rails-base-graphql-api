class SignupUser
  include Interactor::Organizer

  organize CreateUser,
           CreateAccessToken,
           CreateRefreshToken
end
