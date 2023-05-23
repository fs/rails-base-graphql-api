class UpdatePassword
  class FindUserByToken
    include Interactor
    include AuthenticableInteractor

    delegate :reset_token, to: :context

    def call
      context.user = find_user

      raise_unauthorized_error! unless context.user
    end

    private

    def find_user
      User.find_by(password_reset_token: reset_token)
    end
  end
end
