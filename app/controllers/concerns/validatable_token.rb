module ValidatableToken
  private

  def validate_token!
    return unless token || refresh_token_value

    raise_invalid_token unless refresh_token
  end

  def client_uid
    return unless payload

    payload["client_uid"]
  end

  def refresh_token
    @refresh_token ||= refresh_token_by_token || refresh_token_by_refresh_token
  end

  def refresh_token_by_token
    return unless token

    RefreshToken.find_by(client_uid: client_uid)
  end

  def refresh_token_by_refresh_token
    return unless refresh_token_value

    RefreshToken.find_by(token: refresh_token_value)
  end

  def raise_invalid_token
    render json: { error: "Invalid token" }, status: :unauthorized
  end
end
