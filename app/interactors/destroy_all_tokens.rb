class DestroyAllTokens
  include Interactor

  delegate :token_payload, :everywhere, to: :context

  def call
    return unless everywhere

    destroy_user_all_tokens
  end

  private

  def destroy_user_all_tokens
    RefreshToken.where(user_id: token_payload["sub"]).destroy_all
  end
end
