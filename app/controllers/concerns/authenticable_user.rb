module AuthenticableUser
  def current_user
    @current_user ||= User.find_by(id: jwt_token.sub) if valid_to_authenticate?
  end

  private

  def valid_to_authenticate?
    token && jwt_token.valid? && jwt_token.access? && active_refresh_token?
  end

  def active_refresh_token?
    RefreshToken.active.exists?(jti: jwt_token.jti)
  end

  def jwt_token
    @jwt_token ||= JWTToken.new(token)
  end

  def token
    @token ||= request.headers["Authorization"].to_s.match(/Bearer (.*)/).to_a.last
  end
end
