module AuthenticableUser
  def current_user
    @current_user ||= User.find_by(id: payload["sub"]) if valid_to_authenticate?
  end

  private

  def valid_to_authenticate?
    token && payload.present? && access_token_type? && active_refresh_token?
  end

  def token
    @token ||= request.headers["Authorization"].to_s.match(/Bearer (.*)/).to_a.last
  end

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    {}
  end

  def active_refresh_token?
    RefreshToken.active.exists?(jti: payload["jti"])
  end

  def access_token_type?
    payload["type"] == "access"
  end
end
