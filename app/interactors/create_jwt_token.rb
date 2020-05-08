class CreateJwtToken
  include Interactor

  delegate :user, to: :context

  def call
    context.token = token
  end

  private

  def token
    JWT.encode payload, nil, "none"
  end

  def payload
    { sub: user.id }
  end
end
