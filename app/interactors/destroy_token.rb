class DestroyToken
  include Interactor

  delegate :token, :everywhere, to: :context

  def call
    return if everywhere

    raise_unauthorized_error unless refresh_token

    refresh_token.destroy
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def raise_unauthorized_error
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
