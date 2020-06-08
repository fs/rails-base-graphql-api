class UpdatePassword
  include Interactor::Organizer

  organize FindUserByToken,
           UpdateUserPassword,
           CreateJwtToken
end
