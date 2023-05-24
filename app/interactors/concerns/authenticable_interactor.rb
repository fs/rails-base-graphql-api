module AuthenticableInteractor
  extend ActiveSupport::Concern

  private

  def raise_unauthorized_error!
    context.fail!(
      error_data: {
        message: "Invalid credentials",
        status: 401,
        code: :unauthorized
      }
    )
  end
end
