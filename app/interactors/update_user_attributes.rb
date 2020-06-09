class UpdateUserAttributes
  include Interactor

  delegate :user_params, :user, to: :context

  def call
    context.fail!(error_data: error_data) unless update_user_form.valid? && update_user
    context.everywhere = true if update_password?
  end

  private

  def update_user
    user.update(update_user_form.user_attributes)
  end

  def update_user_form
    @update_user_form ||= UpdateUserForm.new(user).assign_attributes(user_params)
  end

  def error_data
    { message: "Record Invalid", detail: update_user_form.errors.to_a }
  end

  def update_password?
    update_user_form.user_attributes.include?(:password)
  end
end
