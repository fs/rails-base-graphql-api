class GenerateTokenPair
  include Interactor::Organizer

  organize ValidateRefreshToken,
           CreateAccessToken,
           CreateRefreshToken
end
