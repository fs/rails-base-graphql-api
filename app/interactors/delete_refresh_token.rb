class DeleteRefreshToken
  include Interactor

  delegate :token, to: :context

  def call
    context.fail!(error_data: error_data) unless refresh_token

    refresh_token.destroy
  end

  private

  def refresh_token
    @refresh_token ||= RefreshToken.find_by(token: token)
  end

  def error_data
    { message: "Not found", status: 404, code: :not_found }
  end
end
