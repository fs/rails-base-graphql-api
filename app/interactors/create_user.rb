class CreateUser
  include Interactor

  delegate :user_params, to: :context

  def call
    context.user = User.new(user_params)

    context.fail!(error_data: error_data) unless context.user.save
  end

  private

  def error_data
    { message: "Record Invalid", detail: context.user.errors.to_a }
  end
end
