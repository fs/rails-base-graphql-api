class CreatePossessionToken
  include Interactor

  TOKEN_LENGTH = 40

  delegate :user, to: :context

  def call
    context.possession_token = possession_token
  end

  private

  def possession_token
    PossessionToken.create(
      user_id: user.id,
      value: value
    )
  end

  def value
    SecureRandom.hex(TOKEN_LENGTH)
  end
end
