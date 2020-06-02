module AuthenticableUser
  private

  def current_user
    return unless token && payload

    unauthenticated_request_error unless payload && refresh_token

    User.find_by(id: payload["sub"])
  end

  def token
    @token ||= request.headers["Authorization"].to_s.split(" ").last
  end

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    nil
  end

  def jti
    payload["jti"]
  end

  def refresh_token
    RefreshToken.active.find_by(jti: jti).present?
  end

  def unauthenticated_request_error
    GraphQL::ExecutionError.new(
      extensions: { title: "Invalid credentials", detail: "", status: 401, code: :unauthorized, meta: {} }
    )
  end
end
