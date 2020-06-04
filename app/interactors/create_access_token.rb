class CreateAccessToken
  include Interactor

  ACCESS_TOKEN_TTL = 1.hour

  delegate :user, :token_payload, to: :context

  def call
    context.access_token = access_token
    context.jti = jti
  end

  private

  def access_token
    JWT.encode(payload, auth_secret_token, "HS256")
  end

  def payload
    {
      sub: user.id,
      exp: ACCESS_TOKEN_TTL.from_now.to_i,
      jti: jti,
      type: "access"
    }
  end

  def jti
    @jti ||= existing_jti || generate_jti
  end

  def existing_jti
    token_payload && token_payload["jti"]
  end

  def generate_jti
    Digest::MD5.hexdigest("#{user.id}-#{Time.current.to_i}")
  end

  def auth_secret_token
    @auth_secret_token ||= ENV.fetch("AUTH_SECRET_TOKEN")
  end
end
