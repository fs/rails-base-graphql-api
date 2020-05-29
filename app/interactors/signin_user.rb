class SigninUser
  include Interactor::Organizer

  organize AuthenticateUser,
           CreateJwtToken
end
