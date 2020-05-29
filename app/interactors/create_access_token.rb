class CreateAccessToken
  include Interactor

  ACCESS_TOKEN_TTL = 1.hour

  delegate :user, :client_uid, to: :context

  before do
    context.client_uid ||= client_uid
  end

  def call
    context.fail!(error_data: error_data) unless user

    context.access_token = access_token
    context.client_uid = client_uid
    context.jti = jti
  end

  private

  def access_token
    JWT.encode(payload, ENV["AUTH_SECRET_TOKEN"], "HS256")
  end

  def payload
    {
      sub: user.id,
      exp: ACCESS_TOKEN_TTL.from_now.to_i,
      client_uid: client_uid,
      jti: jti,
      type: "access"
    }
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end

  def client_uid
    "#{user.id}-#{Time.current.to_i}"
  end

  def jti
    @jti ||= "#{user.id}-#{Time.current.to_i}".crypt(salt)
  end

  def salt
    ENV.fetch("JWT_TOKEN_JTI_SALT")
  end
end
