class DummyJWTToken
  attr_reader :jti

  def initialize(attrs)
    @token = attrs[:token]
    @user_id = attrs[:user_id] || rand(1_000_000)
    @exp = attrs[:exp] || 1.hour.since.to_i
    @jti = attrs[:jti] || SecureRandom.hex
    @type = attrs[:type] || "access"
  end

  def token
    @token ||= JWT.encode(payload, ENV.fetch("AUTH_SECRET_TOKEN"), "HS256")
  end

  private

  def payload
    {
      sub: @user_id,
      exp: @exp,
      jti: @jti,
      type: @type
    }
  end
end
