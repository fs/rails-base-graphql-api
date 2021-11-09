module AuthenticableUser
  private

  def current_user
    return unless token && payload
    return unless active_refresh_token?

    User.find_by(id: payload["sub"])
  end

  def token
    @token ||= request.headers["Authorization"].to_s.match(/Bearer (.*)/).to_a.last
  end

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    nil
  end

  def jti
    payload["jti"]
  end

  def active_refresh_token?
    RefreshToken.active.exists?(jti: jti)
  end
end
