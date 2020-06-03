class SigninUser
  include Interactor::Organizer

  organize ValidateRefreshToken,
           DestroyAllTokens,
end
