class SignoutUser
  include Interactor::Organizer

  organize DestroyToken,
           DestroyAllTokens
end
