class AuthenticateUser
  include Interactor

  delegate :email, :password, :google_auth_code, to: :context

  def call
    context.fail!(error_data: authenticate.error_data) if authenticate.failure?
    context.user = authenticate.user
  end

  private

  def authenticate
    @authenticate ||= begin
      if email
        AuthenticateByEmailAndPassword.call(email: email, password: password)
      else
        AuthenticateByGoogleAuthCode.call(auth_code: google_auth_code)
      end
    end
  end
end
