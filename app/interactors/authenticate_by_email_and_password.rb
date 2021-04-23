class AuthenticateByEmailAndPassword
  include Interactor

  delegate :email, :password, to: :context

  def call
    context.fail!(error_data: error_data) unless authenticated?
    context.user = user
  end

  private

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
