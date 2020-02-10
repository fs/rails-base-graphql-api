class RegisterUserService
  include Interactor

  def call
    user = User.new(params)

    if user.save
      context.user = user
    else

    end
  end
end
