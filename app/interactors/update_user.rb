class UpdateUser
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    user.update(user_params)

    context.fail!(error_data: error_data) unless user.save
  end

  private

  def error_data
    { message: "Record Invalid", detail: context.user.errors.to_a }
  end
end
