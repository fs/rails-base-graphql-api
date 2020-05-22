class UpdateTokenPair
  include Interactor::Organizer

  organize DeleteRefreshToken,
           CreateAccessToken,
           CreateRefreshToken
end
