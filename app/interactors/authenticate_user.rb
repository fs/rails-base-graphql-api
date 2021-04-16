class AuthenticateUser
  include Interactor

  delegate :email, :password, :google_auth_code, to: :context

  def call
    context.fail!(error_data: error_data) unless authenticated?
    context.user = user
  end

  private

  def authenticate
    @authenticate ||= begin
      if email
        AuthenticateByEmailAndPassword.call(email: email, password: password)
      else
        AuthenticateByGoogleAuthCode.call(google_auth_code: google_auth_code)
      end
    end
  end

  def authenticated?
    user&.authenticate(password)
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def error_data
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
