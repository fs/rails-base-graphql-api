class CreateAccessToken
  include Interactor

  ACCESS_TOKEN_TTL = 1.hour

  delegate :user, to: :context

  def call
    context.fail!(error_data: error_data) unless user

    context.access_token = access_token
  end

  private

  def access_token
    JWT.encode(payload, ENV["AUTH_SECRET_TOKEN"], "HS256")
  end

  def payload
    { sub: user.id, exp: ACCESS_TOKEN_TTL.from_now.to_i }
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
