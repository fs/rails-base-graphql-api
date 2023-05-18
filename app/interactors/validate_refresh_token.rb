class ValidateRefreshToken
  include Interactor

  delegate :token, to: :context

  def call
    raise_unauthorized_error unless jwt_token.valid? && jwt_token.refresh?

    destroy_same_tokens unless refresh_token
    refresh_token.destroy
  end

  after do
    context.jwt_token_jti = jwt_token.jti
    context.user = refresh_token.user
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def destroy_same_tokens
    RefreshToken.where(jti: jwt_token.jti).destroy_all

    raise_unauthorized_error
  end

  def jwt_token
    @jwt_token ||= JWTToken.new(token)
  end

  def raise_unauthorized_error
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
