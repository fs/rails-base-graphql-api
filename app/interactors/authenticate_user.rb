class AuthenticateUser
  include Interactor

  delegate :email, :password, to: :context

  def call
    context.fail!(error_data: authenticate.error_data) if authenticate.failure?
    context.user = authenticate.user
  end

  private

  def authenticate
    @authenticate ||= AuthenticateByEmailAndPassword.call(email: email, password: password)
  end
end
