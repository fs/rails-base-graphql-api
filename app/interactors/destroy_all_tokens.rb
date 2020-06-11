class DestroyAllTokens
  include Interactor

  delegate :user, to: :context

  def call
    user.refresh_tokens.destroy_all
  end
end
