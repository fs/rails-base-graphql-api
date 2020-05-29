class DeleteRefreshToken
  include Interactor

  delegate :token, :client_uid, to: :context

  def call
    unless refresh_token
      RefreshToken.where(client_uid: client_uid).delete_all if client_uid

      context.fail!(error_data: error_data)
      context.client_uid = nil
    end

    refresh_token.delete
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
