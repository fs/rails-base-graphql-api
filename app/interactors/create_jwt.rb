class CreateJwt
  include Interactor

  delegate :email, :password, to: :context

  def call
    context.fail!(error: :invalid_credentials) unless authenticated?
    context.user = user
    context.token = token
  end

  private

  def authenticated?
    user && user.authenticate(password)
  end

  def token
    JWT.encode payload, nil, "none"
  end

  def payload
    { sub: user.id }
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
