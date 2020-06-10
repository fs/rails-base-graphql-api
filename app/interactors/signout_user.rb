class SignoutUser
  include Interactor

  delegate :user, :token, :everywhere, to: :context

  def call
    refresh_tokens = user.refresh_tokens
    refresh_tokens = refresh_tokens.where(token: token) unless everywhere
    refresh_tokens.destroy_all
  end
end
