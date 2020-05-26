class CreateRefreshToken
  include Interactor

  REFRESH_TOKEN_TTL = 30.days

  delegate :user, :client_uid, to: :context

  def call
    create_refresh_token!
    context.refresh_token = refresh_token
  end

  private

  def create_refresh_token!
    RefreshToken.create!(
      user_id: user.id,
      expires_at: REFRESH_TOKEN_TTL.from_now,
      token: refresh_token,
      client_uid: client_uid
    )
  end

  def refresh_token
    @refresh_token ||= JWT.encode(payload, ENV["AUTH_SECRET_TOKEN"], "HS256")
  end

  def payload
    { sub: user.id, client_uid: client_uid, exp: REFRESH_TOKEN_TTL.from_now.to_i }
  end
end
