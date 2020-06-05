class SignoutUser
  include Interactor

  delegate :token, :token_payload, :everywhere, to: :context

  def call
    if everywhere
      destroy_user_all_tokens
    else
      raise_unauthorized_error unless refresh_token
      refresh_token.destroy
    end
  end

  private

  def destroy_user_all_tokens
    RefreshToken.where(user_id: token_payload["sub"]).destroy_all if token_payload
  end

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def raise_unauthorized_error
    context.fail!(error_data: error_data)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
