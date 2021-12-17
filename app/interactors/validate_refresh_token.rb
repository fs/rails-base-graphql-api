class ValidateRefreshToken
  include Interactor

  delegate :token, :token_payload, to: :context

  def call
    raise_unauthorized_error unless token_payload[:type] == "refresh"
    destroy_same_tokens unless refresh_token

    refresh_token.destroy
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def destroy_same_tokens
    RefreshToken.where(jti: token_payload[:jti]).destroy_all

    raise_unauthorized_error
  end

  def raise_unauthorized_error
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
