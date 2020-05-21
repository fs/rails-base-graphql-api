class SigninUser
  include Interactor::Organizer

  organize AuthenticateUser,
          GenerateTokenPair
end
