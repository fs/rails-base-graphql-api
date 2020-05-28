class UpdateUser
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.fail!(error_data: error_data(user)) unless update_user
  end

  private

  def update_user
    form = UpdateUserForm.new(user).assign_attributes(user_params)
    context.fail!(error_data: error_data(form)) unless form.valid?

    user.update(form.user_attributes)
  end

  def error_data(model)
    { message: "Record Invalid", detail: model.errors.to_a }
  end
end
