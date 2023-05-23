class CreateRefreshToken
  include Interactor
  include AuthenticableInteractor

  REFRESH_TOKEN_TTL = 30.days

  delegate :user, :jti, :substitution_token, to: :context

  def call
    context.substitution_token ||= refresh_token
    context.refresh_token = substitution_token.token

    raise_unauthorized_error! unless substitution_token.save
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.new(
      user_id: user.id,
      expires_at: REFRESH_TOKEN_TTL.from_now,
      token: refresh_token_value,
      jti: jti
    )
  end

  def refresh_token_value
    @refresh_token_value ||= JWT.encode(payload, ENV.fetch("AUTH_SECRET_TOKEN"), "HS256")
  end

  def payload
    {
      sub: user.id,
      exp: REFRESH_TOKEN_TTL.from_now.to_i,
      jti: jti,
      type: "refresh"
    }
  end
end
