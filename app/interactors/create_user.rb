class CreateUser
  include Interactor

  delegate :user, :user_params, to: :context

  def call
    context.fail!(error_data: error_data) unless user.update(user_params)
  end

  private

  def error_data
    { message: "Record Invalid", detail: user.errors.to_a }
  end
end
