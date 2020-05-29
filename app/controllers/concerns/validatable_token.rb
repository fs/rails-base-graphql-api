module ValidatableToken
  private

  def validate_token!
    return unless token

    raise_invalid_token unless refresh_token
  end

  def jti
    payload_data["jti"]
  end

  def refresh_token
    RefreshToken.active.find_by(jti: jti).exists?
  end

  def raise_invalid_token
    render json: { error: "Invalid token" }, status: :unauthorized
  end
end
