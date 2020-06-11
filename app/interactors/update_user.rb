class UpdateUser
  include Interactor::Organizer
  include TransactionalInteractor

  organize  UpdateUserAttributes,
            DestroyAllTokens,
            CreateAccessToken,
            CreateRefreshToken
end
