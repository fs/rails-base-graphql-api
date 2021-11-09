class CreatePossessionToken
  include Interactor

  delegate :user, to: :context

  def call
    context.possession_token = possession_token
  end

  private

  def possession_token
    PossessionToken.create(
      user_id: user.id,
      value: generate_value
    )
  end

  def generate_value
    generated_value = SecureRandom.hex(token_length)
    return generated_value unless PossessionToken.exists?(value: generated_value)

    generate_value
  end

  def token_length
    ENV.fetch("CONFIRMATION_TOKEN_LENGTH", 40).to_i
  end
end
