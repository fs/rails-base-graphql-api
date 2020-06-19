class UpdatePassword
  include Interactor::Organizer

  organize FindUserByToken,
           UpdateUserPassword,
           CreateAccessToken,
           CreateRefreshToken
end
