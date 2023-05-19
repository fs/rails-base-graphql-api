class ValidateRefreshToken
  include Interactor

  delegate :token, to: :context

  def call
    raise_unauthorized_error! unless jwt_token.valid? && jwt_token.refresh? && refresh_token

    context.jti = jwt_token.jti
    context.user = refresh_token.user

    refresh_token.destroy
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def jwt_token
    @jwt_token ||= JWTToken.new(token)
  end

  def raise_unauthorized_error!
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
