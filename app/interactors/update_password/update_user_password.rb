class UpdatePassword
  class UpdateUserPassword
    include Interactor

    delegate :password, :user, to: :context

    def call
      context.fail!(error_data: error_data) unless update_user_password_form.valid? && update_user_password
    end

    private

    def update_user_password
      user.update(update_user_password_form.user_attributes)
    end

    def update_user_password_form
      @update_user_password_form ||= UpdateUserPasswordForm.new(user).assign_attributes(password: password)
    end

    def error_data
      { message: "Record Invalid", detail: update_user_password_form.errors.to_a }
    end
  end
end
