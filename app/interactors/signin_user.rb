class SigninUser
  include Interactor::Organizer

  organize AuthenticateUser,
           CreateAccessToken,
           CreateRefreshToken
end
