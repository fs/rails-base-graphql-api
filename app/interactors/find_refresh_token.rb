class FindRefreshToken
  include Interactor
  include AuthenticableInteractor

  delegate :token, to: :context

  before do
    raise_unauthorized_error! unless valid_to_authorize?
  end

  def call
    context.jti = jwt_token.jti
    context.user = refresh_token.user
    context.existing_refresh_token = refresh_token
    context.substitution_token = context.existing_refresh_token.substitution_token
  end

  private

  def valid_to_authorize?
    jwt_token.valid? && jwt_token.refresh? && refresh_token
  end

  def refresh_token
    @refresh_token ||= RefreshToken.active.find_by(token: token)
  end

  def jwt_token
    @jwt_token ||= JWTToken.new(token)
  end
end
