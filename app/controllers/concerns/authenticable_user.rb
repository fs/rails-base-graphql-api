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
    @payload ||= JWT.decode token, nil, false
  rescue JWT::DecodeError
    nil
  end

  def payload_data
    @payload_data ||= payload.reduce Hash.new, :merge
  end
end
