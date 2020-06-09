class DestroyAllTokens
  include Interactor

  delegate :user, :everywhere, to: :context

  def call
    return unless everywhere

    raise_unauthorized_error unless user

    user.refresh_tokens.destroy_all
  end

  private

  def raise_unauthorized_error
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
