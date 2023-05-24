class UpdateTokenPair
  include Interactor::Organizer
  include TransactionalInteractor

  organize  FindRefreshToken,
            CreateAccessToken,
            CreateRefreshToken,
            UpdateExistingRefreshToken
end
