class DestroyAllTokens
  include Interactor

  delegate :user, to: :context

  def call
    user.refresh_tokens.destroy_all if user.will_save_change_to_attribute?(:password)
  end
end
