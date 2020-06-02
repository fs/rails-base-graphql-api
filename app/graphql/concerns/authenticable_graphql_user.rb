module AuthenticableGraphqlUser
  extend ActiveSupport::Concern

  private

  def ready?(*)
    return true if current_user

    raise execution_error(authentication_error)
  end

  def authentication_error
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
end
