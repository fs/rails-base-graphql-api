module AuthenticableUser
  private

  def current_user
    return unless token || refresh_token

    refresh_token&.user
    User.find_by(id: payload_data["sub"]) if payload
  end

  def token
    @token ||= request.headers["Authorization"].to_s.split(" ").last
  end

  def payload
    @payload ||= JWT.decode(token, ENV["AUTH_SECRET_TOKEN"], true, algorithm: "HS256").first
  rescue JWT::DecodeError
    nil
  end

  def payload_data
    @payload_data ||= payload.reduce({}, :merge)
  end

  def refresh_token_header
    request.headers["X-Refresh-Token"].to_s
  end

  def refresh_token
    return if refresh_token_header.present?

    @refresh_token ||= RefreshToken.find_by(token: refresh_token_header)
  end
end
