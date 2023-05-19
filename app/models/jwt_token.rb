class JWTToken
  def initialize(token)
    @token = token
  end

  def valid?
    payload.present?
  end

  def access?
    type == "access"
  end

  def refresh?
    type == "refresh"
  end

  def type
    payload["type"]
  end

  def jti
    payload["jti"]
  end

  def sub
    payload["sub"]
  end

  private

  attr_reader :token

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    {}
  end
end
