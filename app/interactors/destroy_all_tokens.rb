class DestroyAllTokens
  include Interactor

  delegate :user, :everywhere, to: :context
  delegate :id, to: :user, prefix: true

  def call
    return unless everywhere

    user&.refresh_tokens&.destroy_all
  end
end
