module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(email:, password:)
      result = CreateJwt.call(email: email, password: password)
      byebug
      if result.success?
        { user: result.user, token: result.token }
      else

      end
    end
  end
end
