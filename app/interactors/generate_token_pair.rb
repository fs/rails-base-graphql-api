class GenerateTokenPair
  include Interactor::Organizer

  organize CreateAccessToken,
           CreateRefreshToken
end
