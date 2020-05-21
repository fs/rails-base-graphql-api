class SignupUser
  include Interactor::Organizer

  organize CreateUser,
           GenerateTokenPair
end
