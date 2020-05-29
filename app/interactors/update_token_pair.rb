class UpdateTokenPair
  include Interactor::Organizer

  organize DeleteRefreshToken,
           GenerateTokenPair
end
