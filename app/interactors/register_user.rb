class RegisterUser
  include Interactor

  delegate :params, :user, to: :context

  def call
    context.user = User.new(params)

    context.fail! unless user.save
  end
end
