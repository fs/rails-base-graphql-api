class UpdateExistingRefreshToken
  include Interactor
  include AuthenticableInteractor

  TOKEN_GRACE_PERIOD = 60

  delegate :existing_refresh_token, :substitution_token, to: :context

  def call
    existing_refresh_token.assign_attributes(token_attributes)

    raise_unauthorized_error! unless existing_refresh_token.save
  end

  private

  def token_attributes
    {
      expires_at: TOKEN_GRACE_PERIOD.seconds.from_now,
      substitution_token: substitution_token
    }
  end
end
