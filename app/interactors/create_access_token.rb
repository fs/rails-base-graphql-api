class CreateAccessToken
  include Interactor

  ACCESS_TOKEN_TTL = 1.hour

  delegate :user, :jwt_token_jti, to: :context

  def call
    context.access_token = access_token
    context.jti = jti
  end

  private

  def access_token
    JWT.encode(payload, ENV.fetch("AUTH_SECRET_TOKEN"), "HS256")
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
    @jti ||= jwt_token_jti || generate_jti
  end

  def generate_jti
    Digest::MD5.hexdigest("#{user.id}-#{Time.current.to_i}")
  end
end
