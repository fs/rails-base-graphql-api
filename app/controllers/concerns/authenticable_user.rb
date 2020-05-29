module AuthenticableUser
  private

  def current_user
    return unless token && payload

    User.find_by(id: payload_data["sub"])
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
end
