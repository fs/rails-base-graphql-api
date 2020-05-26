class DeleteRefreshToken
  include Interactor

  delegate :client_uid, to: :context

  def call
    context.fail!(error_data: error_data) unless refresh_token

    refresh_token.delete
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(client_uid: client_uid)
  end

  def error_data
    { message: "Not found", status: 404, code: :not_found }
  end
end
