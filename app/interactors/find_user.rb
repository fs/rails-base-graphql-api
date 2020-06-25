class FindUser
  include Interactor

  delegate :email, to: :context

  def call
    context.fail! unless user

    context.user = user
  end

  private

  def user
    @user ||= User.find_by(email: email)
  end
end
