class OmniauthAuthenticateUser
  include Interactor

  delegate :auth_code, to: :context

  def call
    context.fail!(error_data: authenticate.error_data) if authenticate.failure?
    context.user = authenticate.user
  end

  private

  def authenticate
    @authenticate ||= AuthenticateByGoogleAuthCode.call(auth_code: auth_code)
  end
end
