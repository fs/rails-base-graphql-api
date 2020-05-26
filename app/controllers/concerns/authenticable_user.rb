module AuthenticableUser
  private

  def current_user
    return unless token || refresh_token_value

    refresh_token&.user
  end

  def token
    @token ||= request.headers["Authorization"].to_s.split(" ").last
  end

  def refresh_token_value
    @refresh_token_value ||= request.headers["X-Refresh-Token"].to_s.split(" ").last
  end

  def payload
    @payload ||= JWT.decode token, nil, false
  rescue JWT::DecodeError
    nil
  end
end
