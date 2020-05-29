class SignupUser
  include Interactor::Organizer

  organize CreateUser,
           CreateJwtToken
end
