class UpdateUser
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.fail!(error_data: error_data) unless update_user
  end

  private

  def update_user
    authenticated_user&.update(user_attributes)
  end

  def authenticated_user
    return user unless updating_password?

    user.authenticate(user_params[:current_password]) || context.fail!(error_data: auth_problem)
  end

  def user_attributes
    return user_params unless updating_password?

    user_params
      .except(:password, :current_password)
      .merge(password: user_params[:password])
  end

  def updating_password?
    user_params[:password].present?
  end

  def error_data
    { message: "Record Invalid", detail: context.user.errors.to_a }
  end

  def auth_problem
    { message: "Authentication failed" }
  end
end
