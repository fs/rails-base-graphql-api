class ValidateRefreshToken
  include Interactor

  delegate :token, to: :context

  def call
    context.fail!(error_data: error_data) unless type == "refresh"

    context.client_uid = client_uid
  end

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    nil
  end

  def client_uid
    payload["client_uid"]
  end

  def type
    payload["type"]
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
