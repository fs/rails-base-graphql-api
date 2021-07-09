class ConfirmUser
  include Interactor

  delegate :value, to: :context

  def call
    context.fail!(error_data: error_data) if token.blank?

    user.update(confirmed_at: Time.current)
    token.destroy
  end

  private

  def token
    @token ||= PossessionToken.find_by(value: value)
  end

  def user
    context.user ||= token.user
  end

  def error_data
    { message: "Invalid value", status: 400, code: :bad_request }
  end
end
