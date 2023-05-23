class AuthenticateByEmailAndPassword
  include Interactor
  include AuthorizedInteractor

  delegate :email, :password, to: :context

  def call
    raise_unauthorized_error! unless authenticated?
    context.user = user
  end

  private

  def authenticated?
    user&.authenticate(password)
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
