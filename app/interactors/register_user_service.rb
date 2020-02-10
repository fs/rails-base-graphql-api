class RegisterUserService
  include Interactor

  delegate :params, to: :context

  def call
    user = User.create(params)

    context.user = user
  end
end
